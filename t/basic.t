use Mojo::Base -strict;

use Test::More skip_all => 'Basic test requires work';
use Test::Mojo;

my $t = Test::Mojo->new('Sesbania');
$t->get_ok('/')->status_is(200);

done_testing();
