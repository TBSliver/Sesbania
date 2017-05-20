package Sesbania::Plugin::Pages;
use Mojo::Base 'Mojolicious::Plugin';

use Sesbania::Utils::TagHelpers ':all';

sub register {
  my ( $self, $app ) = @_;

  $app->sesbania_register_plugin( __PACKAGE__ );
  $app->sesbania_register_templates( __PACKAGE__ );
  $app->sesbania_register_controllers( __PACKAGE__ );
  $app->add_db_namespace( __PACKAGE__ . '::Schema' );

  my $all_routes = $app->routes->under('/')->to('pages-root#auth');
  $all_routes->any('/*path')->to('pages-root#show');

  $app->helper( sesbania_pages_head => sub {
    _render_byte_tree( _pages_head( @_ ) );
  });

  $app->helper( sesbania_pages_body => sub {
    _render_byte_tree( _pages_body( @_ ) );
  });
}

sub _pages_head {
  my $c = shift;

  my $head = $c->render_to_string( inline => $c->stash->{head} );
  return _tag( 'head', {}, _root( [ 'raw', $head ] ) );
}

sub _pages_body {
  my $c = shift;

  return [ 'raw', $c->stash->{ body } ];
}

1;
