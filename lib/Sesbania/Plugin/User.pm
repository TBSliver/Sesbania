package Sesbania::Plugin::User;
use Mojo::Base 'Mojolicious::Plugin';

sub register {
  my ( $self, $app ) = @_;

  die "Needs the Sesbania Database plugin" unless $app->sesbania_has_plugin( 'Sesbania::Plugin::Database' );

  $app->sesbania_register_plugin( __PACKAGE__ );
  $app->sesbania_register_commands( __PACKAGE__ );
  $app->sesbania_register_templates( __PACKAGE__ );
  $app->sesbania_register_controllers( __PACKAGE__ );

  $app->add_db_namespace( __PACKAGE__ . '::Schema' );

  if ( $app->sesbania_has_plugin( 'Sesbania::Plugin::Admin' ) ) {
    $app->sesbania_admin_add_route( 'GET', '/users', 'user-admin#list' );
    $app->sesbania_admin_add_route( 'POST', '/users', 'user-admin#create' );
    $app->sesbania_admin_add_route( 'GET', '/users/:id', 'user-admin#read' );
    $app->sesbania_admin_add_route( 'POST', '/users/:id', 'user-admin#update' );
    $app->sesbania_admin_add_route( 'GET', '/users/:id/delete', 'user-admin#delete' );
    $app->log->debug('Adding User Sidebar Items');
    $app->sesbania_admin_add_sidebar_item({
      link => '/admin/users',
      text => 'Users',
    });
  }
}

1;
