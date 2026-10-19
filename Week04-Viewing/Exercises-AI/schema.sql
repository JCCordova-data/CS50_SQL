CREATE TABLE "staging_feed" (
    "client_name" TEXT,
    "email_hash" TEXT,
    "masked_phone" TEXT,
    "amount" NUMERIC,
    "status" TEXT,
    "tx_timestamp" TEXT
);

CREATE TABLE "customers" (
    "id" INTEGER,
    "client_name" TEXT NOT NULL,
    "email_hash" TEXT NOT NULL UNIQUE,
    "masked_phone" TEXT NOT NULL,
    "is_active" INTEGER NOT NULL DEFAULT 1,
    PRIMARY KEY("id")
);

CREATE TABLE "transactions" (
    "id" INTEGER,
    "customer_id" INTEGER NOT NULL,
    "amount" NUMERIC NOT NULL,
    "status" TEXT NOT NULL CHECK("status" IN ('COMPLETED', 'FAILED', 'PENDING')),
    "tx_timestamp" TEXT NOT NULL,
    PRIMARY KEY("id"),
    FOREIGN KEY("customer_id") REFERENCES "customers"("id")
);

CREATE TABLE "audit_security_log" (
    "id" INTEGER,
    "event_type" TEXT NOT NULL,
    "table_affected" TEXT NOT NULL,
    "record_id" INTEGER,
    "details" TEXT,
    "created_at" TEXT DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY("id")
);

-- Creating a TRIGGER to raise an error if anyone tries to delete some item in customer column
CREATE TRIGGER "abort_hard_delete_customers"
BEFORE DELETE ON "customers"
FOR EACH ROW
BEGIN
    SELECT RAISE(ABORT, 'You can not delete this data');
END;

-- Creating a TRIGGER to soft deleting the items
CREATE TRIGGER "log_soft_delete"
AFTER UPDATE OF "is_active" ON "customers"
FOR EACH ROW
WHEN OLD."is_active" = 1 AND NEW."is_active" = 0
BEGIN
    INSERT INTO "audit_security_log" ("event_type", "table_affected", "record_id", "details")
    VALUES ('SOFT_DELETE', 'customers', OLD."id", 'Customer marked as inactive');
END;