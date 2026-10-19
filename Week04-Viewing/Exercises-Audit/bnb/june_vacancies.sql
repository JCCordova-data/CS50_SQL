-- Creating a VIEW that contains all listings and the number of days in June of 2023 that they remained vacant
CREATE VIEW "june_vacancies" AS
SELECT "listings"."id", "listings"."property_type", "listings"."host_name", COUNT("availabilities"."id") AS "days_vacant"
FROM "listings"
JOIN "availabilities" ON "availabilities"."listing_id" = "listings"."id"
WHERE 
    "availabilities"."available" = 'TRUE' AND 
    "availabilities"."date" LIKE '2023-06-%'
GROUP BY "listings"."id";