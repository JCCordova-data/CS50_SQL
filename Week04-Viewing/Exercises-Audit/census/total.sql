-- Creating a VIEW that contains the SUM of all the numeric columns in the census
CREATE VIEW "total" AS
SELECT
    SUM("families") AS "families",
    SUM("households") AS "households",
    SUM("population") AS "population",
    SUM("male") AS "male",
    SUM("female") AS "female"
FROM "census";