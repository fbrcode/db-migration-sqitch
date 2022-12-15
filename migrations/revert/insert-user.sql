-- Revert sample-project:insert-user from pg
BEGIN;
DROP FUNCTION app.insert_user (TEXT, TEXT);
COMMIT;

