## SUBQUERIES

-- Returns all employee demographic records for employees who are assigned to department 1.
SELECT *
FROM employee_demographics
WHERE employee_id IN 
    (SELECT employee_id
        FROM employee_salary
        WHERE dept_id = 1);

-- Returns each employee's first name and salary, along with the overall average salary of all employees.
-- The average salary is the same for every row since it's a scalar subquery.
SELECT first_name, salary,
    (SELECT AVG(salary)
        FROM employee_salary) AS average_salary
FROM employee_salary;

-- Returns the average age, maximum age, minimum age, and the total number of employees for each gender.
SELECT gender, 
       AVG(age) AS average_age, 
       MAX(age) AS maximum_age, 
       MIN(age) AS minimum_age, 
       COUNT(age) AS total_employees
FROM employee_demographics
GROUP BY gender;

-- Returns the average of the maximum ages across all gender groups.
SELECT AVG(max_age) AS average_of_max_ages
FROM
    (SELECT gender,
            AVG(age) AS avg_age,
            MAX(age) AS max_age,
            MIN(age) AS min_age,
            COUNT(age) AS count_age
     FROM employee_demographics
     GROUP BY gender) AS Agg_table;
