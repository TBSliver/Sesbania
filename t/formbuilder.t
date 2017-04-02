use Mojo::Base -strict;

use Test::More;
use Mojolicious::Lite;
use Test::Mojo;

plugin 'Sesbania::Plugin::FormBuilder';

get 'input' => sub {
  my $c = shift;
  $c->stash(
    input => {
      name => 'input',
      type => 'text',
      placeholder => 'My Input',
      validator => 'required',
    },
    sans_validator => {
      name => 'input',
      type => 'text',
      placeholder => 'My Input',
    }
  );
};

get 'form' => sub {
  my $c = shift;
  $c->stash(
    input => {
      id => 'form_id',
      inputs => [
        {
          name => 'name',
          type => 'text',
          placeholder => 'Full Name',
          validator => 'required',
        },
        {
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
          name => 'password',
          type => 'password',
          placeholder => 'Password',
          validator => 'required',
        },
      ],
    }
  );
};

my $t = Test::Mojo->new;

$t->get_ok('/input')->content_is(<<'EOF');
<input class="form-control validate[required]" name="input" placeholder="My Input" type="text">
<input class="form-control" name="input" placeholder="My Input" type="text">
EOF

$t->get_ok('/form')->content_is(
  '<form id="form_id">'
  . '<div class="form-group">'
  . '<input class="form-control validate[required]" id="form_id-name" name="name" placeholder="Full Name" type="text">'
  . '</div>'
  . '<div class="form-group">'
  . '<input class="form-control validate[required]" id="form_id-username" name="username" placeholder="Username" type="text">'
  . '</div>'
  . '<div class="form-group">'
  . '<label for="form_id-email">Email Address</label>'
  . '<input class="form-control validate[required,custom[email]]" id="form_id-email" name="email" placeholder="Email" type="email">'
  . '</div>'
  . '<div class="form-group">'
  . '<input class="form-control validate[required]" id="form_id-password" name="password" placeholder="Password" type="password">'
  . '</div>'
  . "</form>\n"
);

done_testing;

__DATA__
@@ input.html.ep
%= sesbania_input $input
%= sesbania_input $sans_validator

@@ form.html.ep
%= sesbania_form_builder $input
