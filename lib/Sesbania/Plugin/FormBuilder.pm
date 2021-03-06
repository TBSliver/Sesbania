package Sesbania::Plugin::FormBuilder;
use Mojo::Base 'Mojolicious::Plugin';

use Sesbania::Utils::TagHelpers ':all';

sub register {
  my ($self, $app) = @_;

  $app->helper(sesbania_form_builder => sub{ _render_byte_tree(_form_builder(@_)) });
  $app->helper(sesbania_input => sub{ _render_byte_tree(_input(@_)) });
}

=head2 sesbania_form_builder

  $c->sesbania_form_builder({
    id => 'form_id',
    inputs => [
      {
        label => 'Full Name',
        name => 'name',
        type => 'text',
        placeholder => 'Full Name',
        validator => 'required',
      },
      {
        label => 'Username',
        name => 'username',
        type => 'text',
        placeholder => 'Username',
        validator => 'required',
      },
      {
        label => 'Email Address',
        name => 'email',
        type => 'email',
        placeholder => 'Email',
        validator => 'required,custom[email]',
      },
      {
        label => 'Password',
        name => 'password',
        type => 'password',
        placeholder => 'Password',
        validator => 'required',
      },
    ],
    submit => {
      label => 'Signup',
      style => 'success',
    }
  });

=cut

sub _form_builder {
  my ($c, $form_args) = @_;

  my @form;
  for my $input ( @{$form_args->{inputs}} ) {
    $input->{id} = join '-', $form_args->{id}, $input->{name};
    my @form_group;
    push @form_group, _label($c, delete $input->{label}, $input->{id})
      if exists $input->{label};
    push @form_group, _input($c, $input);
    push @form, _form_group($c, @form_group);
  }
  if ( defined $form_args->{submit} ) {
    push @form, _submit_button(
      $c,
      $form_args->{submit}->{label},
      $form_args->{submit}->{style},
      $form_args->{submit}->{size},
    );
  }
  my $form_attrs = {
    ( map { defined $form_args->{$_} ? ( $_ => $form_args->{$_} ) : () } qw/ id action method / ),
    ( defined $form_args->{type}
      ? $form_args->{type} eq 'inline'
        ? ( class => 'form-inline' )
        : ()
      : ()
    )
  };
  return _tag( 'form', $form_attrs, _root( @form ) );
}

sub _submit_button {
  my ($c, $label, $style, $size) = @_;
  my $class = sprintf(
    "btn %s btn-%s",
    defined $size ? $size eq 'block' ? "btn-block" : '' : 'btn-block',
    defined $style ? $style : 'default',
  );
  return _tag( 'button', { class => $class, type => 'submit' }, _text( $label ) );
}

sub _form_group {
  my ($c, @children) = @_;

  return _tag( 'div', { class => 'form-group' }, _root( @children ) );
}

sub _label {
  my ($c, $label, $for) = @_;
  return _tag(
    'label',
    { defined $for ? (for => $for) : () },
    _text( $label )
  );
}

=head2 _input

Render an input with the optional validator

=cut

sub _input {
  my ($c, $input_args) = @_;

  my $validator = delete $input_args->{validator};

  my $class = "form-control";

  if (defined $validator) {
    $class = sprintf( '%s validate[%s]', $class, $validator );
  }

  my $output = _tag( 'input', { %$input_args, class => $class });

  return $output;
}

1;
