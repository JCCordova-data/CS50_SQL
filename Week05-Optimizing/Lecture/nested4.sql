-- Makes "person_index" a covering index for the above query
CREATE INDEX "person_index" ON "stars" ("person_id", "movie_id");