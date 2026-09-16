SELECT * FROM "packages"
JOIN "scans" ON "scans"."package_id" = "packages"."id"
JOIN "drivers" ON "drivers"."id" = "scans"."driver_id"
WHERE "packages"."from_address_id" = 9873;


--9873, adress' id
--9523, package's id