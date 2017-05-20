package Sesbania::Plugin::Admin::Templates;

1;
__DATA__

@@ admin/root/login.html.ep
% layout 'default';
% title 'Admin Login';
<div class="row">
  <div class="col-md-4 col-md-offset-4">
    <h1>Login</h1>
    %= sesbania_form_builder $login_form
  </div>
</div>

@@ admin/root/index.html.ep
% layout 'default';
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
