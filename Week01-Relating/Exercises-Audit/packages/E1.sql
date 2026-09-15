--SELECT * FROM "addresses"
--WHERE "address" = '900 Somerville Avenue'; 
--432

SELECT * FROM "packages"
JOIN "addresses" ON "addresses"."id" = "packages"."to_address_id"
WHERE "from_address_id" = 432 AND "contents" = 'Congratulatory letter';