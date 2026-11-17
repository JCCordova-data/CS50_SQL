-- In this file, you will find the schema for the 'Parabrisas Importados' database.

-- Represent customers (both individual consumers and corporate auto repair shops).
CREATE TABLE "customers" (
    "id" INTEGER,
    "first_name" TEXT,
    "last_name" TEXT,
    "company_name" TEXT,
    "tax_id" TEXT UNIQUE, -- RUC or DNI in Peru
    "phone" TEXT,
    "email" TEXT,
    PRIMARY KEY("id")
);

-- Represent suppliers who provide the auto glass parts.
CREATE TABLE "suppliers" (
    "id" INTEGER,
    "name" TEXT NOT NULL,
    "contact_name" TEXT,
    "phone" TEXT,
    "address" TEXT,
    PRIMARY KEY("id")
);

-- Represent the auto glass inventory (windshields, windows, etc.).
CREATE TABLE "inventory" (
    "id" INTEGER,
    "part_number" TEXT NOT NULL UNIQUE,
    "car_brand" TEXT NOT NULL,
    "car_model" TEXT NOT NULL,
    "year_start" INTEGER NOT NULL,
    "year_end" INTEGER NOT NULL,
    "glass_type" TEXT NOT NULL, -- e.g., 'Front Windshield', 'Rear Window', 'Door Glass'
    "price" NUMERIC NOT NULL,
    "stock_quantity" INTEGER NOT NULL DEFAULT 0,
    "supplier_id" INTEGER,
    PRIMARY KEY("id"),
    FOREIGN KEY("supplier_id") REFERENCES "suppliers"("id")
);

-- Represent the sales transactions.
CREATE TABLE "sales" (
    "id" INTEGER,
    "customer_id" INTEGER NOT NULL,
    "sale_date" NUMERIC NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "total_amount" NUMERIC NOT NULL,
    "payment_method" TEXT, -- e.g., 'Cash', 'Credit Card', 'Yape'
    PRIMARY KEY("id"),
    FOREIGN KEY("customer_id") REFERENCES "customers"("id")
);

-- Represent the line items (details) of each sale transaction.
CREATE TABLE "sale_items" (
    "sale_id" INTEGER,
    "inventory_id" INTEGER,
    "quantity" INTEGER NOT NULL,
    "unit_price" NUMERIC NOT NULL,
    PRIMARY KEY("sale_id", "inventory_id"),
    FOREIGN KEY("sale_id") REFERENCES "sales"("id"),
    FOREIGN KEY("inventory_id") REFERENCES "inventory"("id")
);

-- Create a view to easily check the current stock levels and alerts.
CREATE VIEW "low_stock_alerts" AS
SELECT "part_number", "car_brand", "car_model", "stock_quantity"
FROM "inventory"
WHERE "stock_quantity" < 5;

-- Create a view to generate a simple monthly sales report.
CREATE VIEW "monthly_sales_summary" AS
SELECT 
    strftime('%Y-%m', "sale_date") AS "month",
    COUNT("id") AS "total_sales_count",
    SUM("total_amount") AS "total_revenue"
FROM "sales"
GROUP BY "month"
ORDER BY "month" DESC;

-- Indexes to optimize common searches on the database.
-- 1. Accelerate searches for car models in the inventory (very common for customers asking for a specific windshield).
CREATE INDEX "idx_inventory_car" ON "inventory"("car_brand", "car_model");

-- 2. Accelerate searches by customer tax_id (RUC/DNI) for fast billing.
CREATE INDEX "idx_customers_tax_id" ON "customers"("tax_id");

-- 3. Accelerate looking up sales by customer ID.
CREATE INDEX "idx_sales_customer" ON "sales"("customer_id");