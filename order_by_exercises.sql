USE employees;
DESCRIBE employees;

# Q2 - Find all current or previous employees with the first names "Irena", "Vidya", or "Maya" using IN and ORDER BY first_name
SELECT * FROM employees WHERE first_name IN('Irena', 'Vidya', 'Maya')
ORDER BY first_name;
#There are 709 rows. The first and last name of the first row in my results is Irena Reutenauer. The first and last name of the last row in my results is Vidya Simmen

# Q3 - Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya', as in Q2, but use OR instead of IN and ORDER BY first_name and then last_name
SELECT * FROM employees WHERE first_name = 'Irena'
	OR first_name = 'Vidya'
	OR first_name = 'Maya'
ORDER BY first_name, last_name;
#This query returned 709 rows. This is the same as the previous query.
#The first and last name of the first row in my results is Irena Acton. The first and last name of the last row in my results is Vidya Zweizig.

# Q4 - Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya' and then ORDER BY last_name and then first_name
SELECT * FROM employees WHERE
	first_name = 'Irena'
	OR first_name = 'Vidya'
	OR first_name = 'Maya'
ORDER BY last_name, first_name;
#The first and last name of the first row in my results is Irena Acton. The first and last name of the last row in my results is Maya Zyda.

# Q5 - Find all current or previous employees employees whose last name starts and ends with 'E' and ORDER BY emp_no.
SELECT * FROM employees WHERE last_name LIKE ('E%')
	AND last_name LIKE ('%E')
ORDER BY emp_no;
#There are 899 employees whose last names start and end with 'E'. The first row of my results is emp_no 10021, Ramzi Erde. The last row of my results is emp_no 499648, Tadahiro Erde.

# Q6 - Find all current or previous employees employees whose last name starts and ends with 'E' and ORDER BY hire_date.
SELECT * FROM employees WHERE last_name LIKE ('E%')
	AND last_name LIKE ('%E')
ORDER BY hire_date DESC;
#There are 899 rows. The name of the newest employee is Teiji Eldridge. The name of the oldest employee is Sergi Erde.

# Q7 - Find all current or previous employees hired in the 90s and born on Christmas and sort so the the oldest employee who was hired last is the first result.
SELECT * FROM employees WHERE birth_date LIKE ('%-12-25')
	AND hire_date LIKE ('199%')
ORDER BY birth_date, hire_date DESC;
#There are 362 rows. The name of the oldest employee hired last is Khun Bernini. The name of the youngest employee hired first is Douadi Pettis.

	
	
	
	