-- In this file, you will find typical SQL queries that users will run on the database.

-- 1. Register a new individual customer.
INSERT INTO "customers" ("first_name", "last_name", "company_name", "tax_id", "phone", "email")
VALUES ('Carlos', 'Mendoza', NULL, '72345678', '987654321', 'carlos.mendoza@email.com');

-- 2. Register a new corporate customer (auto repair shop).
INSERT INTO "customers" ("first_name", "last_name", "company_name", "tax_id", "phone", "email")
VALUES (NULL, NULL, 'Talleres Surquillo Motors', '20123456789', '999888777', 'contacto@surquillomotors.pe');

-- 3. Register a new supplier.
INSERT INTO "suppliers" ("name", "contact_name", "phone", "address")
VALUES ('AutoGlass Peru SAC', 'Jorge Ramirez', '912345678', 'Av. Republica de Panama 1234, Surquillo');

-- 4. Add a new windshield to the inventory.
INSERT INTO "inventory" ("part_number", "car_brand", "car_model", "year_start", "year_end", "glass_type", "price", "stock_quantity", "supplier_id")
VALUES ('WND-TY-YAR-15', 'Toyota', 'Yaris', 2015, 2020, 'Front Windshield', 250.00, 10, 1);

-- 5. Search for a specific windshield when a customer asks for a Toyota Yaris front windshield.
SELECT "part_number", "glass_type", "price", "stock_quantity"
FROM "inventory"
WHERE "car_brand" = 'Toyota' 
  AND "car_model" = 'Yaris'
  AND "glass_type" = 'Front Windshield';

-- 6. Record a new sale transaction (e.g., selling a windshield to Carlos Mendoza).
INSERT INTO "sales" ("customer_id", "total_amount", "payment_method")
VALUES (1, 250.00, 'Yape');

-- 7. Record the specific items sold in the transaction above (assuming the sale_id generated was 1 and inventory_id was 1).
INSERT INTO "sale_items" ("sale_id", "inventory_id", "quantity", "unit_price")
VALUES (1, 1, 1, 250.00);

-- 8. Update the inventory stock to reflect the item sold.
UPDATE "inventory"
SET "stock_quantity" = "stock_quantity" - 1
WHERE "id" = 1;

-- 9. Update a customer's phone number if they change it.
UPDATE "customers"
SET "phone" = '999111222'
WHERE "tax_id" = '72345678';

-- 10. Delete a discontinued part from the inventory that is no longer sold or supplied.
DELETE FROM "inventory"
WHERE "part_number" = 'WND-OLD-90';

-- 11. Quickly check the low stock alerts view to see what needs to be ordered from suppliers.
SELECT * FROM "low_stock_alerts";

-- 12. View the monthly sales summary to analyze business performance.
SELECT * FROM "monthly_sales_summary";