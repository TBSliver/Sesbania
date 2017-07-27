package Sesbania::Plugin::Database::Command::db_deploy;
use Mojo::Base 'Mojolicious::Command';

use Mojo::Util 'getopt';

has description => 'Basic database deployment';

has usage => sub { shift->extract_usage };

sub run {
  my ( $self, @args ) = @_;

  $self->app->db->deploy;
}

=head1 SYNOPSIS

  Usage: APPLICATION user_add [OPTIONS]

  Options:
    -c, --connection  Use this database connection

=cut

1;
