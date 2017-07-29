package Sesbania;
use Mojo::Base 'Mojolicious';

# This method will run once at server start
sub startup {
  my $self = shift;

  # Always requires core
  $self->plugin('Sesbania::Plugin::Core');
}

1;
