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
DESCRIBE dept_manager;
DESCRIBE dept_emp;
DESCRIBE departments;
DESCRIBE current_dept_emp;
DESCRIBE employees;

SELECT departments.dept_name AS Department_Name, CONCAT(employees.first_name, " ", employees.last_name) AS Department_Manager
FROM dept_manager 
JOIN employees on employees.emp_no = dept_manager.emp_no
JOIN departments on departments.dept_no = dept_manager.dept_no
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



# Q10 - Bonus Find the names of all current employees, their department name, and their current manager's name.
SELECT CONCAT(first_name, " ", last_name) AS 'Employee Name', dept_name AS 'Department Name', CONCAT(first_name, " ", last_name) AS 'Manager Name'
FROM employees
JOIN dept_manager ON dept_manager.emp_no = employees.emp_no
JOIN dept_emp ON dept_emp.emp_no = employees.emp_no
JOIN departments ON departments.dept_no = dept_emp.dept_no
WHERE dept_emp.to_date > CURDATE()
	AND dept_manager.to_date > CURDATE();
	
describe dept_manager;
describe dept_emp;
select distinct title FROM titles;




