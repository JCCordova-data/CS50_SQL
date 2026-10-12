-- Try to fix the errors manually using the LIKE keyword, wich is the best way to be honest
UPDATE "votes" SET "title" = 'PROFUSION OF FLOWERS'
WHERE "title" LIKE 'Profusion%'; -- LIKE is case insensitive