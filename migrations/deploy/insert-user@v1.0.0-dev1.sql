-- Deploy sample-project:insert-user to pg
-- requires: users
-- requires: app-schema
-- requires: pgcrypto
BEGIN;
CREATE OR REPLACE FUNCTION app.insert_user (nickname text, PASSWORD TEXT)
  RETURNS VOID
  LANGUAGE SQL
  SECURITY DEFINER
  AS $$
  INSERT INTO app.users
    VALUES ($1, crypt($2, gen_salt('md5')));
$$;
COMMIT;

