-- We are gonna try to delete a data that have a FOREING KEY constraint
DELETE FROM "artists"
WHERE "name" = 'Unidentified artist';