package Sesbania::Plugin::Admin::Controller::Admin::Root;
use Mojo::Base 'Mojolicious::Controller';

sub get_login {
  my $c = shift;

  $c->stash( login_form => {
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
  $c->render( template => 'admin/root/login' );
}

sub post_login {
  my $c = shift;

  $c->app->log->debug('Checking Login');
  $c->app->log->debug(sprintf "Username: [%s]", $c->param( 'username' ) || '');
  $c->app->log->debug(sprintf "Password: [%s]", $c->param( 'password' ) || '');
  return $c->redirect_to('/admin/index') if $c->param( 'username' ) eq 'test@example.com';
  $c->app->log->debug('Failed Redirect');
  $c->redirect_to('/admin');
}

sub auth {
  my $c = shift;
  return 1;
}

sub index {
  my $c = shift;

}

1;
