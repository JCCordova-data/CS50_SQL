-- We are gonna use trim function to remove leading and trailing withespaces
UPDATE "votes" SET "title" = trim("title");