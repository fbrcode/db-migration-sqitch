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
    PASSWORD = crypt($3, gen_salt('md5'))
  WHERE
    nickname = $1
    AND crypt($2, PASSWORD);
  RETURN FOUND;
END;
$$;
COMMIT;

