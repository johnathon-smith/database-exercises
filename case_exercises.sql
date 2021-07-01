USE employees;
DESCRIBE employees;
# Q1 - Write a query that returns all employees (emp_no), their department number, their start date, their end date, and a new column 'is_current_employee' that is a 1 if the employee is still with the company and 0 if not.

#This solution is too simple and brings up multiples of the same employee if they ever worked in more than one department, but also shows us how long each employee worked in each department. This was my original solution.
SELECT emp_no, dept_no, from_date, to_date, IF( to_date > CURDATE(), True, False) AS is_current_employee
FROM dept_emp;

#This solution should only have one instance of each employee and have their original hire date as well as their last date employed, regardless of department. 
SELECT 
	de.emp_no,
	dept_no,
	hire_date,
	to_date,
	IF(to_date > CURDATE(), 1, 0) AS current_employee
FROM dept_emp AS de
JOIN (SELECT 
			emp_no,
			MAX(to_date) AS max_date
		FROM dept_emp
		GROUP BY emp_no) as last_dept 
		ON de.emp_no = last_dept.emp_no
			AND de.to_date = last_dept.max_date
JOIN employees AS e ON e.emp_no = de.emp_no;

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
	AVG(salary) AS avg_salary
FROM departments
JOIN dept_emp ON dept_emp.dept_no = departments.dept_no
JOIN salaries ON salaries.emp_no = dept_emp.emp_no
WHERE salaries.to_date > CURDATE()
GROUP BY dept_group;
/*
R&D	67718.5563
Sales & Marketing	86379.3407
Prod & QM	67315.3668
Finance & HR	71111.6674
Customer Service	66971.3536
*/
			