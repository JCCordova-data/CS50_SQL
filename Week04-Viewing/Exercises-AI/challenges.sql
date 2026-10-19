-- Creating a VIEW to show us the id & client_name from "customers" table, ignoring emails and phone numbers
CREATE VIEW "active_customers" AS
SELECT "id", "client_name" FROM "customers"
WHERE "is_active" = 1;

-- Creating a VIEW to find the total spent by customer
CREATE VIEW "customer_spend" AS
SELECT "active_customers"."id", "active_customers"."client_name", ROUND(SUM("transactions"."amount"), 2) AS "total_spent" 
FROM "transactions"
JOIN "active_customers" ON "active_customers"."id" = "transactions"."customer_id"
WHERE "transactions"."status" = 'COMPLETED'
GROUP BY "active_customers"."id";

-- Creating a TRIGGER to intercept anay DELETE to "active_customers" VIEW and UPDATE "customers" table
CREATE TRIGGER "soft_delete_customer"
INSTEAD OF DELETE ON "active_customers"
FOR EACH ROW
BEGIN
    UPDATE "customers" SET "is_active" = 0
    WHERE "id" = OLD."id";
END;