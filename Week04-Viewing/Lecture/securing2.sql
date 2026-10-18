-- Creating a View to try to select all omitting the ride column using an Anonymous column
CREATE VIEW "analysis" AS
SELECT "id", "origin", "destination", 'Anonymous' AS "rider" FROM "rides";