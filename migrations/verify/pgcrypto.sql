-- Verify sample-project:pgcrypto on pg
SELECT
  1 / count(*)
FROM
  pg_extension
WHERE
  extname = 'pgcrypto';

SELECT
  has_function_privilege('crypt(text, text)', 'execute');

SELECT
  has_function_privilege('gen_salt(text)', 'execute');

