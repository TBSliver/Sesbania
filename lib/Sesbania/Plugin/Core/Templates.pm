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
    %= asset 'sesbania-admin.js';
  </body>
</html>

@@ layouts/sesbania/admin_full.html.ep
% layout 'sesbania/admin_base';
% content body => begin
<div class="row">
  <div class="col-md-2">
    <h4>Admin Menu</h4>
    <ul class="nav nav-stacked">
      % for my $item ( my @items = sesbania_admin_sidebar_items ) {
      % my $collapse_count = 0;
        % if ( defined $item->{children} ) {
          % my $collapse_id = 'collapse_' . $collapse_count;
          % $collapse_count++;
          % my @child_links = ( map { url_for $_->{link} } @{ $item->{children} } );
          % my $current_url = url_for;
          % my $active_route = scalar( grep( /^${current_url}$/, @child_links ) );
          <li>
            <a href="#<%= $collapse_id %>" data-toggle="collapse"><%= $item->{text} %>
            <i class="fa fa-chevron-down pull-right"></i>
            </a>
            <ul id="<%= $collapse_id %>" class="nav nav-stacked collapse<%= $active_route ? ' in' : '' %>">
            % for my $item_child ( @{ $item->{children} } ) {
              <li><a href="<%= url_for $item_child->{link} %>"><%= $item_child->{text} %></a></li>
            % }
            </ul>
          </li>
        % } else {
          <li><a href="<%= defined $item->{link} ? url_for $item->{link} : '#' %>"><%= $item->{text} %></a></li>
        % }
      % }
  </div>
  <div class="col-md-10">
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
% for my $user ( $users->all ) {
<p><%= $user->username %></p>
% }

@@ sesbania/admin/user/add.html.ep
% layout 'sesbania/admin_full';
% title 'Add User';
<h1>Add User</h1>
%= sesbania_form_builder $user_create_form
