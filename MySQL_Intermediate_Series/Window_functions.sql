# WINDOW FUNCTIONS

-- Returns the average salary for each gender, grouping the data by gender.
SELECT gender, AVG(salary) AS avg_salary
FROM employee_demographics dem
	JOIN employee_salary sal
    ON dem.employee_id = sal.employee_id
GROUP BY gender;

-- Returns each employee's gender and the average salary for that gender.
-- The average salary is calculated using a window function (no grouping) and is repeated for each employee within the same gender group.
SELECT gender, AVG(salary) OVER(PARTITION BY gender) AS avg_salary_by_gender
FROM employee_demographics dem
	JOIN employee_salary sal
    ON dem.employee_id = sal.employee_id;

-- Returns the first name, last name, gender, and the average salary for employees grouped by gender.
SELECT dem.first_name, dem.last_name, gender, AVG(salary) OVER(PARTITION BY gender) AS avg_salary_by_gender
FROM employee_demographics dem
	JOIN employee_salary sal
    ON dem.employee_id = sal.employee_id;

-- Returns the first name, last name, gender, salary, and a running total (rolling sum) of salaries for employees within each gender group, ordered by employee_id.
SELECT dem.first_name, dem.last_name, gender, salary,
SUM(salary) OVER(PARTITION BY gender ORDER BY dem.employee_id) AS Rolling_Total
FROM employee_demographics dem
	JOIN employee_salary sal
    ON dem.employee_id = sal.employee_id;

-- Returns the employee ID, first name, last name, gender, salary, and a row number assigned to each employee in the result set.
-- The row numbers are assigned without partitioning or ordering.
SELECT dem.employee_id, dem.first_name, dem.last_name, gender, salary,
ROW_NUMBER() OVER() AS row_num
FROM employee_demographics dem
	JOIN employee_salary sal
    ON dem.employee_id = sal.employee_id;

-- Returns the employee ID, first name, last name, gender, salary, and three different types of rankings:
-- 1. Row number: Sequential row number per gender, ordered by salary (descending).
-- 2. Rank: Ranking per gender, with gaps if there are ties.
-- 3. Dense rank: Ranking per gender without gaps, even if there are ties.
SELECT dem.employee_id, dem.first_name, dem.last_name, gender, salary,
ROW_NUMBER() OVER(PARTITION BY gender ORDER BY salary DESC) AS row_num,
RANK() OVER(PARTITION BY gender ORDER BY salary DESC) AS rank_num,
DENSE_RANK() OVER(PARTITION BY gender ORDER BY salary DESC) AS dense_rank_num
FROM employee_demographics dem
	JOIN employee_salary sal
    ON dem.employee_id = sal.employee_id;
