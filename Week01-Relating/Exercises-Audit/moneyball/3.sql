SELECT "performances"."year", "performances"."HR" FROM "players"
JOIN "performances" ON "performances"."player_id" = "players"."id"
WHERE "players"."first_name" = 'Ken' AND "players"."last_name" = 'Griffey' AND "players"."birth_year" = 1969
ORDER BY "performances"."year" DESC;