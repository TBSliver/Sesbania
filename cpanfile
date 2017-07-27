requires 'Mojolicious';
requires 'Mojolicious::Plugin::AssetPack';
requires 'CSS::Minifier::XS';
requires 'JavaScript::Minifier::XS';
# For fetching assets over SSL
requires 'IO::Socket::SSL';
requires 'DBIx::Class';
requires 'DBIx::Class::Candy';
requires 'DBIx::Class::PassphraseColumn';

on 'test' => sub {
  requires 'Test::More';
  requires 'Test::Exception';
  requires 'Test::Warnings';
};
