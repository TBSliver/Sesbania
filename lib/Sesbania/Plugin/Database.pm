package Sesbania::Plugin::Database;
use Mojo::Base 'Mojolicious::Plugin';

use Sesbania::Plugin::Database::Schema;

=head2 Config

Requires a connection to a database. For now this is passed directly to a DBIC
connect.

  # myapp.conf
  {
    database => [
      'dbi:SQLite:database.db',
    ],
  }

=cut

has config => sub { {} };

has schema => sub {
  my $self = shift;
  return Sesbania::Plugin::Database::Schema->connect(@{ $self->config });
};

sub register {
  my ( $self, $app ) = @_;

  $app->sesbania_register_plugin( __PACKAGE__ );
  $app->sesbania_register_commands( __PACKAGE__ );

  $self->config( $app->config->{database} );

  $app->helper(add_db_namespace => sub {
    my $c = shift;
    my $namespace = shift;
    my $result_ns = sprintf('+%s::Result', $namespace);
    my $resultset_ns = sprintf('+%s::ResultSet', $namespace);
    $self->schema->load_namespaces(
      result_namespace => $result_ns,
      resultset_namespace => $resultset_ns,
    );
  });


  $app->helper(db => sub {
    my $c = shift;
    return $self->schema;
  });
}

1;
