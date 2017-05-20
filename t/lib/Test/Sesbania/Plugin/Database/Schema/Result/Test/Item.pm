package Test::Sesbania::Plugin::Database::Schema::Result::Test::Item;

use DBIx::Class::Candy -autotable => v1;

table 'sesbania_test_item';

primary_column id => {
  data_type => 'int',
  is_auto_increment => 1,
};

column text => {
  data_type => 'varchar',
  size => 255,
  is_nullable => 1,
};

1;
