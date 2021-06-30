USE employees;

# Q1 - Find all the current employees with the same hire date as employee 101010 using a sub-query.
SELECT * FROM employees
WHERE hire_date IN (
	SELECT hire_date from employees WHERE emp_no = 101010
		)
	AND emp_no IN (
	SELECT emp_no FROM dept_emp WHERE to_date > CURDATE()
	);
	
# Q2 - Find all the titles ever held by all current employees with the first name Aamod.
SELECT emp_no, title FROM titles
WHERE emp_no IN (
		SELECT emp_no FROM employees WHERE first_name = 'Aamod'
	)
	AND emp_no IN (
		SELECT emp_no FROM dept_emp WHERE to_date > CURDATE()
	);
	
# Q3 - How many people in the employees table are no longer working for the company? Give the answer in a comment in your code
SELECT (COUNT(emp_no) - (SELECT COUNT(emp_no) FROM dept_emp WHERE to_date > CURDATE() )) AS 'Number of Past Employees' 
FROM employees;
#There are 59,900 employees that no longer work for the company.

# Q4 - Find all the current department managers that are female. List their names in a comment in your code.
SELECT first_name, last_name FROM employees
WHERE emp_no IN (
		SELECT emp_no FROM dept_manager WHERE to_date > CURDATE()
	)
	AND gender = 'F';
/*
Isamu	Legleitner
Karsten	Sigstam
Leon	DasSarma
Hilary	Kambil
*/

# Q5 - Find all the employees who currently have a higher salary than the companies overall, historical average salary.
	
	



