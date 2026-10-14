-- First block, creating the temporary table
CREATE TABLE "meteorites_temp" (
    "name" TEXT,
    "id" INTEGER,
    "nametype" TEXT,
    "class" TEXT,
    "mass" TEXT,
    "discovery" TEXT,
    "year" TEXT,
    "lat" TEXT,
    "long" TEXT
);

.import --csv --skip 1 meteorites.csv meteorites_temp

-- Second block
UPDATE "meteorites_temp" SET "mass" = NULL
WHERE "mass" = '';
UPDATE "meteorites_temp" SET "lat" = NULL
WHERE "lat" = '';
UPDATE "meteorites_temp" SET "long" = NULL
WHERE "long" = '';
UPDATE "meteorites_temp" SET "year" = NULL
WHERE "year" = '';
UPDATE "meteorites_temp" SET "mass" = ROUND("mass", 2);
UPDATE "meteorites_temp" SET "lat" = ROUND("lat", 2);
UPDATE "meteorites_temp" SET "long" = ROUND("long", 2);

-- Third block
CREATE TABLE "meteorites" (
    "id" INTEGER,
    "name" TEXT,
    "class" TEXT,
    "mass" NUMERIC,
    "discovery" TEXT,
    "year" INTEGER,
    "lat" NUMERIC,
    "long" NUMERIC,
    PRIMARY KEY("id")
);

-- Fourth block
INSERT INTO "meteorites" ("name", "class", "mass", "discovery", "year", "lat", "long")
SELECT "name", "class", "mass", "discovery", "year", "lat", "long" FROM "meteorites_temp"
WHERE "nametype" != 'Relict'
ORDER BY CAST("year" AS INTEGER), "name";

-- Fifth block
DROP TABLE "meteorites_temp";