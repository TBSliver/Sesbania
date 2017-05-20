use Mojo::Base -strict;

use FindBin qw/ $Bin /;
use lib "$Bin/../lib";

use Test::More;
use Mojolicious::Lite;
use Test::Mojo;

app->config->{database} = [ 'dbi:SQLite::memory:' ];

plugin 'Sesbania::Plugin::Core';
plugin 'Sesbania::Plugin::Database';

app->add_db_namespace('Test::Sesbania::Plugin::Database::Schema');

app->db->deploy;

my $t = Test::Mojo->new;

isa_ok $t->app->db, 'DBIx::Class::Schema';

my $test_item_rs = $t->app->db->resultset('Test::Item');

is $test_item_rs->count, 0, 'No entries to start with';

my $result = $test_item_rs->create({
  text => 'This is only a test',
});

ok defined $result, 'Created entry successfully';

is $test_item_rs->count, 1, 'Found an entry';

is $test_item_rs->first->text, 'This is only a test', 'Entry is correct';

done_testing;
