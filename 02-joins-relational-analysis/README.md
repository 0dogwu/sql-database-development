Customer Orders & Relational Data Analysis
Project: SQL Database Development
Database: relational_sales_analysis
Platform: MySQL
Project overview
This project demonstrates how a small sales database can be structured using related tables and queried to analyse customer orders and product purchases.

The dataset is fictional and created for SQL learning and portfolio demonstration. It contains four related tables:
Table	Purpose
customers	Stores customer details
products	Stores product information
orders	Records orders placed by customers
order_items	Records the products and quantities included in each order


Database relationships
- One customer can have many orders.
- One order can have many order items.
- One product can appear in many order items.
- order_items connects orders and products at the order-line level.
The tables use primary keys and foreign keys to define relationships and maintain referential integrity. The order_items table also has a unique constraint on (order_id, product_id) to prevent the same product from being entered more than once for one order in this sample design.
SQL concepts demonstrated
- Relational database and table creation
- Primary keys and foreign key constraints
- Unique constraints
- Inserting and verifying sample records
- Multi-table INNER JOIN
- Multi-table LEFT JOIN
- Common Table Expressions (CTEs)
- COUNT(DISTINCT ...), SUM() and COALESCE()
- Grouping and ordering analytical results
Project queries
1. Multi-table INNER JOIN
Combines the four tables to show each order, customer, city, product, quantity, unit price, line total and order status.
2. Customer purchase summary using a CTE
Builds a customer-level summary showing the number of orders, total units purchased and total amount spent. The LEFT JOIN keeps customers with no orders in the output, while COALESCE() displays zero for missing totals.
Expected sample data
After the setup and insert statements run successfully, the record counts should be:
Table	Records
customers	8
products	6
orders	10
order_items	14


The four-table INNER JOIN returns 14 order-item rows. The CTE summary returns 8 customer rows.
How to run
1. Open MySQL Workbench.
2. Open 02-relational-sales-analysis.sql.
3. Review the setup script before execution.
4. Execute the script against a MySQL server.
5. Review the record-count verification query and the two analytical result sets.
Important: The script is a rebuild script. It drops and recreates the four project tables before inserting the sample data. Running it again replaces the sample data in those tables. Do not run it against tables containing data you need to keep.
Repository structure
sql-database-development/
├── 01-sql-fundamentals/
│   ├── 01-select-filter-sort.sql
│   └── README.md
├── 02-joins-relational-analysis/
│   ├── 02-relational-sales-analysis.sql
│   └── README.md
└── README.md
Scope and limitations
This is a sample-data portfolio project intended to demonstrate SQL and relational database concepts. It is not a production sales system and does not use real customer or business records.
