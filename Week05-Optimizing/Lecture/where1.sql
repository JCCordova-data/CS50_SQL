-- Creating an INDEX in the title column
.timer on
CREATE INDEX "title_index" ON "movies" ("title");
.timer off