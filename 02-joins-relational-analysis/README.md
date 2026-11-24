/*
Project: Customer Orders & Relational Data Analysis
File: 02-relational-sales-analysis.sql
Database: relational_sales_analysis
Platform: MySQL

Purpose:
Demonstrate relational database design, primary and foreign keys,
sample data management, multi-table JOINs, and customer purchase analysis
using a Common Table Expression (CTE).

IMPORTANT:
This is a rebuild script for the sample project. It drops and recreates
the four project tables before inserting the sample data. Running it again
will replace the existing sample records in these tables.
*/

-- 1. Create and select the database

CREATE DATABASE IF NOT EXISTS relational_sales_analysis;

USE relational_sales_analysis;


-- 2. Drop existing tables in dependency order
-- Child tables must be dropped before their parent tables.

DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS customers;


-- 3. Create the customers table

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE,
    city VARCHAR(50),
    registration_date DATE
) ENGINE = InnoDB;


-- 4. Create the products table

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50),
    unit_price DECIMAL(10, 2) NOT NULL,
    stock_quantity INT DEFAULT 0
) ENGINE = InnoDB;


-- 5. Create the orders table

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date DATE NOT NULL,
    order_status VARCHAR(30),

    CONSTRAINT fk_orders_customers
        FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id)
) ENGINE = InnoDB;


-- 6. Create the order_items table

CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    unit_price DECIMAL(10, 2) NOT NULL,

    CONSTRAINT fk_order_items_orders
        FOREIGN KEY (order_id)
        REFERENCES orders(order_id),

    CONSTRAINT fk_order_items_products
        FOREIGN KEY (product_id)
        REFERENCES products(product_id),

    CONSTRAINT uq_order_product
        UNIQUE (order_id, product_id)
) ENGINE = InnoDB;


-- 7. Insert sample customer records

INSERT INTO customers
(customer_id, first_name, last_name, email, city, registration_date)
VALUES
(1, 'Daniel', 'Adams', 'daniel@email.com', 'Lagos', '2024-01-10'),
(2, 'Sarah', 'Johnson', 'sarah@email.com', 'Abuja', '2024-02-15'),
(3, 'Michael', 'Brown', 'michael@email.com', 'Ibadan', '2024-03-20'),
(4, 'Grace', 'Williams', 'grace@email.com', 'Lagos', '2024-04-05'),
(5, 'David', 'Miller', 'david@email.com', 'Abeokuta', '2024-05-12'),
(6, 'Olivia', 'Taylor', 'olivia@email.com', 'Abuja', '2024-06-18'),
(7, 'James', 'Wilson', 'james@email.com', 'Lagos', '2024-07-22'),
(8, 'Emma', 'Davis', 'emma@email.com', 'Ibadan', '2024-08-09');


-- 8. Insert sample product records

INSERT INTO products
(product_id, product_name, category, unit_price, stock_quantity)
VALUES
(101, 'Laptop', 'Electronics', 1200.00, 15),
(102, 'Office Chair', 'Furniture', 2500.00, 20),
(103, 'Printer', 'Electronics', 8000.00, 8),
(104, 'Desk Lamp', 'Accessories', 1500.00, 30),
(105, 'Notebook', 'Stationery', 500.00, 100),
(106, 'Projector', 'Electronics', 15000.00, 5);


-- 9. Insert sample order records

INSERT INTO orders
(order_id, customer_id, order_date, order_status)
VALUES
(1001, 1, '2024-09-01', 'Completed'),
(1002, 2, '2024-09-03', 'Completed'),
(1003, 1, '2024-09-05', 'Pending'),
(1004, 3, '2024-09-08', 'Completed'),
(1005, 4, '2024-09-10', 'Processing'),
(1006, 5, '2024-09-12', 'Completed'),
(1007, 6, '2024-09-15', 'Pending'),
(1008, 7, '2024-09-18', 'Completed'),
(1009, 2, '2024-09-20', 'Processing'),
(1010, 4, '2024-09-22', 'Completed');


-- 10. Insert sample order-item records

INSERT INTO order_items
(order_item_id, order_id, product_id, quantity, unit_price)
VALUES
(1, 1001, 101, 2, 1200.00),
(2, 1001, 102, 1, 2500.00),
(3, 1002, 103, 1, 8000.00),
(4, 1002, 104, 2, 1500.00),
(5, 1003, 105, 3, 500.00),
(6, 1004, 101, 1, 1200.00),
(7, 1005, 102, 2, 2500.00),
(8, 1005, 103, 1, 8000.00),
(9, 1006, 104, 3, 1500.00),
(10, 1007, 101, 1, 1200.00),
(11, 1007, 105, 2, 500.00),
(12, 1008, 103, 2, 8000.00),
(13, 1009, 102, 1, 2500.00),
(14, 1010, 105, 4, 500.00);


-- 11. Verify record counts

SELECT 'customers' AS table_name, COUNT(*) AS total_records
FROM customers
UNION ALL
SELECT 'products', COUNT(*) FROM products
UNION ALL
SELECT 'orders', COUNT(*) FROM orders
UNION ALL
SELECT 'order_items', COUNT(*) FROM order_items;


-- 12. Multi-table INNER JOIN
-- Combines customers, orders, order items, and products.

SELECT
    o.order_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    c.city,
    p.product_name,
    oi.quantity,
    oi.unit_price,
    (oi.quantity * oi.unit_price) AS line_total,
    o.order_status
FROM orders AS o
INNER JOIN customers AS c
    ON o.customer_id = c.customer_id
INNER JOIN order_items AS oi
    ON o.order_id = oi.order_id
INNER JOIN products AS p
    ON oi.product_id = p.product_id
ORDER BY o.order_id;


-- 13. Customer purchase summary using a CTE
-- LEFT JOIN keeps customers who have not placed any orders.

WITH customer_purchase_summary AS (
    SELECT
        c.customer_id,
        CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
        COUNT(DISTINCT o.order_id) AS total_orders,
        COALESCE(SUM(oi.quantity), 0) AS total_units_purchased,
        COALESCE(
            SUM(oi.quantity * oi.unit_price), 0
        ) AS total_amount_spent
    FROM customers AS c
    LEFT JOIN orders AS o
        ON c.customer_id = o.customer_id
    LEFT JOIN order_items AS oi
        ON o.order_id = oi.order_id
    GROUP BY
        c.customer_id,
        c.first_name,
        c.last_name
)

SELECT *
FROM customer_purchase_summary
ORDER BY total_amount_spent DESC;
