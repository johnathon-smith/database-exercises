#Join Example Database
# Q1 - Use the join_example_db. Select all the records from both the users and roles tables.
USE join_example_db;
SELECT * FROM users, roles;

# Q2 - Use join, left join, and right join to combine results from the users and roles tables as we did in the lesson.
SELECT * FROM users
JOIN roles on roles.id = users.role_id;

SELECT * FROM users
LEFT JOIN roles on roles.id = users.role_id;

SELECT * FROM users
RIGHT JOIN roles on roles.id = users.role_id;

# Q3 - Use count and the appropriate join type to get a list of roles along with the number of users that has the role. Hint: You will also need to use group by in the query.
SELECT roles.name AS role, COUNT(users.id) AS users_with_role FROM users
RIGHT JOIN roles on roles.id = users.role_id
GROUP BY roles.name;

#Employees database
# Q1 - Use the employees database.
USE employees;


# Q2 - Write a query that shows each department along with the name of the current manager for that department.
SELECT departments.dept_name AS Department_Name, CONCAT(employees.first_name, " ", employees.last_name) AS Department_Manager
FROM dept_manager 
JOIN employees ON employees.emp_no = dept_manager.emp_no
JOIN departments ON departments.dept_no = dept_manager.dept_no
WHERE to_date > CURDATE();



# Q3 - Find the name of all departments currently managed by women.
SELECT departments.dept_name AS Department_Name, CONCAT(employees.first_name, " ", employees.last_name) AS Department_Manager
FROM dept_manager 
JOIN employees on employees.emp_no = dept_manager.emp_no
JOIN departments on departments.dept_no = dept_manager.dept_no
WHERE to_date > CURDATE()
	AND gender = 'F';



# Q4 - Find the current titles of employees currently working in the Customer Service department.
SELECT titles.title AS Title, COUNT(titles.emp_no) AS Count
FROM titles
JOIN dept_emp ON dept_emp.emp_no = titles.emp_no
JOIN departments ON departments.dept_no = dept_emp.dept_no
WHERE dept_name = 'Customer Service'
	AND titles.to_date > CURDATE()
	AND dept_emp.to_date > CURDATE()
GROUP BY title;



# Q5 - Find the current salary of all current managers.
SELECT departments.dept_name AS Department_Name, CONCAT(employees.first_name, " ", employees.last_name) AS Department_Manager, salaries.salary AS Salary
FROM dept_manager 
JOIN employees on employees.emp_no = dept_manager.emp_no
JOIN departments on departments.dept_no = dept_manager.dept_no
JOIN salaries on salaries.emp_no = employees.emp_no
WHERE dept_manager.to_date > CURDATE()
	AND salaries.to_date > CURDATE();


# Q6 - Find the number of current employees in each department.
SELECT departments.dept_no as dept_no, departments.dept_name AS Department_Name, COUNT(*) AS num_employees
FROM departments
JOIN dept_emp on dept_emp.dept_no = departments.dept_no
WHERE dept_emp.to_date > CURDATE()
GROUP BY departments.dept_no
ORDER BY departments.dept_no ASC;



# Q7 - Which department has the highest average salary? Hint: Use current not historic information.
SELECT departments.dept_name AS Department, AVG( salaries.salary) AS average_salary
FROM salaries
JOIN dept_emp ON dept_emp.emp_no = salaries.emp_no
JOIN departments ON departments.dept_no = dept_emp.dept_no
WHERE salaries.to_date > CURDATE()
	AND dept_emp.to_date > CURDATE()
GROUP BY departments.dept_name
ORDER BY average_salary DESC
LIMIT 1;



# Q8 - Who is the highest paid employee in the Marketing department?
SELECT first_name, last_name
FROM employees
JOIN salaries ON salaries.emp_no = employees.emp_no
JOIN dept_emp ON dept_emp.emp_no = employees.emp_no
JOIN departments ON departments.dept_no = dept_emp.dept_no
WHERE departments.dept_name = 'Marketing'
	AND salaries.to_date > CURDATE()
	AND dept_emp.to_date > CURDATE()
ORDER BY salaries.salary DESC
LIMIT 1;



# Q9 - Which current department manager has the highest salary?
SELECT first_name, last_name, salary, dept_name
FROM employees
JOIN dept_manager ON dept_manager.emp_no = employees.emp_no
JOIN salaries ON salaries.emp_no = employees.emp_no
JOIN departments ON departments.dept_no = dept_manager.dept_no
WHERE dept_manager.to_date > CURDATE()
	AND salaries.to_date > CURDATE()
ORDER BY salary DESC
LIMIT 1;

describe dept_manager;
describe dept_emp;
select distinct title FROM titles;

# Q10 - Bonus Find the names of all current employees, their department name, and their current manager's name.
SELECT CONCAT(e.first_name, " ", e.last_name) AS 'Employee Name', dept_name AS 'Department Name', CONCAT(e1.first_name, " ", e1.last_name) AS 'Manager Name'
FROM employees AS e
JOIN dept_emp ON dept_emp.emp_no = e.emp_no
JOIN dept_manager ON dept_manager.dept_no = dept_emp.dept_no
JOIN departments ON departments.dept_no = dept_emp.dept_no
JOIN employees AS e1 ON e1.emp_no = dept_manager.emp_no
WHERE dept_emp.to_date > CURDATE()
	AND dept_manager.to_date > CURDATE();
	

# Q11 - Bonus Who is the highest paid employee within each department.
SELECT dept_name, MAX(salary)
FROM employees
JOIN dept_emp ON dept_emp.emp_no = employees.emp_no
JOIN departments ON departments.dept_no = dept_emp.dept_no
JOIN salaries ON salaries.emp_no = employees.emp_no
WHERE dept_emp.to_date > CURDATE()
	AND salaries.to_date > CURDATE()
GROUP BY dept_name;
#This returns the max salary in each department, but does not give employee names

SELECT 
	t1.dept_name AS 'Department Name',
	t1.salary AS 'Salary',
	CONCAT(first_name,' ', last_name) AS 'Employee Name'
FROM 
	(
	-- Part 1 which builds the base table to employee names, salaries and dept names
	SELECT
		salary, dept_name, first_name, last_name
	FROM
		salaries
	JOIN
		dept_emp 
	USING(emp_no)
	JOIN 
		departments 
	USING(dept_no)
	JOIN 
		employees
	USING(emp_no)
	WHERE 
		dept_emp.to_date >= NOW()
	AND 
		salaries.to_date >= NOW()
	) AS t1 # This is table_1 result created
INNER JOIN
	(
	-- Part 2 builds another table to cross reference the previous part with the calculated max salaries
	SELECT dept_name, MAX(salary) as max_salary
	FROM 
		(
		SELECT
			salary, dept_name, first_name, last_name
		FROM
			salaries
		JOIN
			dept_emp 
		USING(emp_no)
		JOIN 
			departments 
		USING(dept_no)
		JOIN 
			employees
		USING(emp_no)
		WHERE 
			dept_emp.to_date >= NOW()
			AND 
			salaries.to_date >= NOW()
		) as t2
	GROUP BY dept_name
	) AS t2 # This is table_2 result created
	-- Joins both tables based on the dept_name and matches the salary & department name with the max_salary
	ON 
	t1.dept_name = t2.dept_name
	AND
	t1.salary = t2.max_salary
ORDER BY 'Department Name' DESC;

