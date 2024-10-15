## TRIGGERS

-- Creates a trigger that automatically fires **after** a new row is inserted into the `employee_salary` table.
DELIMITER $$
CREATE TRIGGER employee_insert
	AFTER INSERT ON employee_salary
    FOR EACH ROW
BEGIN
	-- Inserts the new employee's details into the `employee_demographics` table.
	INSERT INTO employee_demographics (employee_id, first_name, last_name)
    VALUES (NEW.employee_id, NEW.first_name, NEW.last_name);
END $$
DELIMITER ;

-- The trigger will automatically add this new employee's details to the `employee_demographics` table.
INSERT INTO employee_salary (employee_id, first_name, last_name, occupation, salary, dept_id)
VALUES (13, 'Jean-Ralphio', 'Saperstein', 'Entertainment 720 CEO', 1000000, NULL);

## EVENTS

-- Creates a scheduled event that runs every month to delete records from the `employee_demographics` table where the employee's age is 60 or older, simulating the removal of retirees.
DELIMITER $$
CREATE EVENT delete_retirees
ON SCHEDULE EVERY 1 MONTH
DO
BEGIN
	-- Deletes employees aged 60 or older from the `employee_demographics` table.
	DELETE
    FROM employee_demographics
    WHERE age >= 60;
END $$
DELIMITER ;

-- Shows the current status of event scheduler-related system variables to verify if events are enabled.
SHOW VARIABLES LIKE 'event%';
