
-- *** The Lost Letter ***
SELECT "address", "type" FROM "packages"
JOIN "addresses" ON "addresses"."id" = "packages"."to_address_id"
WHERE "from_address_id" = 432 AND "contents" = 'Congratulatory letter';
-- *** The Devious Delivery ***

-- *** The Forgotten Gift ***

