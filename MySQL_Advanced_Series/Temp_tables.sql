## TEMPORARY TABLES

-- Creates a temporary table to store first name, last name, and favorite movie.
CREATE TEMPORARY TABLE temp_table
(first_name VARCHAR(50),
 last_name VARCHAR(50),
 favorite_movie VARCHAR(100));

-- Selects all records from the temporary table.
SELECT * 
FROM temp_table;

-- Inserts a row into the temporary table.
INSERT INTO temp_table
VALUES ('Alex', 'Freberg', 'Lord of the Rings: The Two Towers');

-- Selects all records from the employee_salary table.
SELECT * 
FROM employee_salary;

-- Creates a temporary table (from employee_salary table) storing records of employees with a salary of 50k or higher.
CREATE TEMPORARY TABLE salary_over_50k
SELECT * 
FROM employee_salary
WHERE salary >= 50000;

-- Selects all records from the salary_over_50k temporary table.
SELECT * 
FROM salary_over_50k;
