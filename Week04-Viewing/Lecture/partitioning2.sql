-- Creating a view to find the books that were nominated in 2021
CREATE VIEW "2021" AS
SELECT "id", "title" FROM "books"
WHERE "year" = 2021;