package Sesbania::Plugin::Core::Command::sesbania_db_deploy;
use Mojo::Base 'Mojolicious::Command';

use Mojo::Util 'getopt';

has description => 'Basic database deployment';

has usage => sub { shift->extract_usage };

sub run {
  my ( $self, @args ) = @_;

  $self->app->sesbania_db->deploy;
}

=head1 SYNOPSIS

  Usage: APPLICATION sesbania_db_deploy [OPTIONS]

=cut

1;
