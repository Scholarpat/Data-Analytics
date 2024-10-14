## UNION

-- Returns a combined list of employees over 40 years old, labeled as 'Old man' or 'Old lady' based on gender, and includes highly paid employees labeled as 'Highly Paid Employee' for those with salaries over $70,000, ordered by first and last name.
SELECT first_name, last_name, 'Old man' AS LABEL
FROM employee_demographics
WHERE age > 40 AND gender = 'Male'
UNION
SELECT first_name, last_name, 'Old lady' AS LABEL
FROM employee_demographics
WHERE age > 40 AND gender = 'female'
UNION
SELECT first_name, last_name, 'Highly Paid Employee' AS LABEL
FROM employee_salary
WHERE salary > 70000
ORDER BY first_name, last_name;
