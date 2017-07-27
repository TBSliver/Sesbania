package Sesbania::Plugin::Admin::Templates;

1;
__DATA__

@@ layouts/admin.html.ep
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
      <%= content %>
    </main>
    <!-- Javascript at the end as is best practice -->
    %= asset 'app.js';
    %= content_for 'javascript';
  </body>
</html>

@@ admin/root/login.html.ep
% layout 'admin';
% title 'Admin Login';
<div class="row">
  <div class="col-md-4 col-md-offset-4">
    <h1>Login</h1>
    %= sesbania_form_builder $login_form
  </div>
</div>

@@ admin/root/index.html.ep
% layout 'admin';
% title 'Admin Home';
<div class="row">
  <div class="col-md-4">
    <h4>Admin Menu</h4>
    <ul class="nav nav-stacked">
      % for my $item ( my @items = sesbania_admin_sidebar_items ) {
      <li><a href="<%= url_for $item->{link} %>"><%= $item->{text} %></a></li>
      % }
  </div>
  <div class="col-md-8">
    <h1>Main Admin</h1>
  </div>
</div>
