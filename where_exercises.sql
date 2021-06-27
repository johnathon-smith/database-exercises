USE employees;
DESCRIBE employees;

#Find all current or previous employees with the first names "Irena", "Vidya", or "Maya" using IN
SELECT * FROM employees WHERE first_name IN('Irena', 'Vidya', 'Maya');
#There are 709 rows

#Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya', as in Q2, but use OR instead of IN
SELECT * FROM employees WHERE first_name = 'Irena'
	OR first_name = 'Vidya'
	OR first_name = 'Maya';
#This query returned 709 rows. This is the same as the previous query.

#Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya', using OR, and who is male.
SELECT * FROM employees WHERE gender = 'M'
	AND ( first_name = 'Irena'
	OR first_name = 'Vidya'
	OR first_name = 'Maya' );
#This query returned 441 rows. 

#Find all current or previous employees whose last name starts with 'E'
SELECT * FROM employees WHERE last_name LIKE ('E%');
#There are 7,330 rows

#Find all current or previous employees whose last name starts or ends with 'E'
SELECT * FROM employees WHERE last_name LIKE ('E%')
	OR last_name LIKE ('%E');
#There are 30,723 employees whose last names start or end with 'E'. There are 23,393 employees whose last names end, but do not start, with 'E'.

#Find all current or previous employees employees whose last name starts and ends with 'E'. 
SELECT * FROM employees WHERE last_name LIKE ('E%')
	AND last_name LIKE ('%E');
#There are 899 employees whose last names start and end with 'E'. There are 24,292 employees whose last names end with 'E', regardless of whether or not they start with 'E'.

#Find all current or previous employees hired in the 90s.
SELECT * FROM employees WHERE hire_date LIKE ('199%');
#There are 135,214 rows.

#Find all current or previous employees born on Christmas.
SELECT * FROM employees WHERE birth_date LIKE ('%-12-25');
#There are 842 rows

#Find all current or previous employees hired in the 90s and born on Christmas.
SELECT * FROM employees WHERE birth_date LIKE ('%-12-25')
	AND hire_date LIKE ('199%');
#There are 362 rows.

#Find all current or previous employees with a 'q' in their last name. 
SELECT * FROM employees WHERE last_name LIKE ('%Q%');
#There are 1873 rows.

#Find all current or previous employees with a 'q' in their last name but not 'qu'.
SELECT * FROM employees WHERE last_name LIKE ('%Q%')
	AND last_name NOT LIKE ('%QU%');
#There are 547 rows.
	
	
	
	