package Sesbania;
use Mojo::Base 'Mojolicious';

# This method will run once at server start
sub startup {
  my $self = shift;

  # Load configuration from hash returned by "my_app.conf"
  my $config = $self->plugin('Config');

  $self->plugin('AssetPack' => {pipes => [qw/ Css JavaScript Combine /]});
  $self->app->asset->process;

  # Always requires core
  $self->plugin('Sesbania::Plugin::Core');

  # TODO Will we need configuration options for these?
  for my $plugin_name ( @{ $config->{plugins} } ) {
    $self->plugin($plugin_name);
  }
}

1;
