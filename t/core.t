use Mojo::Base -strict;

use Test::More;
use Test::Exception;
use Mojolicious::Lite;
use Test::Mojo;

lives_ok { plugin 'Sesbania::Plugin::Core' } 'Plugin Loaded';

ok app->sesbania_has_plugin('Sesbania::Plugin::Core'), 'plugin registered';

is_deeply app->sesbania_list_plugins, [ 'Sesbania::Plugin::Core' ], 'plugin listed';

is_deeply app->commands->namespaces, [ 'Mojolicious::Command' ], 'default command namespaces';

app->sesbania_register_commands('Test::Sesbania::Plugin::Testing');

is_deeply app->commands->namespaces, [ qw/
  Mojolicious::Command
  Test::Sesbania::Plugin::Testing::Command
/ ], 'added command namespaces';

is_deeply app->routes->namespaces, [], 'default route namespaces';

app->sesbania_register_controllers('Test::Sesbania::Plugin::Testing');

is_deeply app->routes->namespaces, [ 'Test::Sesbania::Plugin::Testing::Controller' ], 'added route namespaces';

is_deeply app->renderer->classes, [ 'main' ], 'default renderer classes';

app->sesbania_register_templates('Test::Sesbania::Plugin::Testing');

is_deeply app->renderer->classes, [ qw/
  main
  Test::Sesbania::Plugin::Testing::Templates
/ ], 'added renderer classes';

done_testing();
