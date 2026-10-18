-- Creating a VIEW to show us the items that are not deleted
CREATE VIEW "current_collections" AS
SELECT "id", "title", "accession_number", "acquired" FROM "collections"
WHERE "deleted" = 0;