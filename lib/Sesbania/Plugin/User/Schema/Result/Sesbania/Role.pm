package Sesbania::Plugin::User::Schema::Result::Sesbania::Role;

use DBIx::Class::Candy
  -autotable => v1;

primary_column id => {
  data_type => 'int',
  is_auto_increment => 1,
};

unique_column key => {
  data_type => 'varchar',
  size => 255,
  is_nullable => 0,
};

column name => {
  data_type => 'varchar',
  size => 255,
  is_nullable => 1,
};

column description => {
  data_type => 'text',
  is_nullable => 1,
};

has_many role_users => 'Sesbania::Plugin::User::Schema::Result::Sesbania::UserRole', 'role_id';
many_to_many users => 'role_users', 'user_id';

1;
