USE employees;
DESCRIBE titles;

# Q2 - In your script, use DISTINCT to find the unique titles in the titles table. How many unique titles have there ever been?
SELECT DISTINCT title FROM titles;
#There are 7 unique titles

# Q3 - Write a query to to find a list of all unique last names of all employees that start and end with 'E' using GROUP BY.
SELECT last_name FROM employees
WHERE last_name LIKE ('E%E')
GROUP BY last_name;
/*
Erde
Eldridge
Etalle
Erie
Erbe
*/

# Q4 - Write a query to to find all unique combinations of first and last names of all employees whose last names start and end with 'E'.
SELECT last_name, first_name FROM employees
WHERE last_name LIKE ('E%E')
GROUP BY last_name, first_name;
#There are 846 rows

# Q5 - Write a query to find the unique last names with a 'q' but not 'qu'. Include those names in a comment in your sql code.
SELECT last_name FROM employees
WHERE last_name LIKE ('%q%')
	AND last_name NOT LIKE ('%qu%')
GROUP BY last_name;
/*
Chleq
Lindqvist
Qiwen
*/

# Q6 - Add a COUNT() to your results (the query above) to find the number of employees with the same last name.
SELECT last_name, COUNT(last_name) FROM employees
WHERE last_name LIKE ('%q%')
	AND last_name NOT LIKE ('%qu%')
GROUP BY last_name;
/*
Chleq - 189
Lindqvist - 190
Qiwen - 168
*/

# Q7 - Find all all employees with first names 'Irena', 'Vidya', or 'Maya'. Use COUNT(*) and GROUP BY to find the number of employees for each gender with those names.
SELECT first_name, gender, COUNT(*) FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
GROUP BY first_name, gender;
/*
Vidya	M	151
Irena	M	144
Irena	F	97
Maya	F	90
Vidya	F	81
Maya	M	146
*/

# Q8 - Using your query that generates a username for all of the employees, generate a count employees for each unique username. Are there any duplicate usernames? BONUS: How many duplicate usernames are there?
SELECT LOWER( CONCAT( SUBSTR(first_name, 1, 1), SUBSTR(last_name, 1, 4), "_", SUBSTR( birth_date, 6, 2), SUBSTR(birth_date, 3, 2) ) ) AS username,
	COUNT(*) AS num_users
FROM employees
GROUP BY username
HAVING COUNT(username) > 1;
/*
Yes, there are duplicate usernames. There are 13,251 duplicate usernames.
