-- Creating a VIEW that includes all of the columns in the listings table except for description
CREATE VIEW "no_descriptions" AS
SELECT "id", "property_type", "host_name", "accommodates", "bedrooms"
FROM "listings";