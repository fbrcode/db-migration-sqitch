-- Deploy sample-project:change-pwd to pg
-- requires: users
-- requires: app-schema
BEGIN;
CREATE OR REPLACE FUNCTION app.change_pass (nick text, oldpass text, newpass text)
  RETURNS boolean
  LANGUAGE plpgsql
  SECURITY DEFINER
  AS $$
BEGIN
  UPDATE
    app.users
  SET
    PASSWORD = md5($3)
  WHERE
    nickname = $1
    AND PASSWORD = md5($2);
  RETURN FOUND;
END;
$$;
COMMIT;

