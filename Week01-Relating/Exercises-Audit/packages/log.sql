
-- *** The Lost Letter ***
SELECT "address", "type" FROM "packages"
JOIN "addresses" ON "addresses"."id" = "packages"."to_address_id"
WHERE "from_address_id" = 432 AND "contents" = 'Congratulatory letter';
-- *** The Devious Delivery ***
SELECT * FROM "packages"
JOIN "scans" ON "scans"."package_id" = "packages"."id"
JOIN "addresses" ON "addresses"."id" = "scans"."address_id"
WHERE "from_address_id" IS NULL AND "scans"."action" = 'Drop';
-- *** The Forgotten Gift ***
SELECT * FROM "packages"
JOIN "scans" ON "scans"."package_id" = "packages"."id"
JOIN "drivers" ON "drivers"."id" = "scans"."driver_id"
WHERE "packages"."from_address_id" = 9873;
