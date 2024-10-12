## SELECT STATEMENT

-- Retrieve all columns and rows from the employee_demographics table
SELECT *
FROM employee_demographics;

-- Retrieve all columns and rows from the employee_salary table
SELECT *
FROM employee_salary;

-- Retrieve the first name, last name, birth date, age, perform a calculation on age, and create a new column to display the result
SELECT first_name,
       last_name,
       birth_date,
       age,
       (age + 10) * 10 + 10
FROM employee_demographics;

/* Any calculations within MySQL follow the rule of PEMDAS. This is the order of operations in mathematics: Parentheses, Exponents, Multiplication, Division, Addition, Subtraction.
This means that calculations enclosed in parentheses are performed first, followed by exponents, then multiplication and division (from left to right),
and finally, addition and subtraction (also from left to right).
*/

-- Retrieve distinct (unique) gender values from the employee_demographics table
SELECT DISTINCT gender
FROM employee_demographics;
