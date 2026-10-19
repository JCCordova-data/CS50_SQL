-- Creating a VIEW to find the listings that have just 1 bedroom
CREATE VIEW "one_bedrooms" AS
SELECT "id", "property_type", "host_name", "accommodates" FROM "listings"
WHERE "bedrooms" = 1;