package Sesbania::Plugin::Validators;
use Mojo::Base 'Mojolicious::Plugin';

use Scalar::Util qw/ looks_like_number /;

sub register {
  my ( $plugin, $app, $conf ) = @_;

  $app->validator->add_check( in_resultset => sub {
    my ( $validation, $name, $value, $key, $rs ) = @_;
    return $rs->search({ $key => $value })->count ? undef : 1;
  });

  $app->validator->add_check( not_in_resultset => sub {
    my ( $validation, $name, $value, $key, $rs ) = @_;
    return $rs->search({ $key => $value })->count ? 1 : undef;
  });

  $app->validator->add_check( number => sub {
    my ( $validation, $name, $value ) = @_;
    return looks_like_number( $value ) ? undef : 1;
  });

  $app->validator->add_check( gt_num => sub {
    my ( $validation, $name, $value, $check ) = @_;
    return $value > $check ? undef : 1;
  });

  $app->validator->add_check( lt_num => sub {
    my ( $validation, $name, $value, $check ) = @_;
    return $value < $check ? undef : 1;
  });
}

1;
