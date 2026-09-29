CREATE TABLE "readers" (
    "id" INTEGER,
    "first_name" TEXT NOT NULL,
    "last_name" TEXT NOT NULL,
    "email" TEXT NOT NULL UNIQUE,
    PRIMARY KEY("id")
);

CREATE TABLE "books" (
    "id" INTEGER,
    "title" TEXT NOT NULL,
    "author" TEXT NOT NULL,
    "total_copies" INTEGER NOT NULL CHECK("total_copies" >= 0),
    PRIMARY KEY("id")
);

CREATE TABLE "loans" (
    "id" INTEGER,
    "reader_id" INTEGER NOT NULL,
    "book_id" INTEGER NOT NULL,
    "loan_date" NUMERIC NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "return_date" NUMERIC,
    PRIMARY KEY("id"),
    FOREIGN KEY("reader_id") REFERENCES "readers"("id"),
    FOREIGN KEY("book_id") REFERENCES "books"("id")
);