package Sesbania::Plugin::Core::Templates;

1;
__DATA__

@@ layouts/sesbania/admin_base.html.ep
<!DOCTYPE html>
<html>
  <head>
    %= asset 'app.css';
    <style>
      body { padding-top: 50px; }
    </style>
    <title><%= title %></title>
  </head>
  <body>
    <nav class="navbar navbar-default navbar-fixed-top">
      <div class="container-fluid">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#nav-menu" aria-expanded="false">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="navbar-brand" href="/">Sesbania</a>
        </div>
        <div class="collapse navbar-collapse navbar-right" id="nav-menu">
          <ul class="nav navbar-nav">
            <li><a href="#">Link</a></li>
          </ul>
        </div>
      </div>
    </nav>
    <main class="container">
      <%= content 'body' %>
    </main>
    <!-- Javascript at the end as is best practice -->
    %= asset 'app.js';
    %= content_for 'javascript';
  </body>
</html>

@@ layouts/sesbania/admin_full.html.ep
% layout 'sesbania/admin_base';
% content body => begin
<div class="row">
  <div class="col-md-4">
    <h4>Admin Menu</h4>
    <ul class="nav nav-stacked">
      % for my $item ( my @items = sesbania_admin_sidebar_items ) {
      <li><a href="<%= url_for $item->{link} %>"><%= $item->{text} %></a></li>
      % }
  </div>
  <div class="col-md-8">
    <%= content %>
  </div>
</div>
% end

@@ sesbania/admin/root/login.html.ep
% layout 'sesbania/admin_base';
% title 'Admin Login';
% content body => begin
<div class="row">
  <div class="col-md-4 col-md-offset-4">
    <h1>Login</h1>
    %= sesbania_form_builder $login_form
  </div>
</div>
% end

@@ sesbania/admin/root/index.html.ep
% layout 'sesbania/admin_full';
% title 'Admin Home';
<h1>Main Admin</h1>

@@ sesbania/admin/user/list.html.ep
% layout 'sesbania/admin_full';
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
