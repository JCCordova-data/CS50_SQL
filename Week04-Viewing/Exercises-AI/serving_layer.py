import sqlite3


def main():
    #Connection and cursor
    connection = sqlite3.connect("sentinel.db")
    
    #VIEWs and TRIGGERs
    try:
        with connection:
            # Dropping the VIEWs and TRIGGERs to avoid error when a execute the entire script again
            connection.execute(
                """
                DROP VIEW IF EXISTS "customer_spend";
                """
            )
            connection.execute(
                """
                DROP VIEW IF EXISTS "active_customers";
                """
            )
            connection.execute(
                """
                DROP TRIGGER IF EXISTS "soft_delete_customer";
                """
            )
            
            # Creating a VIEW to show us the id & client_name from "customers" table, ignoring emails and phone numbers
            connection.execute(
                """
                CREATE VIEW "active_customers" AS
                SELECT "id", "client_name" FROM "customers"
                WHERE "is_active" = 1;
                """
            )
            
            # Creating a VIEW to find the total spent by customer
            connection.execute(
                """
                CREATE VIEW "customer_spend" AS
                SELECT "active_customers"."id", "active_customers"."client_name", ROUND(SUM("transactions"."amount"), 2) AS "total_spent" 
                FROM "transactions"
                JOIN "active_customers" ON "active_customers"."id" = "transactions"."customer_id"
                WHERE "transactions"."status" = 'COMPLETED'
                GROUP BY "active_customers"."id";
                """                
            )
            
            # Creating a TRIGGER to intercept anay DELETE to "active_customers" VIEW and UPDATE "customers" table
            connection.execute(
                """
                CREATE TRIGGER "soft_delete_customer"
                INSTEAD OF DELETE ON "active_customers"
                FOR EACH ROW
                BEGIN
                    UPDATE "customers" SET "is_active" = 0
                    WHERE "id" = OLD."id";
                END;
                """                
            )
            
            print("PASSED")
            
    except sqlite3.Error as e:
        print(f"FATAL: {e}")
    
    # Closing the connection
    connection.close()


if __name__ == "__main__":
    main()