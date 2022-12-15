# Sqitch Database Change Management

## About

Sqitch application helps you manage your database changes.

References:

- <https://sqitch.org>
- <https://sqitch.org/docs/>
- <https://sqitch.org/docs/manual/>
- <https://github.com/sqitchers/sqitch/>
- <https://github.com/sqitchers/docker-sqitch>

PostgreSQL tutorial:

- <https://sqitch.org/docs/manual/sqitchtutorial/>

PgTAP tutorial:

- <https://pgtap.org/>

## OS Installation (with PostgreSQL support)

Reference: <https://sqitch.org/download/>

### Mac OS X example

```sh
brew tap sqitchers/sqitch
brew install sqitch --with-postgres-support --without-postgresql
sqitch --version
```

### Linux/Ubuntu/Debian

```sh
apt install sqitch libdbd-pg-perl postgresql-client
sqitch --version
```

Reference: <https://sqitch.org/download/debian/>

## Sqitch Migration Execution

### Database startup

Initialize the database following the instructions in the `README.md` file in the `database` folder.

### Sqitch startup

On `migrations` folder, run the init command:

```sh
cd migrations
sqitch init sample-project --uri https://github.com/fbrcode/db-migration-sqitch/ --engine pg
```

It will create a `sqitch.conf` file and all the necessary files to start working with Sqitch.

Setup `psql` client target:

```sh
whereis psql
sqitch config --user engine.pg.client /opt/homebrew/opt/libpq/bin/psql
# or
sqitch config --user engine.pg.client /usr/bin/psql
```

And let’s also tell it who we are, since this data will be used in all of our projects:

sqitch config --user user.name 'Fabio Bressler'
sqitch config --user user.email 'fabio.bressler@gmail.com'

> Note: `~/.sqitch/sqitch.conf` will hold global configuration settings, and `sqitch.conf` will hold project-specific settings.

### Sqitch development

Create a new step to deploy, rollback, verify a db change:

```sh
sqitch add-schema app-schema -n 'Add schema for all sample application objects.'
```

It will be added ro the plan and 3 files will be created named as `app-schema.sql` under `deploy`, `revert` and `verify` folders.

Use already defined environment variables for easier calls:

```sh
source ../database/.env
```

Set verification on every deploy and rebase:

```sh
sqitch config --bool deploy.verify true
sqitch config --bool rebase.verify true
```

Deploy the change:

```sh
sqitch deploy
```

Database will be updated:

To manage the changes, a separate schema holds the structure.

```txt
app_sample=# \dt sqitch.*
            List of relations
 Schema |     Name     | Type  |  Owner
--------+--------------+-------+----------
 sqitch | changes      | table | postgres
 sqitch | dependencies | table | postgres
 sqitch | events       | table | postgres
 sqitch | projects     | table | postgres
 sqitch | releases     | table | postgres
 sqitch | tags         | table | postgres
(6 rows)
```

Check status:

```sh
sqitch status
```

Check logs:

```sh
sqitch log --reverse --no-color --oneline | cat
```

Add another change:

```sh
sqitch add users --requires app-schema -n 'Creates table to track our users.'
```

Revert only the last change (without confirmation):

```sh
sqitch revert --to @HEAD^ -y
```

Run two migrations at once:

```sh
sqitch add insert-user --requires users --requires app-schema \
-n 'Creates a function to insert a user.'

sqitch add change-pwd --requires users --requires app-schema \
-n 'Creates a function to change a user password.'
```

### Sqitch tag versioning

Add a tag for the current state and verify it:

```sh
sqitch tag v1.0.0-dev1 -n 'Tag v1.0.0-dev1.'
sqitch deploy
sqitch status --show-tags
```

### Sqitch in-place refactor

Example to use pgcrypto instead of md5 functions.

Add pgcrypto extension:

```sh
sqitch add pgcrypto --requires app-schema -n 'Add pgcrypto extension.'
```

Refactor the `insert-user` and `change-pwd` functions accordingly:

```sh
sqitch rework insert-user --requires pgcrypto -n 'Refactor insert-user function.'
sqitch rework change-pwd --requires pgcrypto -n 'Refactor change-pwd to use pgcrypto.'
```

Change the original `deploy/insert-user.sql` and `deploy/change-pwd.sql` files and leave the newly created ones as they are.

Set a new tag:

```sh
sqitch tag v1.0.0-dev2 -n 'Tag v1.0.0-dev2.'
```

## Sqitch Repository List & Examples

- <https://github.com/nathansutton/database-migrations/tree/main/src/migrations/sqitch>
- <https://github.com/search?o=desc&q=Sqitch&s=updated&type=Repositories>
