package Sesbania::Plugin::FormBuilder;
use Mojo::Base 'Mojolicious::Plugin';

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
  return _tag( 'form', { id => $form_args->{id} }, _root( @form ) );
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
    $class = sprintf( '%s validator[%s]', $class, $validator );
  }

  my $output = _tag( 'input', { %$input_args, class => $class });

  return $output;
}

=head2

Node array:

  0. Node Type
  1. Tag Name (if tag), Raw Content (if raw), Names
  2. attributes (id, class etc.
  3. Namespace (for xml stuff)
  4. Child array

=cut

=head2 _root

This takes an array of nodes and returns a root node array

=cut

sub _root {
  return ['root', @_];
}

=head2 _text

This takes a text block to render inside a tag

=cut

sub _text {
  return ['text', @_];
}

=head2 _tag

This takes a tag name, attributes and an arrayref of children nodes.

=cut

sub _tag {
  my $name = shift;
  my $attributes = shift;
  my $children = shift;

  return ['tag', $name, $attributes, undef, $children];
}

sub _render_byte_tree {
  return _render_bytestream(_render_tree(shift));
}

sub _render_tree {
  return Mojo::DOM::HTML::_render(shift);
}

sub _render_bytestream {
  return Mojo::ByteStream->new(shift);
}

1;
