-- Creating a views to calculate the average and show the book IDs, titles and years
CREATE VIEW "average_book_ratings" AS
SELECT "book_id", "title", "year", ROUND(AVG("rating"), 2) AS "rating"
FROM "ratings"
JOIN "books" ON "ratings"."book_id" = "books"."id";