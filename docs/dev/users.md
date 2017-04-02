# User Management & Storage

So the base item of this software is managing a group of peoples membership, or
eventually maybe a group of groups. So the base unit would be a user, who would
be a member of a group. These users would also need roles, eg. for admin or
whatever else this ends up doing.

## User Definition

A user has:

* Username
  * Unique login item
* Password
  * Used with username to login
* User Roles
  * What the user can do in the software
* Extra Details
  * Name, address, extra random details
  * Can include email, should have the ability to set as a 'contactable' one or
    something.
* Membership of (a) Group(s)
  * Arbitrary set of things, eg. groups within an organisation, or community
    groups in a larger community, or whatever
* Membership Level
  * What sort of member you are, if there are multiple membership levels. This
    will assume either a free tier, or payment levels for access/membership.

## Role Definition

A role is a group of abilities the user has in this software. Roles available
will be determined by the plugins installed, so this should actually just
provide a way of grouping the roles from the various plugins into groups that
can be assigned to users, a'la mediawiki or other such software. So the terms will be:

* Role
  * A role which can be applied to a user, eg. Admin, Manager, Super Admin,
    etc. etc.
* Actions
  * The actions which a user could perform, as provided by a plugin. This could
    be anything, such as editing, adding, or removing users/forms/whatever the
    plugin provides.
  * These should be able to be added and removed from Roles, easily.

## Extra Details Definition

An extra detail is something like an address field, or email. There should be a way to add arbitrary information sets to this, although should we have some items be pre-typed? Also need a way to set certain things as 'primary' eg email addresses. Should this be stored in a seperate set of tables? or what?

## Storage

### Users

Table name: `core_users`

| Column Name | Type          | Description                         |
| ----------- | ------------- | ----------------------------------- |
| id          | PK Integer    | User ID in the database             |
| username    | Unique string | Primary login item, must be unique  |
| password    | string        | Encrypted Password                  |

### Roles

Table name: `core_roles`

| Column Name | Type          | Description                         |
| ----------- | ------------- | ----------------------------------- |
| id          | PK Integer    | Role ID in the database             |
| name        | Unique String | The name of this role               |
| description | Text          | Optional description of the role    |

### User Roles

This is a pivot table

Table name `core_users_roles`

| Column Name | Type                         | Description                        |
| ----------- | ---------------------------- | ---------------------------------- |
| user_id     | FK Integer (`core_users.id`) | The user id for a user             |
| role_id     | FK Integer (`core_roles.id`) | The role if to attach this user to |

Primary Key: `user_id : role_id` (Dual column key)

### Actions

Table name `core_actions`

| Column Name | Type          | Description                                      |
| ----------- | ------------- | ------------------------------------------------ |
| id          | PK Integer    | Action ID in the database                        |
| name        | Unique String | A unique string with a prefix of the plugin name |
| description | Text          | Provided by the plugin, what the action does     |

The unique name string should be of the form `plugin_name.action`.

Note that this table will be written to by all plugins.

### Role Actions

This is a pivot table

Table name `core_roles_actions`

| Column Name | Type                           | Description          |
| ----------- | ------------------------------ | -------------------- |
| role_id     | FK Integer (`core_roles.id`)   | The id for a role    |
| action_id   | FK Integer (`core_actions.id`) | The id for an action |

Primary Key: `role_id : action_id` (Dual column key)
