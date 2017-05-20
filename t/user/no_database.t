use Mojo::Base -strict;

use Test::More;
use Test::Exception;
use Mojolicious::Lite;

app->config->{database} = [ 'dbi:SQLite::memory:' ];

plugin 'Sesbania::Plugin::Core';

dies_ok { plugin 'Sesbania::Plugin::User'; } 'Wont load without a database';

plugin 'Sesbania::Plugin::Database';

lives_ok { plugin 'Sesbania::Plugin::User'; } 'Loads with a database';

done_testing;
