import sqlite3
import pandas as pd

#The connection, if the database doesn't exist, it creates a new database file in the current folder
connection = sqlite3.Connection("library.db")
#Is used to execute SQL statements
cursor = connection.cursor()

#To activate the foreign keys
cursor.execute("PRAGMA foreign_keys = ON;")

#We are going to create the tables
sql_tables = '''
        CREATE TABLE "readers" (
        "id" INTEGER,
        "first_name" TEXT NOT NULL,
        "last_name" TEXT NOT NULL,
        "email" TEXT NOT NULL UNIQUE,
        PRIMARY KEY("id")
    );

    CREATE TABLE "books" (
        "id" INTEGER,
        "title" TEXT NOT NULL,
        "author" TEXT NOT NULL,
        "total_copies" INTEGER NOT NULL CHECK("total_copies" >= 0),
        PRIMARY KEY("id")
    );

    CREATE TABLE "loans" (
        "id" INTEGER,
        "reader_id" INTEGER NOT NULL,
        "book_id" INTEGER NOT NULL,
        "loan_date" NUMERIC NOT NULL DEFAULT CURRENT_TIMESTAMP,
        "return_date" NUMERIC,
        PRIMARY KEY("id"),
        FOREIGN KEY("reader_id") REFERENCES "readers"("id"),
        FOREIGN KEY("book_id") REFERENCES "books"("id")
    );
'''
cursor.executescript(sql_tables)

#Creating data for the tables, one correct and one with an error UNIQUE error, because the email in the two examples 
# are the same. To solve that, we will use a try except block to catch the error and print a message to the user.
query1 = '''
    INSERT OR IGNORE INTO "readers" (id, first_name, last_name, email) 
    VALUES (1, "Cristopher", "Cordova", "ccordova@data.com");
'''

query2 = '''
    INSERT OR IGNORE INTO "readers" (id, first_name, last_name, email) 
    VALUES (2, "Alice", "Smith", "ccordova@data.com");
'''

#Try except block
try:
    cursor.execute(query1)
    cursor.execute(query2)
    #Store the fixes using 'commit' to save the changes in the database if there is no errors in the try block
    connection.commit()
except sqlite3.IntegrityError as error:
    print(f"Error: {error}. The email must be unique.")
    #If there is an error, cancel absolutely everything
    connection.rollback()

#Try to see the readers table using pandas
df_readers = pd.read_sql_query("SELECT id, first_name, last_name, email FROM 'readers';", connection)
#Store in a csv file
df_readers.to_csv("readers_report.csv", index=False)

#Close the connection
connection.close()