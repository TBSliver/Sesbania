package Sesbania::Plugin::Core::Command::sesbania_user_add;
use Mojo::Base 'Mojolicious::Command';

use Mojo::Util 'getopt';

has description => 'Add user to application';

has usage => sub { shift->extract_usage };

sub run {
  my ( $self, @args ) = @_;

  getopt \@args,
    'u|username=s' => \my $username;

  die "Must define username" unless defined $username;
}

=head1 SYNOPSIS

  Usage: APPLICATION user_add [OPTIONS]

  Options:
    -u, --username Add this user

=cut

1;
