USE employees;

# Q1 - Write a query that returns all employees (emp_no), their department number, their start date, their end date, and a new column 'is_current_employee' that is a 1 if the employee is still with the company and 0 if not.
SELECT emp_no, dept_no, from_date, to_date, IF( to_date > CURDATE(), True, False) AS is_current_employee
FROM dept_emp;

# Q2 - Write a query that returns all employee names (previous and current), and a new column 'alpha_group' that returns 'A-H', 'I-Q', or 'R-Z' depending on the first letter of their last name.
SELECT first_name, last_name,
	CASE
		WHEN last_name REGEXP '^[ABCDEFGH]' THEN 'A-H'
		WHEN last_name REGEXP '^[IJKLMNOPQ]' THEN 'I-Q'
		WHEN last_name REGEXP '^[RSTUVWXYZ]' THEN 'R-Z'
		ELSE NULL
		END AS alpha_group
FROM employees;

# Q3 - How many employees (current or previous) were born in each decade?
SELECT 
	CASE
		WHEN birth_date LIKE ('194%') THEN '40\'s'
		WHEN birth_date LIKE ('195%') THEN '50\'s'
		WHEN birth_date LIKE ('196%') THEN '60\'s'
		WHEN birth_date LIKE ('197%') THEN '70\'s'
		WHEN birth_date LIKE ('198%') THEN '80\'s'
		WHEN birth_date LIKE ('199%') THEN '90\'s'
		ELSE NULL
		END AS decade,
	COUNT(*)
FROM employees
GROUP BY decade;

#BONUS

# Q1 - What is the current average salary for each of the following department groups: R&D, Sales & Marketing, Prod & QM, Finance & HR, Customer Service?
SELECT 
	CASE 
		WHEN dept_name = 'Research' OR
			dept_name = 'Development' THEN 'R&D'
		WHEN dept_name = 'Sales' OR
			dept_name = 'Marketing' THEN 'Sales & Marketing'
		WHEN dept_name = 'Production' OR
			dept_name = 'Quality Management' THEN 'Prod & QM'
		WHEN dept_name = 'Finance' OR
			dept_name = 'Human Resources' THEN 'Finance & HR'
		WHEN dept_name = 'Customer Service' THEN dept_name
		ELSE NULL
		END AS dept_group,
	CASE 
		WHEN dept_group = 'R&D'
			THEN (SELECT AVG(salary) FROM salaries WHERE to_date > CURDATE() 
				AND emp_no IN (
					SELECT emp_no FROM dept_emp WHERE dept_no IN (
						SELECT dept_no FROM departments WHERE dept_name = 'Research' OR dept_name = 'Development')))
		END AS R&D_avg_salary
FROM departments
GROUP BY dept_group;


SELECT dept_name FROM departments;
DESCRIBE salaries;
			