-- We try to delete some data with a FOREIGN KEY constraint
DELETE FROM "created" WHERE "artist_id" = (
    SELECT "id" FROM "artists"
    WHERE "name" = 'Unidentified artist'
);