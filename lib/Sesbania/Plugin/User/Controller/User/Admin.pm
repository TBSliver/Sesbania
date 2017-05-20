package Sesbania::Plugin::User::Controller::User::Admin;
use Mojo::Base 'Mojolicious::Controller';

has resultset => sub {
  return shift->db->resultset('User::User');
};

sub list {
  my $c = shift;
  $c->stash( users => $self->resultset );
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
