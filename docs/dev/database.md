# Database

From the get go, we will need to set some basic design decisions for the
database in terms of table naming and items like that.

## TL;DR

* Maximum table name length is 53 characters
* Prefix tables with plugin name
* Be descriptive within these limits

## Targeted Databases

By default, we will be targeting the following database engines:

* Postgres
* MySQL (and by proxy MariaDB)
* SQLite

All tests must run and pass under any and all of these databases, for the
latest supported version of the database at time of release. Bonus points if it
will work for older versions of the database and is tested for it, though this
is not a requirement.

## Data Limits

There are limits to Table name lengths in:

* Postgres
  * 63 by default
* MySQL
  * 64 by default
* SQLite
  * No limit known

So we will have to keep the table name lengths down under 63 characters. Thats
still a long name!

## Database Prefix

I propose then, either to have the prefix of `sesbania_` or `sb_` for each
table. Actually... hmm. Here are the options:

### `sesbania_`

Having this makes it REALLY easy to see what it is, and allows for this app to
co-exist with basically any other thing on shared hosting. It does limit the
rest of the name to 54 characters, but that is still a lot of characters left.

### `sb_`

This prefix would be easier to see what the rest of the table name is without
taking up a lot of the screen, but there may be an application already out in
the wild that has this prefix. This may cause issues.

### User Configurable

This would be nice, however there should be a sane default. And the sane
default will then determine how many characters you can then use for a User
Configurable set.

### Decision

I would say that, having `sesbania_` as a default, which is 8 characters and an
underscore, as the prefix, and then allowing for the User configurable one to
be up to 9 characters and an underscore.

This is 53 characters:

```
this_is_fifty_three_characters_right_here_wow_lengthy
```

Which would mean that a custom one would look up to this:

```
customise_this_is_fifty_three_characters_right_here_wow_lengthy
```

Which is quite frankly ludicrous. So, default prefix for the tables is
`sesbania_` and will be so throughout the rest of the documentation - but
plugin code should not rely on that, and should instead use the DBIC resultsets
and joins.

## Plugin Tables

A plugin table should be prefixed with the plugin name, while keeping in the
table name limits. Some examples:

* `core_users`
* `core_users_roles`
* `formbuilder_forms`
* `formbuilder_forms_inputs`

The column names are otherwise arbitrary, although all tables should have a
primary key defined. (This can be a multi column key, or whatever is required)

## Schema upgrades

Plugins should work under the provided schema upgrade script. *Under Development*
