## CASE STATEMENTS

-- Returns the first name, last name, age, and a label (Age_Bracket) indicating whether an employee is 'Young', 'Old', or 'On Death's Door' based on their age.
SELECT first_name, last_name, age,
CASE
	WHEN age <= 30 THEN 'Young'
    WHEN age BETWEEN 31 AND 50 THEN 'Old'
    WHEN age >= 50 THEN "On Death's Door"
END AS Age_Bracket
FROM employee_demographics;

/* Returns the first name, last name, current salary, new salary after a percentage increase based on salary thresholds, 
	and a bonus if the employee works in the Finance department (dept_id = 6). 
	Employees with a salary < 50000 get a 5% raise, and those with a salary > 50000 get a 7% raise. Finance employees also get a 10% bonus.*/
SELECT first_name, last_name, salary,
CASE
	WHEN salary < 50000 THEN salary + (salary * 0.05)
    WHEN salary > 50000 THEN salary + (salary * 0.07)
END AS New_Salary,
CASE
	WHEN dept_id = 6 THEN salary * 0.10
END AS Bonus
FROM employee_salary;
