-- Find the average not just by book ID, also by year using the new view that I have created
SELECT "year", ROUND(AVG("rating"), 2) AS "rating" FROM "average_book_ratings"
GROUP BY "year";