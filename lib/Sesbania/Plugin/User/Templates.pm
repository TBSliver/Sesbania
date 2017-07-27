package Sesbania::Plugin::User::Templates;

1;
__DATA__

@@ user/admin/list.html.ep
% layout 'admin_full';
% title 'User Admin';
<h1>User Admin</h1>
% if ( my $error = flash 'error' ) {
  <div class="alert alert-danger" role="alert">
  <strong>Error!</strong> <%= $error %>
  </div>
% } elsif ( my $success = flash 'success' ) {
  <div class="alert alert-success" role="alert">
  <strong>Success!</strong> <%= $success %>
  </div>
% }
%= sesbania_form_builder $user_create_form
% for my $user ( $users->all ) {
<p><%= $user->username %></p>
% }
