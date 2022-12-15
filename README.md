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
```

Reference: <https://sqitch.org/download/debian/>

## Sqitch Migration Execution

### Database startup

Initialize the database following the instructions in the `README.md` file in the `database` folder.

### Sqitch startup

On `sqitch/migrations` folder, run the init command:

```sh
sqitch init sample-project --uri https://github.com/fbrcode/db-migration-sqitch/ --engine pg
```

It will create a `sqitch.conf` file and all the necessary files to start working with Sqitch.

Setup `psql` client target:

```sh
sqitch config --user engine.pg.client /opt/homebrew/opt/libpq/bin/psql
```

And let’s also tell it who we are, since this data will be used in all of our projects:

sqitch config --user user.name 'Fabio Bressler'
sqitch config --user user.email 'fabio.bressler@gmail.com'

> Note: `~/.sqitch/sqitch.conf` will hold global configuration settings, and `sqitch.conf` will hold project-specific settings.

Create a new step to deploy, rollback, verify a db change:

```sh
sqitch add-schema app -n 'Add schema for all sample application objects.'
```

It will be added ro the plan and 3 files will be created named as `app-schema.sql` under `deploy`, `revert` and `verify` folders.

## Sqitch Repository List & Examples

- <https://github.com/nathansutton/database-migrations/tree/main/src/migrations/sqitch>
- <https://github.com/search?o=desc&q=Sqitch&s=updated&type=Repositories>
