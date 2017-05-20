package Sesbania::Plugin::Admin;
use Mojo::Base 'Mojolicious::Plugin';

has 'parent_route';
has 'admin_route';
has 'sidebar_items' => sub { [] };

sub register {
  my ( $self, $app ) = @_;

  $app->sesbania_register_plugin( __PACKAGE__ );

  $app->sesbania_register_controllers( __PACKAGE__ );

  # Add main admin route, and make it go via ::Controller::Admin::Root::auth
  # TODO Make this a settable option?
  $self->parent_route( $app->routes->any('/admin') );
  $self->admin_route( $app->routes->under('/admin')->to('admin-root#auth') );

  # Register main login form
  $self->parent_route->get('/')->to('admin-root#get_login');
  $self->parent_route->post('/')->to('admin-root#post_login');

  # $c->sesbania_admin_add_route( [
  $app->helper( sesbania_admin_add_route => sub {
    my ( $c, $methods, $sub_route, $args ) = @_;
    $self->admin_route->route( $sub_route )
      ->via( ref( $methods ) eq 'ARRAY' ? @$methods : $methods )->to( $args );
  });

  $app->helper( sesbania_admin_add_sidebar_item => sub {
    my ( $c, $item ) = @_;
    push @{ $self->sidebar_items }, $item;
  });
  $app->helper( sesbania_admin_sidebar_items => sub {
    my ( $c ) = @_;
    return sort { $a->{text} cmp $b->{text} } @{ $self->sidebar_items };
  });


  $app->sesbania_admin_add_route( 'GET', '/index', 'admin-root#index' );

  $app->sesbania_register_templates( __PACKAGE__ );
}

1;
