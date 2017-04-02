# Database

From the get go, we will need to set some basic design decisions for the
database in terms of table naming and items like that.

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

## Proposition

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
