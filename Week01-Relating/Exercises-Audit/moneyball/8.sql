SELECT "salaries"."salary" FROM "players"
JOIN "salaries" ON "salaries"."player_id" = "players"."id"
JOIN "performances" ON "performances"."player_id" = "players"."id"
WHERE "performances"."year" = 2001 AND "salaries"."year" = 2001 AND "performances"."HR" = (
    SELECT MAX("HR") FROM "performances"
    WHERE "year" = 2001
);