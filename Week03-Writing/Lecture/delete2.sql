-- We are gonna try to delete all the rows that the acquired date was before than 1909
DELETE FROM "collections"
WHERE "acquired" < '1909-01-01'; -- sqlite allows us to use <, > with dates