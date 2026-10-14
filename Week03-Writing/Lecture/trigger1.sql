-- Creating a trigger to automatize the action bought when I insert some piece of art
CREATE TRIGGER "buy"
AFTER INSERT ON "collections" 
FOR EACH ROW
BEGIN
    INSERT INTO "transactions" ("title", "action")
    VALUES (NEW."title", 'bought');
END;