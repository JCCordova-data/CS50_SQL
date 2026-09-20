import sqlite3
import pandas as pd

#The conection, if the database doesn't exist, it creates a new database file in the current folder
connection = sqlite3.Connection("publishing.db")
#Is used to execute SQL statements
cursor =  connection.cursor()

#To activate the foraign keys
cursor.execute("PRAGMA foreign_keys = ON;")

#We are going to reate the tables
sql_tables = '''
    CREATE TABLE IF NOT EXISTS authors (
        id INTEGER PRIMARY KEY,
        name TEXT NOT NULL,
        country TEXT NOT NULL
    );
    
    CREATE TABLE IF NOT EXISTS books (
        id INTEGER PRIMARY KEY,
        title TEXT NOT NULL,
        author_id INTEGER NOT NULL,
        genre TEXT NOT NULL,
        unit_cost REAL NOT NULL,
        FOREIGN KEY (author_id) REFERENCES authors(id)
    );
    
    CREATE TABLE IF NOT EXISTS orders (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        book_id INTEGER NOT NULL,
        sale_price REAL NOT NULL,
        quantity INTEGER NOT NULL,
        order_date TEXT NOT NULL,
        FOREIGN KEY (book_id) REFERENCES books(id)
    );
'''
cursor.executescript(sql_tables)

#Dataset
authors_seed = [
    (1, "Fiódor Dostoyevski", "Rusia"),
    (2, "Franz Kafka", "República Checa"),
    (3, "Johann Wolfgang von Goethe", "Alemania"),
    (4, "Jane Austen", "Reino Unido"),
    (5, "Mario Benedetti", "Uruguay"),
]
books_seed = [
    (101, "Crimen y Castigo", 1, "Novela Psicológica", 12.00),
    (102, "Noches Blancas", 1, "Ficción Clásica", 8.50),
    (103, "La Metamorfosis", 2, "Ficción Filosófica", 6.00),
    (104, "El Proceso", 2, "Ficción Filosófica", 9.50),
    (105, "Fausto", 3, "Drama / Poesía", 14.00),
    (106, "Orgullo y Prejuicio", 4, "Romance Clásico", 9.00),
    (107, "La Tregua", 5, "Ficción Latinoamericana", 7.50),
]
orders_seed = [
    (101, 24.00, 150, "2026-07-15"),  # Q3
    (102, 18.00, 80,  "2026-08-02"),  # Q3
    (103, 15.50, 200, "2026-09-10"),  # Q3
    (104, 21.00, 60,  "2026-09-18"),  # Q3
    (105, 28.00, 40,  "2026-06-25"),  # Q2 (Debe ser ignorado por el filtro temporal)
    (106, 20.00, 120, "2026-08-20"),  # Q3
    (107, 16.00, 95,  "2026-09-01"),  # Q3
    (101, 25.00, 100, "2026-09-28"),  # Q3
    (103, 15.50, 50,  "2026-05-10"),  # Q2 (Debe ser ignorado por el filtro temporal)
]

#Insertion authors
cursor.executemany(
    """
    INSERT INTO authors (id, name, country)
    VALUES (?, ?, ?);
    """, authors_seed
)

#Insertion books
cursor.executemany(
    """
    INSERT INTO books (id, title, author_id, genre, unit_cost)
    VALUES (?, ?, ?, ?, ?);
    """, books_seed
)

#Insertion orders
cursor.executemany(
    """
    INSERT INTO orders (book_id, sale_price, quantity, order_date)
    VALUES (?, ?, ?, ?);
    """, orders_seed
)

#store the fixes using 'commit'
connection.commit()

##============SQL + Python 1============##
query_analytics = """
    SELECT 
        "authors"."name",
        "authors"."country",
        SUM("orders"."sale_price" * "orders"."quantity") AS "total_revenue",
        SUM("books"."unit_cost" * "orders"."quantity") AS "total_cost",
        (SUM("orders"."sale_price" * "orders"."quantity") - SUM("books"."unit_cost" * "orders"."quantity")) AS "net_margin",
        ROUND(
            ((SUM("orders"."sale_price" * "orders"."quantity") - SUM("books"."unit_cost" * "orders"."quantity")) * 100)
            / SUM("orders"."sale_price" * "orders"."quantity"), 2
        ) AS "margin_pct"
    FROM "orders"
    JOIN "books" ON "books"."id" = "orders"."book_id"
    JOIN "authors" ON "authors"."id" = "books"."author_id"
    WHERE "orders"."order_date" BETWEEN '2026-07-01' AND '2026-09-30'
    GROUP BY "authors"."id"
    ORDER BY "net_margin" DESC;
"""

#Execute the sql query, identify the data type and asign column names
df = pd.read_sql_query(query_analytics, connection)

#Visualize
print("===Report===")
print(df)

#store in a csv
df.to_csv("q3_report.csv", index=False)

#close the connection
connection.close()