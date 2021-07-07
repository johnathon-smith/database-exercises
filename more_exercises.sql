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
SELECT Region, SUM(Population)
FROM country
GROUP BY Region
ORDER BY SUM(Population) DESC;
/*
Region	SUM(Population)
Eastern Asia	1507328000
Southern and Central Asia	1490776000
Southeast Asia	518541000
South America	345780000
North America	309632000
Eastern Europe	307026000
Eastern Africa	246999000
Western Africa	221672000
Middle East	188380700
Western Europe	183247600
Northern Africa	173266000
Southern Europe	144674200
Central America	135221000
Central Africa	95652000
British Islands	63398500
Southern Africa	46886000
Caribbean	38140000
Nordic Countries	24166400
Australia and New Zealand	22753100
Baltic Countries	7561900
Melanesia	6472000
Polynesia	633050
Micronesia	543000
Micronesia/Caribbean	0
Antarctica	0
*/

# Q4 - What is the population for each continent?
SELECT Continent, SUM(Population) AS population 
FROM country
GROUP BY Continent
ORDER BY population DESC;
/*
Continent	population
Asia	3705025700
Africa	784475000
Europe	730074600
North America	482993000
South America	345780000
Oceania	30401150
Antarctica	0
*/

# Q5 - What is the average life expectancy globally?
SELECT AVG(LifeExpectancy)
FROM country;
/*
AVG(LifeExpectancy)
66.48604
*/

# Q6 - What is the average life expectancy for each region, each continent? Sort the results from shortest to longest
SELECT Continent, AVG(LifeExpectancy)
FROM country
GROUP BY Continent
ORDER BY AVG(LifeExpectancy) ASC;
/*
Continent	AVG(LifeExpectancy)
Antarctica	NULL
Africa	52.57193
Asia	67.44118
Oceania	69.71500
South America	70.94615
North America	72.99189
Europe	75.14773
*/

SELECT Region, AVG(LifeExpectancy)
FROM country
GROUP BY Region
ORDER BY AVG(LifeExpectancy) ASC;
/*
Region	AVG(LifeExpectancy)
Micronesia/Caribbean	NULL
Antarctica	NULL
Southern Africa	44.82000
Central Africa	50.31111
Eastern Africa	50.81053
Western Africa	52.74118
Southern and Central Asia	61.35000
Southeast Asia	64.40000
Northern Africa	65.38571
Melanesia	67.14000
Micronesia	68.08571
Baltic Countries	69.00000
Eastern Europe	69.93000
Middle East	70.56667
Polynesia	70.73333
South America	70.94615
Central America	71.02500
Caribbean	73.05833
Eastern Asia	75.25000
North America	75.82000
Southern Europe	76.52857
British Islands	77.25000
Western Europe	78.25556
Nordic Countries	78.33333
Australia and New Zealand	78.80000
*/



