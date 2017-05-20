package Sesbania::Plugin::Core;
use Mojo::Base 'Mojolicious::Plugin';

use Mojo::Loader qw/ load_class /;

has loaded_plugins => sub { {} };

sub register {
  my ( $self, $app ) = @_;

  $app->helper(
    sesbania_register_plugin => sub {
      my ( $c, $plugin_name ) = @_;
      warn "Plugin Already Loaded" if defined $self->loaded_plugins->{ $plugin_name };
      $self->loaded_plugins->{ $plugin_name }++
    }
  );

  $app->helper(
    sesbania_has_plugin => sub {
      my ( $c, $plugin_name ) = @_;
      return $self->loaded_plugins->{ $plugin_name };
    }
  );

  $app->helper(
    sesbania_list_plugins => sub {
      my ( $c ) = @_;
      return [ sort keys %{ $self->loaded_plugins } ];
    }
  );

  $app->helper(
    sesbania_register_commands => sub {
      my ( $c, $plugin_name ) = @_;
      push @{ $app->commands->namespaces }, $plugin_name . '::Command';
    }
  );

  $app->helper(
    sesbania_register_controllers => sub {
      my ( $c, $controller_name ) = @_;
      push @{ $app->routes->namespaces }, $controller_name . '::Controller';
    }
  );

  $app->helper(
    sesbania_register_templates => sub {
      my ( $c, $class_name ) = @_;
      my $template_name = $class_name . '::Templates';
      load_class $template_name;
      push @{ $app->renderer->classes }, $template_name;
    }
  );

  $app->sesbania_register_plugin( __PACKAGE__ );
}

1;
