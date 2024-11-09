USE company_db

'Q1 -- FIND THE EMPLOYEE WHO''S SALARY IS MORE THAN THE AVERAGE SALARY OF ALL EMPLOYEE'

SELECT * FROM employees
JOIN salaries sa on sa.emp_no = employees.emp_no  /* inconsistency of emp_no between employees' table and other tables */ 
WHERE salary > (
	SELECT AVG(salary) FROM salaries);  -- 53760.4779

'Q2 -- 

