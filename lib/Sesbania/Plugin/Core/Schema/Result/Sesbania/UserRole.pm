package Sesbania::Plugin::Core::Schema::Result::Sesbania::UserRole;

use DBIx::Class::Candy
  -autotable => v1;

column user_id => {
  data_type => 'int',
  is_foreign_key => 1,
};

column role_id => {
  data_type => 'int',
  is_foreign_key => 1,
};

unique_constraint [qw/ user_id role_id /];

belongs_to role => 'Sesbania::Plugin::Core::Schema::Result::Sesbania::Role', 'role_id';
belongs_to user => 'Sesbania::Plugin::Core::Schema::Result::Sesbania::User', 'user_id';

1;
