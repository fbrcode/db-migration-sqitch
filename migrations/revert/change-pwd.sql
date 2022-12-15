-- Revert sample-project:change-pwd from pg
BEGIN;
DROP FUNCTION app.change_pass (TEXT, TEXT, TEXT);
COMMIT;

