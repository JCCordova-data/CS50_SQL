CREATE TABLE "ingredients" (
    "id" INTEGER,
    "name" TEXT NOT NULL,
    "unit" TEXT NOT NULL,
    "price" NUMERIC NOT NULL,
    PRIMARY KEY("id")
);

CREATE TABLE "donuts" (
    "id" INTEGER,
    "name" TEXT NOT NULL,
    "gluten_free" INTEGER NOT NULL CHECK("gluten_free" IN (0, 1)),
    "price" NUMERIC NOT NULL,
    PRIMARY KEY("id")
);

CREATE TABLE "donut_ingredients" (
    "id" INTEGER,
    "ingredient_id" INTEGER NOT NULL,
    "donut_id" INTEGER NOT NULL,
    PRIMARY KEY("id"),
    FOREIGN KEY("ingredient_id") REFERENCES "ingredients"("id"),
    FOREIGN KEY("donut_id") REFERENCES "donuts"("id")
);

CREATE TABLE "customers" (
    "id" INTEGER,
    "first_name" TEXT NOT NULL,
    "last_name" TEXT NOT NULL,
    PRIMARY KEY("id")
);

CREATE TABLE "orders" (
    "id" INTEGER,
    "customer_id" INTEGER NOT NULL,
    PRIMARY KEY("id"),
    FOREIGN KEY("customer_id") REFERENCES "customers"("id")
);

CREATE TABLE "donut_orders" (
    "id" INTEGER,
    "donut_id" INTEGER NOT NULL,
    "order_id" INTEGER NOT NULL,
    "quantity" INTEGER NOT NULL,
    PRIMARY KEY("id"),
    FOREIGN KEY("donut_id") REFERENCES "donuts"("id"),
    FOREIGN KEY("order_id") REFERENCES "orders"("id")
);