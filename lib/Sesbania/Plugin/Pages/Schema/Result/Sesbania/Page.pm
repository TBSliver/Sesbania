package Sesbania::Plugin::Pages::Schema::Result::Sesbania::Page;

use DBIx::Class::Candy
  -autotable => v1;

primary_column id => {
  data_type => 'int',
  is_auto_increment => 1,
};

unique_column path => {
  data_type => 'varchar',
  size => 255,
  is_nullable => 0,
};

column head => {
  data_type => 'text',
  is_nullable => 0,
};

column body => {
  data_type => 'text',
  is_nullable => 0,
};

1;
