-- Completes invalid update of balance without a transaction
UPDATE "accounts" SET "balance" = "balance" - 10 WHERE "id" = 1;