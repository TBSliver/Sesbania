package Sesbania::Controller::Signup;
use Mojo::Base 'Mojolicious::Controller';

sub index {
  my $c = shift;

  $c->stash(signup_form => {
    id => 'signup_form',
    inputs => [
      {
        label => 'Your Full Name',
        name => 'name',
        type => 'text',
        placeholder => 'Full Name',
        validator => 'required',
      },
      {
        label => 'Username',
        name => 'username',
        type => 'text',
        placeholder => 'Username',
        validator => 'required',
      },
      {
        label => 'Email Address',
        name => 'email',
        type => 'email',
        placeholder => 'Email',
        validator => 'required,custom[email]',
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
      label => 'Signup',
      style => 'success',
    }
  });
}

1;
