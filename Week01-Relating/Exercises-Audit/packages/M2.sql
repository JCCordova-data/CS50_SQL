SELECT * FROM "packages"
JOIN "scans" ON "scans"."package_id" = "packages"."id"
JOIN "addresses" ON "addresses"."id" = "scans"."address_id"
WHERE "from_address_id" IS NULL AND "scans"."action" = 'Drop';