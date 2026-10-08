-- We are going to activate a NULL constraint intentionally to prove the NULL rules.
INSERT INTO "collections" ("title", "accession_number", "acquired")
VALUES (NULL, NULL, '1900-01-10'); 