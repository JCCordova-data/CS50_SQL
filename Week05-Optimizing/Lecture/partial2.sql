-- Showing query's usage of index
EXPLAIN QUERY PLAN
SELECT "title" FROM "movies" WHERE "year" = 2023;