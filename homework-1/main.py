"""Скрипт для заполнения данными таблиц в БД Postgres."""
import psycopg2
import csv


# open CSV files
with open('north_data/employees_data.csv', mode='r', newline='') as employee_file,\
     open('north_data/customers_data.csv', mode='r', newline='') as customer_file, \
     open('north_data/orders_data.csv', mode='r', newline='') as order_file:

    employee_data = csv.reader(employee_file)
    next(employee_data)  # skip header row
    customer_data = csv.reader(customer_file)
    next(customer_data)  # skip header row
    order_data = csv.reader(order_file)
    next(order_data)  # skip header row

    # connect to database
    conn = psycopg2.connect(host='localhost', database='north', user='postgres', password='B@nkin1993')
    try:
        with conn:
            with conn.cursor() as cur:
                # insert data into employees table
                for employee in employee_data:
                    cur.execute('INSERT INTO employees (last_name, first_name, title, birth_date, notes)'
                                ' VALUES  (%s, %s, %s, %s, %s)', employee)

                # insert data into customers table
                for customer in customer_data:
                    cur.execute("INSERT INTO customers VALUES (%s, %s, %s)", customer)

                # Insert data into orders table
                for order in order_data:
                    cur.execute("INSERT INTO orders VALUES (%s, %s, %s, %s, %s)", order)

                cur.execute("SELECT * FROM employees")
                rows = cur.fetchall()
                print("Employees:")
                for row in rows:
                    print(row)

                cur.execute("SELECT * FROM customers")
                rows = cur.fetchall()
                print("Customers:")
                for row in rows:
                    print(row)

                cur.execute("SELECT * FROM orders")
                rows = cur.fetchall()
                print("Orders:")
                for row in rows:
                    print(row)
    finally:
        conn.close()
