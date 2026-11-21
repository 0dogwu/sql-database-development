-- SQL Fundamentals: SELECT, Filtering, and Sorting
-- Database: MySQL

-- 1. Create a database
CREATE DATABASE sql_fundamentals;

-- 2. Select the database
USE sql_fundamentals;

-- 3. Create a sample table
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    department VARCHAR(50),
    salary DECIMAL(10, 2),
    hire_date DATE
);

-- 4. Insert sample records
INSERT INTO employees
(employee_id, first_name, last_name, department, salary, hire_date)
VALUES
(1, 'Daniel', 'Adams', 'IT', 250000.00, '2024-01-15'),
(2, 'Sarah', 'Johnson', 'HR', 180000.00, '2023-06-10'),
(3, 'Michael', 'Brown', 'Finance', 220000.00, '2022-09-20'),
(4, 'Grace', 'Williams', 'IT', 300000.00, '2023-03-12'),
(5, 'David', 'Miller', 'Marketing', 200000.00, '2024-05-01');

-- 5. Retrieve all employee records
SELECT *
FROM employees;

-- 6. Retrieve specific columns
SELECT first_name, last_name, department
FROM employees;

-- 7. Filter employees by department
SELECT *
FROM employees
WHERE department = 'IT';

-- 8. Filter employees by salary
SELECT *
FROM employees
WHERE salary > 200000;

-- 9. Sort employees by salary from highest to lowest
SELECT *
FROM employees
ORDER BY salary DESC;

-- 10. Retrieve unique departments
SELECT DISTINCT department
FROM employees;

-- 11. Retrieve the first three records
SELECT *
FROM employees
LIMIT 3;
