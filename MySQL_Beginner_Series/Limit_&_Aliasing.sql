## LIMIT

-- Returns the top 3 oldest individuals from the employee_demographics table,
SELECT *
FROM employee_demographics
ORDER BY age DESC
LIMIT 3;

-- Skips the first 4 records and returns the next 2 records from the employee_demographics table,
SELECT *
FROM employee_demographics
ORDER BY age DESC
LIMIT 4, 2;

## ALIASING

-- Selects using 'g' as an alias for gender and 'avg_age' as an alias for the average age.
SELECT gender AS g, AVG(age) AS avg_age
FROM employee_demographics
GROUP BY g
HAVING avg_age > 40;

-- NOTE: The 'AS' keyword in aliasing is usually implied and does not need to be explicitly stated.