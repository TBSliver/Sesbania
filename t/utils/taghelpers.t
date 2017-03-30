use strict;
use warnings;

use Test::More;

use Sesbania::Utils::TagHelpers ':all';

my $div_args = [
  'tag',
  'div',
  {
    class => 'my-class',
    id => 'my-id',
  },
  undef,
  [ 'child' ]
];

my $div_tag = _tag( @$div_args[1,2,4] );

is_deeply( $div_tag, $div_args, 'tag output as expected' );

done_testing;
