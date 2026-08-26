SELECT "title", "topic", "air_date" FROM "episodes"
WHERE "topic" LIKE '%data%' AND "air_date" BETWEEN '2003-01-01' AND '2005-12-31';