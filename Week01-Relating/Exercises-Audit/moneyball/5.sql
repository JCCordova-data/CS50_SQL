SELECT DISTINCT "teams"."name" FROM "performances"
JOIN "teams" ON "teams"."id" = "performances"."team_id"
WHERE "performances"."player_id" = (
    SELECT "id" FROM "players"
    WHERE "first_name" = 'Satchel' AND "last_name" = 'Paige'
);