-- Verify sample-project:insert-user on pg
BEGIN;
SELECT
  has_function_privilege('app.insert_user(text, text)', 'execute');
ROLLBACK;

