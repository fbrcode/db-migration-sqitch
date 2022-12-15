-- Verify sample-project:app on pg
SELECT
  pg_catalog.has_schema_privilege('app', 'usage');

