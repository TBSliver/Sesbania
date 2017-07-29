package Sesbania::Plugin::Core;
use Mojo::Base 'Mojolicious::Plugin';

use Mojo::Loader qw/ load_class /;
use Sesbania::Plugin::Core::Schema;

has 'app';

has config => sub { shift->app->config->{sesbania} };

has loaded_plugins => sub { {} };

has schema => sub {
  my $self = shift;
  return Sesbania::Plugin::Core::Schema->connect(
    $self->config->{database}->{dsn},
    $self->config->{database}->{username},
    $self->config->{database}->{password},
  );
};

has admin_route => sub { return shift->config->{admin_route} || 'admin' };

has admin_public_route => sub {
  my $self = shift;
  return $self->app->routes->any( '/' . $self->admin_route );
};

has admin_private_route => sub {
  my $self = shift;
  return $self->app->routes->under( '/' . $self->admin_route )
    ->to('admin-root#auth');
};

has admin_sidebar_items => sub { [] };

sub register {
  my ( $self, $app ) = @_;

  $app->plugin('Config');
  $app->plugin('AssetPack' => {pipes => [qw/ Css JavaScript Combine /]});
  $app->asset->process;

  $app->plugin('Sesbania::Plugin::FormBuilder');
  $app->plugin('Sesbania::Plugin::Validators');

  $self->app( $app );

  $app->helper(
    sesbania_register_plugin => sub {
      my ( $c, $plugin_name ) = @_;
      warn "Plugin Already Loaded"
        if defined $self->loaded_plugins->{ $plugin_name };
      $self->loaded_plugins->{ $plugin_name }++
    }
  );

  $app->helper(
    sesbania_has_plugin => sub {
      my ( $c, $plugin_name ) = @_;
      return $self->loaded_plugins->{ $plugin_name };
    }
  );

  $app->helper(
    sesbania_list_plugins => sub {
      my ( $c ) = @_;
      return [ sort keys %{ $self->loaded_plugins } ];
    }
  );

  $app->helper(
    sesbania_register_commands => sub {
      my ( $c, $plugin_name ) = @_;
      push @{ $app->commands->namespaces }, $plugin_name . '::Command';
    }
  );

  $app->helper(
    sesbania_register_controllers => sub {
      my ( $c, $controller_name ) = @_;
      push @{ $app->routes->namespaces }, $controller_name . '::Controller';
    }
  );

  $app->helper(
    sesbania_register_templates => sub {
      my ( $c, $class_name ) = @_;
      my $template_name = $class_name . '::Templates';
      load_class $template_name;
      push @{ $app->renderer->classes }, $template_name;
    }
  );

  $app->helper(
    sesbania_register_db_namespace => sub {
      my ( $c, $class_name ) = @_;
      # Namespaces require a plus at the beginning to set up correctly outside
      # of the current namespace
      my $namespace = $class_name . '::Schema';
      my $result_ns = sprintf('+%s::Result', $namespace);
      my $resultset_ns = sprintf('+%s::ResultSet', $namespace);
      $self->schema->load_namespaces(
        result_namespace => $result_ns,
        resultset_namespace => $resultset_ns,
      );
    }
  );

  $app->helper( sesbania_db => sub { return $self->schema } );

  $app->helper( sesbania_admin_add_public_route => sub {
    my ( $c, $methods, $sub_route, $args, $name ) = @_;
    $self->admin_public_route->route( $sub_route )
      ->via( ref( $methods ) eq 'ARRAY' ? @$methods : $methods )
      ->to( $args )
      ->name( $name );
  });

  $app->helper( sesbania_admin_add_private_route => sub {
    my ( $c, $methods, $sub_route, $args, $name ) = @_;
    $self->admin_private_route->route( $sub_route )
      ->via( ref( $methods ) eq 'ARRAY' ? @$methods : $methods )
      ->to( $args )
      ->name( $name );
  });

  $app->helper( sesbania_admin_add_sidebar_item => sub {
    my ( $c, $item ) = @_;
    push @{ $self->admin_sidebar_items }, $item;
  });

  $app->helper( sesbania_admin_sidebar_items => sub {
    my ( $c ) = @_;
    return sort { $a->{text} cmp $b->{text} } @{ $self->admin_sidebar_items };
  });

  $app->sesbania_admin_add_public_route( 'GET', '/',
    'admin-root#get_login', 'sesbania-admin-login-get' );
  $app->sesbania_admin_add_public_route( 'POST', '/',
    'admin-root#post_login', 'sesbania-admin-login-post' );

  $app->sesbania_admin_add_private_route( 'GET', '/index',
    'admin-root#index', 'sesbania-admin-root-index' );
  $app->sesbania_admin_add_private_route( 'GET', '/users',
    'admin-user#list', 'sesbania-admin-user-list' );
  $app->sesbania_admin_add_private_route( 'POST', '/users',
    'admin-user#create', 'sesbania-admin-user-list' );
  $app->sesbania_admin_add_private_route( 'GET', '/users/:id',
    'admin-user#read', 'sesbania-admin-user-list' );
  $app->sesbania_admin_add_private_route( 'POST', '/users/:id',
    'admin-user#update', 'sesbania-admin-user-list' );
  $app->sesbania_admin_add_private_route( 'GET', '/users/:id/delete',
    'admin-user#delete', 'sesbania-admin-user-list' );

  $app->sesbania_admin_add_sidebar_item({
    link => 'sesbania-admin-root-index',
    text => 'Home',
  });
  $app->sesbania_admin_add_sidebar_item({
    link => 'sesbania-admin-user-list',
    text => 'Users',
  });

  # Actually do the setup
  $app->sesbania_register_plugin( __PACKAGE__ );
  $app->sesbania_register_commands( __PACKAGE__ );
  $app->sesbania_register_templates( __PACKAGE__ );
  $app->sesbania_register_controllers( __PACKAGE__ );
  $app->sesbania_register_db_namespace( __PACKAGE__ );
}

1;
