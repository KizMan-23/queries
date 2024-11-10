USE company_db

'Q1 -- FIND THE EMPLOYEE WHO''S SALARY IS MORE THAN THE AVERAGE SALARY OF ALL EMPLOYEE'

SELECT * FROM employees
JOIN salaries sa on sa.emp_no = employees.emp_no  /* inconsistency of emp_no between employees' table and other tables */ 
WHERE salary > (									/* importing a new and different table */
	SELECT AVG(salary) FROM salaries);  -- 53760.4779


/*	USING NEW DATASET */
-- Scalar subquery --
SELECT * FROM sample_employees 
WHERE salary > (								
	SELECT AVG(salary) FROM sample_employees)



'MULTIPLE ROW SUBQUERY'
'Q2 -- FIND THE EMPLOYEE WHO EARNS THE HIGHEST SALARY IN EACH DEPARTMENT'

SELECT * from sample_employees
Group by department
order by max(salary), department desc

select department, max(salary)
from sample_employees
group by department
order by max(salary) desc


SELECT * from sample_employees
where (department, salary) IN (select department, max(salary)
								from sample_employees
								group by department
								order by max(salary) desc)
                                
                                
'Q3 -- FIND THE DEPARMENT WHO DO NOT HAVE ANY MANAGERS'

select distinct dept_no
from dept_managers

select department 
from sample_employees
where department not in (select distinct dept_no
						from dept_managers);
                        
-- correlated query --
select * from sample_employees s
where not exists (select * from dept_managers d where s.department = d.department);
                        
'CORRELATED SUBQUERY'

'Q4 -- FIND EMPLOYEES IN EACH DEPARTMENT WHO EARN MORE THAN THE AVERAGE SALARY IN THAT DEPARTMENT'

select department, avg(salary)
from sample_employees
group by department

select * from  sample_employees e1
where salary > ( select avg(salary)
				from sample_employees e2
				where e2.department = e1.department);
                
