use Mojo::Base -strict;

use Test::More;
use Mojolicious::Lite;
use Test::Mojo;

app->config->{database} = [ 'dbi:SQLite::memory:' ];

plugin 'Sesbania::Plugin::Core';
plugin 'Sesbania::Plugin::Database';
plugin 'Sesbania::Plugin::User';

my $t = Test::Mojo->new;

isa_ok $t->app->db, 'DBIx::Class::Schema';

$t->app->db->deploy;

my $user_rs = $t->app->db->resultset('User::User');

is $user_rs->count, 0, 'No Users';

my $new_user = $user_rs->create({
  username => 'test',
  password => 'testing',
});

isa_ok $new_user->password, 'Authen::Passphrase::BlowfishCrypt';

is $user_rs->count, 1, 'One User';

ok $user_rs->first->check_password('testing'), 'Password check succeeded';

done_testing;
