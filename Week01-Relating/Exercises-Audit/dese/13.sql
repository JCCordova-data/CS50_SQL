SELECT "districts"."name", "staff_evaluations"."exemplary" FROM "districts"
JOIN "staff_evaluations" ON "staff_evaluations"."district_id" = "districts"."id"
ORDER BY "staff_evaluations"."exemplary" DESC
LIMIT 10;