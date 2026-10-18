-- Try to select all omitting the ride column using an Anonymous column
SELECT "id", "origin", "destination", 'Anonymous' AS "rider" FROM "rides";