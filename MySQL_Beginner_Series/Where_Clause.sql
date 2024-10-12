## WHERE CLAUSE

-- Retrieve distinct records from employee_salary where the first name is 'Leslie'
SELECT DISTINCT *
FROM employee_salary
WHERE first_name = 'Leslie';

-- Retrieve distinct records from employee_salary where the salary is less than or equal to 50,000
SELECT DISTINCT *
FROM employee_salary
WHERE salary <= 50000;

-- Retrieve all records from employee_demographics where the gender is 'female'
SELECT *
FROM employee_demographics
WHERE gender = 'female';

-- Retrieve all records from employee_demographics where the gender is NOT 'female'
SELECT *
FROM employee_demographics
WHERE gender != 'female';

-- Retrieve all records from employee_demographics where the birth date is after January 1, 1985
SELECT *
FROM employee_demographics
WHERE birth_date > '1985-01-01';

## Logical operators (AND OR NOT)

-- Retrieve all records from employee_demographics where the birth date is after January 1, 1985 AND the gender is 'male'
SELECT *
FROM employee_demographics
WHERE birth_date > '1985-01-01'
AND gender = 'male';

-- Retrieve all records from employee_demographics where the birth date is after January 1, 1985 OR the gender is 'male'
SELECT *
FROM employee_demographics
WHERE birth_date > '1985-01-01'
OR gender = 'male';

-- Retrieve all records from employee_demographics where the birth date is after January 1, 1985 OR the gender is NOT 'male'
SELECT *
FROM employee_demographics
WHERE birth_date > '1985-01-01'
OR NOT gender = 'male';

-- Retrieve all records from employee_demographics where the first name is 'Leslie' AND the age is 44, OR the age is greater than 55
SELECT *
FROM employee_demographics
WHERE (first_name = 'Leslie' AND age = 44) OR age > 55;

## -- LIKE Statement: % (anything) and _ (specific value)

-- Retrieve all records where the first name starts with 'Jer'
SELECT *
FROM employee_demographics
WHERE first_name LIKE 'Jer%';

-- Retrieve all records where the first name contains 'er' anywhere in the string
SELECT *
FROM employee_demographics
WHERE first_name LIKE '%er%';

-- Retrieve all records where the first name starts with 'a'
SELECT *
FROM employee_demographics
WHERE first_name LIKE 'a%';

-- Retrieve all records where the first name starts with 'a' and has exactly 3 characters
SELECT *
FROM employee_demographics
WHERE first_name LIKE 'a__';

-- Retrieve all records where the first name starts with 'a' and has at least 3 characters
SELECT *
FROM employee_demographics
WHERE first_name LIKE 'a__%';
