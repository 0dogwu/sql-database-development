/*
Project: SQL Fundamentals
File: 01-select-filter-sort.sql
Database: MySQL

Purpose:
Demonstrate SQL querying, filtering, sorting,
data transformation, and aggregation.
*/

-- 1. Create and select the database

CREATE DATABASE IF NOT EXISTS business_operations;

USE business_operations;


-- 2. Create the employees table

CREATE TABLE IF NOT EXISTS employees (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    department VARCHAR(50),
    job_title VARCHAR(100),
    salary DECIMAL(12, 2),
    employment_status VARCHAR(20),
    hire_date DATE
);


-- 3. Insert sample business records

INSERT INTO employees (
    employee_id,
    first_name,
    last_name,
    department,
    job_title,
    salary,
    employment_status,
    hire_date
)
VALUES
(101, 'Daniel', 'Adams', 'Technology', 'Database Developer', 450000, 'Active', '2022-03-15'),
(102, 'Sarah', 'Johnson', 'Human Resources', 'HR Manager', 380000, 'Active', '2021-06-10'),
(103, 'Michael', 'Brown', 'Finance', 'Financial Analyst', 420000, 'Active', '2020-09-20'),
(104, 'Grace', 'Williams', 'Technology', 'Data Analyst', 400000, 'Active', '2023-01-12'),
(105, 'David', 'Miller', 'Marketing', 'Marketing Executive', 280000, 'Inactive', '2022-05-01'),
(106, 'Olivia', 'Taylor', 'Finance', 'Accountant', 320000, 'Active', '2024-02-18'),
(107, 'James', 'Wilson', 'Technology', 'Software Engineer', 500000, 'Active', '2019-11-25'),
(108, 'Emma', 'Davis', 'Marketing', 'Content Strategist', 300000, 'Active', '2023-07-14'),
(109, 'Noah', 'Martin', NULL, 'Operations Assistant', 250000, 'Active', '2024-04-08'),
(110, 'Sophia', 'Clark', 'Human Resources', 'Recruitment Officer', 290000, 'Inactive', '2022-12-01');


-- 4. Retrieve all employee records

SELECT *
FROM employees;


-- 5. Retrieve selected columns with aliases

SELECT
    employee_id,
    CONCAT(first_name, ' ', last_name) AS employee_name,
    department,
    salary AS monthly_salary
FROM employees;


-- 6. Filter records using comparison operators

SELECT *
FROM employees
WHERE salary > 350000;


-- 7. Filter using multiple conditions

SELECT *
FROM employees
WHERE department = 'Technology'
  AND employment_status = 'Active';


-- 8. Filter using BETWEEN

SELECT *
FROM employees
WHERE salary BETWEEN 300000 AND 450000;


-- 9. Filter using IN

SELECT *
FROM employees
WHERE department IN ('Technology', 'Finance');


-- 10. Filter using LIKE and pattern matching

SELECT *
FROM employees
WHERE first_name LIKE 'S%';


-- 11. Identify missing department values

SELECT *
FROM employees
WHERE department IS NULL;


-- 12. Exclude missing department values

SELECT *
FROM employees
WHERE department IS NOT NULL;


-- 13. Retrieve unique departments

SELECT DISTINCT department
FROM employees;


-- 14. Sort records by salary in descending order

SELECT *
FROM employees
ORDER BY salary DESC;


-- 15. Sort by multiple columns

SELECT *
FROM employees
ORDER BY department ASC, salary DESC;


-- 16. Retrieve the five highest-paid employees

SELECT
    employee_id,
    first_name,
    last_name,
    department,
    salary
FROM employees
ORDER BY salary DESC
LIMIT 5;


-- 17. Calculate annual salary

SELECT
    employee_id,
    CONCAT(first_name, ' ', last_name) AS employee_name,
    salary AS monthly_salary,
    salary * 12 AS annual_salary
FROM employees;


-- 18. Aggregate employee salary information

SELECT
    COUNT(*) AS total_employees,
    ROUND(AVG(salary), 2) AS average_salary,
    MAX(salary) AS highest_salary,
    MIN(salary) AS lowest_salary,
    SUM(salary) AS total_monthly_payroll
FROM employees;


-- 19. Count employees by department

SELECT
    department,
    COUNT(*) AS employee_count
FROM employees
GROUP BY department
ORDER BY employee_count DESC;


-- 20. Filter grouped results using HAVING

SELECT
    department,
    ROUND(AVG(salary), 2) AS average_salary
FROM employees
WHERE department IS NOT NULL
GROUP BY department
HAVING AVG(salary) > 300000
ORDER BY average_salary DESC;
