## HAVING VS WHERE

SELECT gender, AVG(age)
FROM employee_demographics
GROUP BY gender
HAVING AVG(age) > 40;

SELECT occupation, AVG(salary)
FROM employee_salary
WHERE occupation LIKE '%manager%'
GROUP BY occupation
HAVING AVG(salary) > 75000;

/*
WHERE: Filters records before grouping.
It is used to filter individual rows.

HAVING: Filters records after grouping.
It is used to filter groups (or aggregate results) based on conditions applied to the group.
*/

