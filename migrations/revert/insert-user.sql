-- Deploy sample-project:insert-user to pg
-- requires: users
-- requires: app-schema
-- Revert sample-project:insert-user from pg
BEGIN;
CREATE OR REPLACE FUNCTION app.insert_user (nickname text, PASSWORD TEXT)
  RETURNS VOID
  LANGUAGE SQL
  SECURITY DEFINER
  AS $$
  INSERT INTO app.users
    VALUES ($1, md5($2));
$$;
COMMIT;

