package Sesbania::Plugin::User::Schema::Result::Sesbania::User;

use DBIx::Class::Candy
  -autotable => v1,
  -components => ['PassphraseColumn'];

primary_column id => {
  data_type => 'int',
  is_auto_increment => 1,
};

unique_column username => {
  data_type => 'varchar',
  size => 255,
  is_nullable => 0,
};

column password => {
  data_type => 'varchar',
  size => 100,
  passphrase => 'crypt',
  passphrase_class => 'BlowfishCrypt',
  passphrase_args => {
    salt_random => 1,
    cost => 8,
  },
  passphrase_check_method => 'check_password',
};

has_many user_roles => 'Sesbania::Plugin::User::Schema::Result::Sesbania::UserRole', 'user_id';
many_to_many roles => 'user_roles', 'role_id';

has_many details => 'Sesbania::Plugin::User::Schema::Result::Sesbania::UserDetails', 'user_id';

1;
