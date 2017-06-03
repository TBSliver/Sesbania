package Sesbania::Plugin::Pages::Controller::Pages::Root;
use Mojo::Base 'Mojolicious::Controller';

sub auth {
  my $c = shift;

  # Currently only public routes
  return 1;
}

sub show {
  my $c = shift;

  my $path = $c->req->url->path;
  $path =~ s!^/!!;

  my $page_result = $c->db->resultset('Sesbania::Page')->find({ path => $path });

  if ( defined $page_result ) {
    $c->stash(
      head => $page_result->head,
      body => $page_result->body,
    );
    return $c->render( template => 'pages/root/show' );
  }

  $c->stash(
    head => "<title>Boom!</title>",
    body => "<p>something went wrong</p>",
  );

  $c->render( status => 404, template => 'pages/root/show' );
}

1;
