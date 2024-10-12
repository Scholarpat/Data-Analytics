## GROUP BY

-- Group the records by gender, retrieving one result per unique gender
SELECT gender
FROM employee_demographics
GROUP BY gender;

-- Group records by gender, calculating the average, maximum, minimum, and count of age for each gender
SELECT gender, AVG(age), MAX(age), MIN(age), COUNT(age)
FROM employee_demographics
GROUP BY gender;

## ORDER BY

-- Retrieve all records from employee_demographics and sort them by first_name in descending order
SELECT *
FROM employee_demographics
ORDER BY first_name DESC;

-- Retrieve all records from employee_demographics and sort them first by gender, then by age in ascending order
SELECT *
FROM employee_demographics
ORDER BY gender, age;

-- Retrieve all records from employee_demographics and sort them by the 5th and 4th columns. (This assumes the 5th and 4th columns in the table correspond to specific fields)
SELECT *
FROM employee_demographics
ORDER BY 5, 4;
