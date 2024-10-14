## INNER JOINS

-- Returns records that have matching employee IDs in both employee demographics and salary tables.
SELECT *
FROM employee_demographics AS dem
INNER JOIN employee_salary AS sal
	ON dem.employee_id = sal.employee_id;

-- Returns the employee ID, age, and occupation for employees who have salary records.
SELECT dem.employee_id, age, occupation
FROM employee_demographics AS dem
INNER JOIN employee_salary AS sal
	ON dem.employee_id = sal.employee_id;

## LEFT OUTER JOIN

-- Returns all records from employee demographics and matching records from employee salary; unmatched records from salary will be NULL.
SELECT *
FROM employee_demographics AS dem
LEFT JOIN employee_salary AS sal
	ON dem.employee_id = sal.employee_id;

## RIGHT OUTER JOIN

-- Returns all records from employee salary and matching records from employee demographics; unmatched records from demographics will be NULL.
SELECT *
FROM employee_demographics AS dem
RIGHT JOIN employee_salary AS sal
	ON dem.employee_id = sal.employee_id;

## SELF JOIN

-- Returns records from the employee salary table, showing comparisons within the same table.
SELECT *
FROM employee_salary AS emp1
JOIN employee_salary AS emp2
	ON emp1.employee_id = emp1.employee_id;

-- Returns adjacent employee records from the employee salary table by comparing employee IDs that differ by one.
SELECT emp1.employee_id AS emp_santa,
emp1.first_name AS first_name_santa,
emp1.last_name AS last_name_santa,
emp2.employee_id AS emp_name,
emp2.first_name AS first_name_emp,
emp2.last_name AS last_name_emp
FROM employee_salary AS emp1
JOIN employee_salary AS emp2
	ON emp1.employee_id + 1 = emp2.employee_id;

## JOINING MULTIPLE TABLES

-- Returns records that match across employee demographics, employee salary, and parks departments.
SELECT *
FROM employee_demographics dem
INNER JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id
INNER JOIN parks_departments pd
	ON sal.dept_id = pd.department_id;
