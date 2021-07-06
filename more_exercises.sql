# Q1 - How much do the current managers of each department get paid, relative to the average salary for the department? Is there any department where the department manager gets paid less than the average salary?
USE employees;

#Create a temp table to store the department names and their current avg salaries
CREATE TEMPORARY TABLE germain_1466.current_salary_avg AS
SELECT dept_name, AVG(salary) AS salary_avg FROM salaries
JOIN dept_emp ON dept_emp.emp_no = salaries.emp_no
JOIN departments ON dept_emp.dept_no = departments.dept_no
WHERE salaries.to_date > CURDATE()
	AND dept_emp.to_date > CURDATE()
GROUP BY dept_name;

#Create another temp table to hold the department names and the current department manager's salaries
CREATE TEMPORARY TABLE germain_1466.current_manager_salaries AS
SELECT dept_name, salary AS manager_salary FROM salaries
JOIN dept_manager ON dept_manager.emp_no = salaries.emp_no
JOIN departments ON dept_manager.dept_no = departments.dept_no
WHERE salaries.to_date > CURDATE()
	AND dept_manager.to_date > CURDATE();
	
#Now switch to germain_1466 DB and join the two tables
USE germain_1466;

SELECT current_manager_salaries.dept_name, salary_avg, manager_salary, CONCAT((manager_salary / salary_avg) * 100, '%' ) AS '% of Department Avg Salary'
FROM current_manager_salaries
JOIN current_salary_avg ON current_salary_avg.dept_name = current_manager_salaries.dept_name;
#The managers in the production and customer service departments get paid less than their department's average salary.

