package Sesbania::Plugin::Core::Schema::Result::Sesbania::UserDetail;

use DBIx::Class::Candy
  -autotable => v1;

primary_column id => {
  data_type => 'int',
  is_auto_increment => 1,
};

column user_id => {
  data_type => 'int',
  is_foreign_key => 1,
};

column key => {
  data_type => 'varchar',
  size => 255,
  is_nullable => 0,
};

column value => {
  data_type => 'text',
};

belongs_to user => 'Sesbania::Plugin::Core::Schema::Result::Sesbania::User', 'user_id';

1;
