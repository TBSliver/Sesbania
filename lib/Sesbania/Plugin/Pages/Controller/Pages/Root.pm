package Sesbania::Plugin::Pages::Controller::Pages::Root;
use Mojo::Base 'Mojolicious::Controller';

sub auth {
  my $c = shift;

  # Currently only public routes
  return 1;
}

sub show {
  my $c = shift;

  my $template_string = q~
%= sesbania_form_builder $form
<div><h2>This is only a test</h2></div>
<div><%= 2 + 2 %></div>
<div><%= $testing %></div>
~;

  $c->stash( form => { 
    id => 'login_form',
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
      label => 'Login',
      style => 'primary',
    },
  });

  $c->stash( testing => 'This is only a test' );

  $c->stash( head => '<title>Testing</title>' );

  $c->stash( body => $c->render_to_string( inline => $template_string ) );

  $c->render( template => 'pages/root/show' );
}

1;
