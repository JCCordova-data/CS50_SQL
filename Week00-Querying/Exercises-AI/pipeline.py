import sqlite3


#raw data (simulating an API or a Website)
daily_sells = [
    {"title": "Crime and Punishment", "author": "Fiodor Dostoievski", "price": 25.50, "quantity_sold": 12},
    {"title": "The Metamorphosis", "author": "Franz Kafka", "price": 15.00, "quantity_sold": 8},
    {"title": "The Sorrows of Young Werther", "author": "Johann Wolfgang von Goethe", "price": 22.00, "quantity_sold": 5},
    {"title": "White Nights", "author": "Fiodor Dostoievski", "price": 18.50, "quantity_sold": 15},
    {"title": "Pride and Prejudice", "author": "Jane Austen", "price": 19.90, "quantity_sold": 20}
]

#the conection, if the file doesnt exist, sqlite3 will create it automatically in the current folder
conection = sqlite3.connect("library.db")

#the messenger
cursor = conection.cursor()

#data ingestion
cursor.execute(
    '''
    CREATE TABLE IF NOT EXISTS sales (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        author TEXT,
        price REAL,
        quantity_sold INTEGER
    )
    '''
)

#we are gonna do a for loop to the raw data
for book in daily_sells:
    #we use "?" to avoid SQL injections, these signs are a placeholders
    cursor.execute(
        '''
        INSERT INTO sales (title, author, price, quantity_sold)
        VALUES (?, ?, ?, ?)
        ''', (book["title"], book["author"], book["price"], book["quantity_sold"])
    )

#store the fixes using 'commit'
conection.commit()

#SQL + Python: 1
print("\n========== Top 3 Best-Selling Books ==========\n")

#we are gonna execute the SQL query
cursor.execute('''
    SELECT title, author, quantity_sold FROM sales
    ORDER BY quantity_sold DESC
    LIMIT 3;
''')

#the, we catch the result in a variable (the result is a list of tuples)
top_books = cursor.fetchall()

#iterating under the result
for row in top_books:
    print(f"{row[0]} by {row[1]}, Quantity: {row[2]}")

#SQL + Python: 1
print("\n========== Bestsellers of the Week ==========\n")

#we are gonna execute the SQL query
cursor.execute('''
    SELECT author, SUM(price * quantity_sold) AS "Total Earnings" 
    FROM sales
    WHERE quantity_sold > 10
    GROUP BY author
    ORDER BY "Total Earnings" DESC;
''')

#the, we catch the result in a variable (the result is a list of tuples)
bestsellers = cursor.fetchall()

#iterating through the result
for authors in bestsellers:
    print(f"Author: {authors[0]} | Earnings: {authors[1]}")

#close the conection
conection.close()