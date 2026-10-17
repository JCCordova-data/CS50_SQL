-- Creating a TEMPORARY VIEW to find the average not just by book ID, also by year using the new view that I have created
CREATE TEMPORARY VIEW "average_ratings_by_year" AS
SELECT "year", ROUND(AVG("rating"), 2) AS "rating" FROM "average_book_ratings"
GROUP BY "year";