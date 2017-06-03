use Mojo::Base -strict;

use Test::More;
use Mojolicious::Lite;
use Test::Mojo;

app->config->{database} = [ 'dbi:SQLite::memory:' ];

get '/testing' => sub {
  my $c = shift;

  $c->render(text => 'Path Override');
};

plugin 'Sesbania::Plugin::Core';
plugin 'Sesbania::Plugin::Database';
plugin 'Sesbania::Plugin::Pages';

my $schema = app->db;
$schema->deploy;

$schema->resultset('Sesbania::Page')->create({
  path => '',
  head => '<title>Testing</title>',
  body => '<h1>Testing</h1><p>This is only a test</p>',
});

# Create the basic page

my $t = Test::Mojo->new;

$t->get_ok('/')
  ->status_is(200)
  ->content_is(qq~<!DOCTYPE html>
<html>
<head><title>Testing</title>
</head>
<body><h1>Testing</h1><p>This is only a test</p>
</body>
</html>
~);

$t->get_ok('/testing')
  ->status_is(200)
  ->content_is('Path Override');

done_testing();
