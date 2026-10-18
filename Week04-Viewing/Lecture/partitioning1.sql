-- Creating a view to find the books that were nominated in 2022
CREATE VIEW "2022" AS
SELECT "id", "title" FROM "books"
WHERE "year" = 2022;