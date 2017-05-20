package Sesbania::Plugin::User::Schema::Result::User::User;

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

1;
