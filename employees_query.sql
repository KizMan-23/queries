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
where not exists (select * from dept_managers d where s.department = d.dept_no);
                        
'CORRELATED SUBQUERY'

'Q4 -- FIND EMPLOYEES IN EACH DEPARTMENT WHO EARN MORE THAN THE AVERAGE SALARY IN THAT DEPARTMENT'

WITH dept_avg AS (select department, CAST(avg(salary) AS SIGNED) as avg_sal
				from sample_employees
				group by department)

SELECT * from sample_employees e1
Join dept_avg ON dept_avg.department = e1.department
WHERE e1.salary > dept_avg.avg_sal
--------2 
select * from  sample_employees e1
where salary > ( select avg(salary)
				from sample_employees e2
				where e2.department = e1.department
                group by e2.department);
                

'NESTED QUERY'
'Q5 -- FETCH ALL EMPLOYEE DETAILS AND ADD REMARKS TO THOSE WHO EARN MORE THAN THE AVERAGE EMPLOYEE'

SELECT * ,
(CASE WHEN salary > (select Avg(salary) from sample_employees)
	then 'Higher Salary than Avg'
	else "Below Avg"
            end ) AS remarks
FROM sample_employees

------2 
SELECT * ,
(CASE WHEN salary > avg_sal.sal
	then 'Higher Salary than Avg'
	else "Below Avg"
	end ) AS remarks
FROM sample_employees
cross join (select Avg(salary) sal from sample_employees) avg_sal

'Q6 -- Insert data to employee history table. Make sure not to insert duplicate records'

INSERT INTO employee_history
SELECT distinct se.emp_no, se.first_name, se.last_name, se.emp_status, se.salary
from sample_employees se
where not exists ( select 1 from employee_history eh
					where eh.emp_no = se.emp_no);


'Q7 - Give 10% increment to all employees of Staff and Senior Staff position based on the maximum salary earned by an emp in each dept'

with dept_max as (select department, max(salary) as top_salary from sample_employees
group by department)

select *, (top_salary*0.1) as bonus
from sample_employees e1
join dept_max dm ON dm.department = e1.department
where e1.emp_status IN ("Staff",'Senior Staff')   'Use of OR in query'

