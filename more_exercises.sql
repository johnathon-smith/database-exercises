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


#Use the world database for the questions below.
# Q1 - What languages are spoken in Santa Monica?
USE world;
DESCRIBE city;
DESCRIBE country;
DESCRIBE countrylanguage;

SELECT Language, Percentage FROM countrylanguage
JOIN city ON city.CountryCode = countrylanguage.CountryCode
WHERE Name = 'Santa Monica'
ORDER BY Percentage ASC;
/*
Japanese	0.2
Portuguese	0.2
Vietnamese	0.2
Korean	0.3
Polish	0.3
Tagalog	0.4
Chinese	0.6
Italian	0.6
French	0.7
German	0.7
Spanish	7.5
English	86.2
*/

# Q2 - How many different countries are in each region?
SELECT Region, COUNT(*) AS num_countries
FROM country
GROUP BY Region
ORDER BY num_countries ASC;
/*
Micronesia/Caribbean	1
British Islands	2
Baltic Countries	3
Melanesia	5
Antarctica	5
Australia and New Zealand	5
North America	5
Southern Africa	5
Micronesia	7
Northern Africa	7
Nordic Countries	7
Eastern Asia	8
Central America	8
Central Africa	9
Western Europe	9
Eastern Europe	10
Polynesia	10
Southeast Asia	11
South America	14
Southern and Central Asia	14
Southern Europe	15
Western Africa	17
Middle East	18
Eastern Africa	20
Caribbean	24
*/

# Q3 - What is the population for each region?






