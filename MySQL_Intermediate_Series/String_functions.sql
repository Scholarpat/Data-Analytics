## STRING FUNCTIONS

-- Returns the first name and its length for each employee, ordered by the length of the first name.
SELECT first_name, LENGTH(first_name)
FROM employee_demographics
ORDER BY 2;

-- Returns the first name of each employee in uppercase.
SELECT first_name, UPPER(first_name)
FROM employee_demographics;

-- Returns the first name of each employee in lowercase.
SELECT first_name, LOWER(first_name)
FROM employee_demographics;

-- Returns the string 'sky' with leading and trailing spaces removed.
SELECT TRIM('       sky       ');

-- Returns the string 'sky' with leading spaces removed.
SELECT LTRIM('       sky       ');

-- Returns the string 'sky' with trailing spaces removed.
SELECT RTRIM('       sky       ');

-- Returns the first name, the first four characters, the last four characters, the substring from the 3rd to 4th character, the birth date, and the birth month (as a substring) for each employee.
SELECT first_name,
LEFT(first_name, 4),
RIGHT(first_name, 4),
SUBSTRING(first_name, 3, 2),
birth_date,
SUBSTRING(birth_date, 6, 2) AS birth_month
FROM employee_demographics;

-- Returns the first name with all occurrences of 'a' replaced by 'z'.
SELECT first_name, REPLACE(first_name, 'a', 'z')
FROM employee_demographics;

-- Returns the first name and the position of the substring 'An' within it for each employee.
SELECT first_name, LOCATE('An', first_name)
FROM employee_demographics;

-- Returns the first name, last name, and the full name (concatenation of first and last name) for each employee.
SELECT first_name, last_name,
CONCAT(first_name,' ', last_name) AS full_name
FROM employee_demographics;
