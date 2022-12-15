-- Deploy sample-project:users to pg
-- requires: app-schema
BEGIN;
SET client_min_messages = 'warning';
CREATE TABLE app.users (
  nickname text PRIMARY KEY,
  password text NOT NULL,
  timestamp timestamptz NOT NULL DEFAULT now()
);
COMMIT;

