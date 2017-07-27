package Sesbania::Plugin::User::Controller::User::Admin;
use Mojo::Base 'Mojolicious::Controller';

has resultset => sub {
  return shift->db->resultset('Sesbania::User');
};

sub list {
  my $c = shift;
  $c->stash( users => $c->resultset, user_create_form => {
    type => 'inline',
    id => 'user_create_form',
    action => $c->url_for,
    method => 'post',
    inputs => [
      {
        label => 'Username',
        name => 'username',
        type => 'text',
        placeholder => 'Username',
        validator => 'required',
      },
      {
        label => 'Password',
        name => 'password',
        type => 'password',
        placeholder => 'Password',
        validator => 'required',
      },
    ],
    submit => {
      label => 'Add User',
      style => 'primary',
      size => 'inline',
    },
  } );
}

sub create {
  my $c = shift;

  my $validation = $c->validation;
  $validation->required('username')->not_in_resultset('username', $c->resultset);
  $validation->required('password');

  if ( $validation->has_error ) {
    $c->flash( error => "Error creating user" );
  } else {
    $c->resultset->create({
      map { $_ => $validation->param($_) } @{ $validation->passed },
    });
    $c->flash( success => "User Created" );
  }
  $c->redirect_to( '/admin/users' );
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
