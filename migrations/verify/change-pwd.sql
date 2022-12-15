-- Verify sample-project:change-pwd on pg
BEGIN;
SELECT
  has_function_privilege('app.change_pass(text, text, text)', 'execute');
ROLLBACK;

