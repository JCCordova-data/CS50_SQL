import sqlite3
import csv
import hashlib

SALT = "SentinelSalt2026_"


def run_security_tests(conn):
    #Test 1 with trigger "abort_hard_delete_customers"
    try:
        conn.execute(
            """
            DELETE FROM "customers"
            WHERE "id" = 2;
            """
        )
        conn.commit()
        print("DEFENSE FAILED")
    except Exception as e:
        print(f"DEFENSE PASSED: {e}")
    #Test 2 with trigger "log_soft_delete"
    conn.execute(
        """
        UPDATE "customers"
        SET "is_active" = 0
        WHERE "id" = 2;
        """        
    )
    conn.commit()
    cursor = conn.execute(
        """
        SELECT * FROM "audit_security_log"
        WHERE "record_id" = 2;
        """
    )
    log = cursor.fetchone()
    if log:
        print("CORRECT")
    else:
        print("FAILED")


def main():
    #Calling the process_raw_feed function to clean all the data inside of raw_feed.csv
    raw_file = "raw_feed.csv"
    clean_data = process_raw_feed(raw_file)
    
    #Connection and creation of the scuema
    conn = sqlite3.connect("sentinel.db")
    cursor = conn.cursor()
    #To activate the foreign keys' rules
    cursor.execute("PRAGMA foreign_keys = on;")
    
    #Creating the DDL schema
    with open("schema.sql", "r", encoding="utf-8") as f:
        cursor.executescript(f.read())
    
    with conn:
        #Moving the data to the staging table
        conn.executemany(
            """
            INSERT INTO "staging_feed" ("client_name", "email_hash", "masked_phone", "amount", "status", "tx_timestamp")
            VALUES (?, ?, ?, ?, ?, ?)
            """,
            clean_data
        )
        
        #Promoving the unique clients
        conn.execute(
            """
            INSERT OR IGNORE INTO "customers" ("client_name", "email_hash", "masked_phone")
            SELECT DISTINCT "client_name", "email_hash", "masked_phone"
            FROM "staging_feed"
            """
        )
        
        #Promoving transactions solving the FK
        conn.execute(
            """
            INSERT INTO "transactions" ("customer_id", "amount", "status", "tx_timestamp")
            SELECT
                (SELECT "id" FROM "customers" WHERE "customers"."email_hash" = "staging_feed"."email_hash"),
                "amount",
                "status",
                "tx_timestamp"
            FROM "staging_feed";
            """
        )
    
    #Calling the tests
    run_security_tests(conn)
    
    #Closing the connection
    conn.close()


#Using the hashlib to hash the data
def hash_email(email, salt = SALT):
    clean_email = email.strip().lower()
    salted_string = salt + clean_email
    return hashlib.sha256(salted_string.encode("utf-8")).hexdigest()


def mask_phone(phone):
    #Replacing the invalid digits with nothing
    phone = phone.replace("-", "").replace("+", "").replace(" ", "")
    
    #Returning ******123
    if len(phone) >= 3:
        return "*" * (len(phone) - 3) + phone[-3:]
    return "***"


def process_raw_feed(file):
    clean_data = []
    
    #Opening the csv file as a reader using DictReader to store the data in a dictionaries
    with open(file, "r", encoding="utf-8") as f:
        #Creating a variable, so we can iterate over that
        reader = csv.DictReader(f)
        
        #Iterating for each row in the dictionary
        for row in reader:
            #Initial cleaning
            name = row["client_name"].strip()
            amount = round(float(row["amount"].strip()), 2)
            status = row["status"].strip().upper()
            timestamp = row["tx_timestamp"].strip()
            
            #Call the function to encode the email and the phone number
            email_h = hash_email(row["email"])
            phone_m = mask_phone(row["phone"])
            
            #Store all in tuples, because it wont be modified
            clean_data.append((name, email_h, phone_m, amount, status, timestamp))
    
    #Return the clean data
    return clean_data


if __name__ == "__main__":
    main()