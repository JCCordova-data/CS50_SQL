-- Using EXPLAIN QUERY PLAN to ensure that the INDEX I have created is used
EXPLAIN QUERY PLAN
SELECT * FROM "movies" WHERE "title" = 'Cars';