package Sesbania::Plugin::User::Controller::User::Admin;
use Mojo::Base 'Mojolicious::Controller';

has resultset => sub {
  return shift->db->resultset('Sesbania::User');
};

sub list {
  my $c = shift;
  $c->stash( users => $c->resultset );
}

sub create {
  my $c = shift;
}

sub read {
  my $c = shift;
}

sub update {
  my $c = shift;
}

sub delete {
  my $c = shift;
}

1;
