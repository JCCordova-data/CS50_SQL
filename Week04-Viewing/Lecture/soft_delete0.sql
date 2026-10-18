-- Add "deleted" column to "collections" table 
ALTER TABLE "collections" ADD COLUMN "deleted" INTEGER DEFAULT 0;