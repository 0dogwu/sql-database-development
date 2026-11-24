
# Customer Orders & Relational Data Analysis

**Project:** SQL Database Development  
**Database:** `relational_sales_analysis`  
**Platform:** MySQL

---

## 1. Project Overview

This project demonstrates relational database development and SQL-based analysis using a sample business sales database.

The project focuses on designing related database tables, establishing relationships, managing records, and retrieving meaningful information through SQL queries.

The database contains four related tables:

| Table | Description |
|---|---|
| `customers` | Stores customer information |
| `products` | Stores product details |
| `orders` | Records customer orders |
| `order_items` | Records products and quantities within each order |

## 2. Database Design and Relationships

The database uses primary keys and foreign keys to establish relationships between tables and maintain referential integrity.

The relationships include:

- One customer can place multiple orders.
- One order can contain multiple order items.
- One product can appear in multiple order items.
- The `order_items` table connects orders and products.

Additional database constraints include:

- Primary key constraints
- Foreign key constraints
- Unique constraints
- NOT NULL constraints
- Default values

## 3. SQL Concepts Demonstrated

### Relational Database Development
- Database creation and organisation
- Table creation and structure
- Primary and foreign key relationships
- Data integrity and constraints

### SQL Querying and Data Management
- INSERT statements
- SELECT statements
- Multi-table JOIN operations
- INNER JOIN
- LEFT JOIN
- Common Table Expressions (CTEs)
- Aggregate functions
- COUNT and COUNT DISTINCT
- SUM and COALESCE
- GROUP BY and ORDER BY

## 4. Project Analysis

### A. Multi-Table INNER JOIN

A multi-table JOIN query was developed to combine information from the four related tables.

The query retrieves:

- Order identification
- Customer names
- Customer locations
- Product names
- Product quantities
- Unit prices
- Order item totals
- Order status

**Purpose:** To demonstrate how related records can be retrieved and analysed across multiple database tables.

### B. Customer Purchase Summary Using a CTE

A Common Table Expression (CTE) was used to generate a customer-level purchase summary.

The analysis includes:

- Total orders per customer
- Total product units purchased
- Total amount spent by each customer

The query uses LEFT JOIN to retain customers who have not placed orders and COALESCE to display zero for missing purchase totals.

**Purpose:** To demonstrate advanced SQL querying, relational analysis, and customer purchase summarisation.

## 5. Dataset Summary

The project uses fictional sample business records.

| Database Table | Number of Records |
|---|---:|
| Customers | 8 |
| Products | 6 |
| Orders | 10 |
| Order Items | 14 |

The multi-table INNER JOIN returns 14 records, while the customer purchase summary returns 8 customer records.

## 6. How to Run the Project

1. Install and open MySQL Workbench.
2. Open the SQL script included in this project.
3. Connect to your MySQL server.
4. Execute the script.
5. Review the database tables and query results.

**Important:** The SQL script drops and recreates the four project tables before inserting the sample records. Running it again replaces the existing sample data in those tables. Do not execute it against tables containing data you need to preserve.

## 7. Project Files

- `02-relational-sales-analysis.sql` — Complete SQL script containing database creation, table definitions, sample records, JOIN queries, and CTE analysis.
- `README.md` — Project documentation.

## 8. Scope and Limitations

This is a practical SQL portfolio project developed using fictional business data for learning and demonstration purposes.

It demonstrates relational database design, database management concepts, SQL querying, and data analysis. It is not a production business application.

---

**Technology:** MySQL  
**Project Category:** Database Development and Data Analysis
