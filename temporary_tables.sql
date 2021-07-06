# Q1 - create a temporary table called employees_with_departments that contains first_name, last_name, and dept_name for employees currently with that department.
USE employees;

CREATE TEMPORARY TABLE germain_1466.employees_with_departments AS
SELECT first_name, last_name, dept_name FROM employees
JOIN dept_emp ON dept_emp.emp_no = employees.emp_no
JOIN departments ON departments.dept_no = dept_emp.dept_no
WHERE dept_emp.to_date > CURDATE();

# Q1.a - Add a column named full_name to this table. It should be a VARCHAR whose length is the sum of the lengths of the first name and last name columns
USE germain_1466;

DESCRIBE employees_with_departments;
ALTER TABLE employees_with_departments ADD full_name VARCHAR(30);

# Q1.b - Update the table so that full name column contains the correct data
UPDATE employees_with_departments SET full_name = CONCAT(first_name, " ", last_name);

# Q1.c - Remove the first_name and last_name columns from the table.
ALTER TABLE employees_with_departments DROP first_name;
ALTER TABLE employees_with_departments DROP last_name;
SELECT * FROM employees_with_departments;

# Q1.d - What is another way you could have ended up with this same table?
USE employees;

CREATE TEMPORARY TABLE germain_1466.employees_with_departments AS
SELECT dept_name, CONCAT(first_name, " ", last_name) AS full_name FROM employees
JOIN dept_emp ON dept_emp.emp_no = employees.emp_no
JOIN departments ON departments.dept_no = dept_emp.dept_no
WHERE dept_emp.to_date > CURDATE();

SELECT * FROM germain_1466.employees_with_departments;

# Q2 - Create a temporary table based on the payment table from the sakila database.
# Write the SQL necessary to transform the amount column such that it is stored as an integer representing the number of cents of the payment. 
USE sakila;
DESCRIBE payment;

CREATE TEMPORARY TABLE germain_1466.payment AS
SELECT * FROM payment;

USE germain_1466;

ALTER TABLE payment MODIFY amount DECIMAL(7,2); #allows up to 7 full numbers and 2 decimal places
UPDATE payment SET amount = amount * 100; #converts the dollars to cents
ALTER TABLE payment MODIFY amount INTEGER; #changes the data type of 'amount' to int

# Q3 - Find out how the current average pay in each department compares to the overall, historical average pay.
# In order to make the comparison easier, you should use the Z-score for salaries.
# In terms of salary, what is the best department right now to work for? The worst?

USE employees;

#This was my first answer, but didn't use temporary tables. I don't really see the value in using a temporary table here. It seems simpler just to put it all in one query.
SELECT dept_name,
	AVG(salary) AS current_salary_average,
	(SELECT AVG(salary) FROM salaries) AS historical_salary_average,
	( (AVG(salary) - (SELECT AVG(salary) FROM salaries)) / (SELECT STDDEV(salary) FROM salaries) ) AS z_score #calculates z-score by dividing (current_salary_avg - historical_salary_avg) by the standard deviation of the historical salaries
FROM salaries
JOIN dept_emp ON dept_emp.emp_no = salaries.emp_no
JOIN departments ON dept_emp.dept_no = departments.dept_no
WHERE dept_emp.to_date > CURDATE()
	AND salaries.to_date > CURDATE()
GROUP BY dept_name;




#Now I will try doing the same thing, but with temporary tables
CREATE TEMPORARY TABLE germain_1466.salary_scores AS
SELECT dept_name,
	AVG(salary) AS current_salary_average,
	(SELECT AVG(salary) FROM salaries) AS historical_salary_average
FROM salaries
JOIN dept_emp ON dept_emp.emp_no = salaries.emp_no
JOIN departments ON dept_emp.dept_no = departments.dept_no
WHERE dept_emp.to_date > CURDATE()
	AND salaries.to_date > CURDATE()
GROUP BY dept_name;

USE germain_1466;
#change the tables to add the needed columns
ALTER TABLE salary_scores ADD std_dev float;
ALTER TABLE salary_scores ADD z_score float;

#set the needed values to calculate std dev
UPDATE salary_scores SET std_dev = (SELECT STDDEV(salary) FROM employees.salaries);
UPDATE salary_scores SET z_score = (current_salary_average - historical_salary_average) / std_dev;

#We can now see the z-scores
SELECT * FROM salary_scores;

/*
Sales is the best department to work in right now because it has the highest z-score at 1.48137
Human resources is the worst department to work in right now because it has the lowest z-score at 0.00657534
*/






