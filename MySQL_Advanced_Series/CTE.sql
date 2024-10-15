## CTEs - Common Table Expressions

-- Calculates average, max, min, and count of salaries by gender, then returns the overall average of those average salaries.
WITH CTE_Example AS
(
    SELECT gender, AVG(salary) AS avg_sal, MAX(salary), MIN(salary), COUNT(salary)
    FROM employee_demographics dem
    JOIN employee_salary sal ON dem.employee_id = sal.employee_id
    GROUP BY gender
)
SELECT AVG(avg_sal)
FROM CTE_Example;

-- Selects employees born after 1985 and earning more than 50,000, combining results from two CTEs using employee_id.
WITH CTE_Example AS
(
    SELECT employee_id, gender, birth_date
    FROM employee_demographics
    WHERE birth_date > '1985-01-01'
),
CTE_Example2 AS
(
    SELECT employee_id, salary
    FROM employee_salary
    WHERE salary > 50000
)
SELECT *
FROM CTE_Example
JOIN CTE_Example2 ON CTE_Example.employee_id = CTE_Example2.employee_id;

-- Calculates and returns salary stats (avg, max, min, count) for each gender.
WITH CTE_Example (Gender, AVG_Sal, MAX_Sal, MIN_Sal, COUNT_Sal) AS
(
    SELECT gender, AVG(salary), MAX(salary), MIN(salary), COUNT(salary)
    FROM employee_demographics dem
    JOIN employee_salary sal ON dem.employee_id = sal.employee_id
    GROUP BY gender
)
SELECT *
FROM CTE_Example;
