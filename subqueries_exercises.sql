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
SELECT first_name, last_name FROM employees 
WHERE emp_no IN (
		SELECT emp_no FROM salaries WHERE salary > (SELECT AVG(salary) FROM salaries)
		AND to_date > CURDATE()
	);
	
# Q6 - How many current salaries are within 1 standard deviation of the current highest salary? What percentage of all salaries is this?
#I read the last question to mean what percentage of all current salaries is this?
SELECT COUNT(*) AS 'Number of Current Salaries +/- 1 Std. Dev.', CONCAT('%', (COUNT(*) / (SELECT COUNT(*) FROM salaries WHERE to_date > CURDATE() ) ) * 100 ) AS 'Percentage of Current Salaries'
FROM salaries
WHERE to_date > CURDATE()
	AND salary BETWEEN ( (SELECT MAX(salary) FROM salaries WHERE to_date > CURDATE() ) - (SELECT STDDEV(salary) FROM salaries WHERE to_date > CURDATE() ) ) #This is max salary - 1 std dev for the lower bound
		AND (SELECT MAX(salary) FROM salaries WHERE to_date > CURDATE() ); #The max salary itself acts as the upper bound
		
#BONUS
# Q1 - Find all the department names that currently have female managers.
SELECT dept_name FROM departments
JOIN dept_manager ON dept_manager.dept_no = departments.dept_no
WHERE to_date > CURDATE()
	AND emp_no IN (
		SELECT emp_no FROM employees WHERE gender = 'F'
	);

#This is the same thing, but without using a join
SELECT dept_name FROM departments
WHERE dept_no IN(
		SELECT dept_no FROM dept_manager WHERE to_date > CURDATE()
		AND emp_no IN (
				SELECT emp_no FROM employees WHERE gender = 'F'
			)
	);
	
# Q2 - Find the first and last name of the employee with the highest salary. I'm assuming this means the current highest salary.
SELECT first_name, last_name FROM employees
WHERE emp_no IN (
		SELECT emp_no FROM salaries WHERE to_date > CURDATE()
		AND salary = (SELECT MAX(salary) FROM salaries WHERE to_date > CURDATE())
	);
	
# Q3 - Find the department name that the employee with the highest salary works in.



describe dept_manager;


