-- Try to fix the errors manually using the LIKE keyword, wich is the best way to be honest
UPDATE "votes" SET "title" = 'IMAGINATIVE LANDSCAPE'
WHERE "title" LIKE 'Ima%'; -- LIKE is case insensitive