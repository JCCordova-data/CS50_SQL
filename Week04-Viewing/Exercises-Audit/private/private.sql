-- Creating a new table to the triplets
CREATE TABLE "cipher" (
    "sentence_id" INTEGER NOT NULL,
    "start_char" INTEGER NOT NULL,
    "length" INTEGER NOT NULL,
    FOREIGN KEY("sentence_id") REFERENCES "sentences"("id")
);

-- Insert the 8 triples
INSERT INTO "cipher" ("sentence_id", "start_char", "length")
VALUES
    (14, 98, 4),
    (114, 3, 5),
    (618, 72, 9),
    (630, 7, 3),
    (932, 12, 5),
    (2230, 50, 7),
    (2346, 44, 10),
    (3041, 14, 5);

-- Creating the VIEW that encodes me the mistery message
CREATE VIEW "message" AS
SELECT substr("sentences"."sentence", "cipher"."start_char", "cipher"."length") AS "phrase"
FROM "sentences"
JOIN "cipher" ON "cipher"."sentence_id" = "sentences"."id"
ORDER BY "cipher"."rowid";