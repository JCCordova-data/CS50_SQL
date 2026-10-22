-- Creates a partial index to speed up searches involving the present year
.timer on
CREATE INDEX "recents" ON "movies" ("title")
WHERE "year" = 2023;