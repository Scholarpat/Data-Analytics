## STORED PROCEDURES

-- Creates a stored procedure that retrieves all employees with a salary of 50,000 or more.
CREATE PROCEDURE large_salaries()
SELECT * 
FROM employee_salary
WHERE salary >= 50000;

-- Calls the large_salaries procedure to return records with a salary >= 50,000.
CALL large_salaries();

-- Creates a stored procedure that retrieves employees with salary >= 50,000 and then a separate query for employees with salary >= 10,000.
DELIMITER $$  -- Changes the delimiter to $$ to handle multiple statements.
CREATE PROCEDURE large_salaries2()
BEGIN
	SELECT * 
	FROM employee_salary
	WHERE salary >= 50000;
    
    SELECT * 
	FROM employee_salary
	WHERE salary >= 10000;
END $$ -- Ends the procedure definition.
DELIMITER ;  -- Resets the delimiter back to the default (;).

-- Calls the large_salaries2 procedure to execute both salary queries.
CALL large_salaries2();

-- Creates a stored procedure that accepts an employee ID as input (parameter) and retrieves the salary for that specific employee.
DELIMITER $$  -- Changes the delimiter to $$ to handle the procedure definition.
CREATE PROCEDURE large_salaries3(employee_id_param INT)
BEGIN
	SELECT salary 
	FROM employee_salary
	WHERE employee_id = employee_id_param;
END $$ -- Ends the procedure definition.
DELIMITER ;  -- Resets the delimiter back to the default (;).

-- Calls large_salaries3, passing in an employee ID to return the employee's salary.
CALL large_salaries3(1);
