-- Try to fix the errors manually using the LIKE keyword, wich is the best way to be honest
UPDATE "votes" SET "title" = 'FARMERS WORKING AT DAWN'
WHERE "title" LIKE 'Fa%'; -- LIKE is case insensitive