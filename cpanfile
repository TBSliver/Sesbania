requires 'Mojolicious';
requires 'Mojolicious::Plugin::AssetPack';
requires 'CSS::Minifier::XS';
requires 'JavaScript::Minifier::XS';
# For fetching assets over SSL
requires 'IO::Socket::SSL';
requires 'DBIx::Class';
requires 'DBIx::Class::Candy';

on 'test' => sub {
  requires 'Test::More';
  requires 'Test::Exception';
  requires 'Test::Warnings';
};
