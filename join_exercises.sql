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
DESCRIBE titles;

SELECT titles.title AS Title, COUNT(titles.emp_no) AS Count
FROM titles
JOIN dept_emp ON dept_emp.emp_no = titles.emp_no
JOIN departments ON departments.dept_no = dept_emp.dept_no
WHERE dept_name = 'Customer Service'
	AND titles.to_date > CURDATE()
	AND dept_emp.to_date LIKE ('9999%')
GROUP BY title;

# Q5 - Find the current salary of all current managers.




