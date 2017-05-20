use Mojo::Base -strict;

use Test::More;
use Mojolicious::Lite;
use Test::Mojo;

app->config->{database} = [ 'dbi:SQLite::memory:' ];

plugin 'Sesbania::Plugin::Core';
plugin 'Sesbania::Plugin::Database';
my $t = Test::Mojo->new;

isa_ok $t->app->db, 'DBIx::Class::Schema';

done_testing;
