-- Creating a VIEW to find the localities that contains "rural" in their names
CREATE VIEW "rural" AS
SELECT "id", "district", "locality", "families", "households", "population", "male", "female"
FROM "census"
WHERE "locality" LIKE "%rural%";