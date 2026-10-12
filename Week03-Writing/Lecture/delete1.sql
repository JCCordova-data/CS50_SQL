-- We are going to delete all the rows that have NULL in the column 'acquired'
DELETE FROM "collections"
WHERE "acquired" IS NULL;