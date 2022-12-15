-- Verify sample-project:users on pg
SELECT
  nickname,
  PASSWORD,
  timestamp
FROM
  app.users
WHERE
  FALSE;

