# Postgres database

This is a local database for sqitch migration tests.

## Startup

Install `psql` locally to be able to use standard postgres and run migration processes.

External reference: <https://blog.timescale.com/blog/how-to-install-psql-on-mac-ubuntu-debian-windows/>

Alternatively, postgres can be installed locally, mac option is `brew install postgresql`

Copy `.env.example` to `.env` and modify connection settings if needed.

## Initiate / refresh db

**ATTENTION**: Execution of below steps will wipe out local database data.

```shell
cd ./database
source .env
# startup
docker-compose up -d
# or refresh (erase all data) with..
docker-compose down && docker volume rm database_sqitch_pg && docker-compose up -d
# install or refresh/reset (2nd run onwards) all tables
psql -f init.sql
```
