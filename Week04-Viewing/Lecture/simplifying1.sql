-- Join authors with their books title
SELECT "name", "title" FROM "authors"
JOIN "authored" ON "authors"."id" = "authored"."author_id"
JOIN "books" ON "authored"."book_id" = "books"."id"
ORDER BY "name";