-- Revert sample-project:change-pwd to pg
BEGIN;
DROP FUNCTION app.change_pass (TEXT, TEXT, TEXT);
COMMIT;

