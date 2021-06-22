USE employees;
SHOW tables;

DESCRIBE employees;
#The employees table uses int, date, varchar(14), varchar(16), enum('M','F'), and another field of type date

DESCRIBE current_dept_emp;
DESCRIBE departments;
DESCRIBE dept_emp;
DESCRIBE dept_emp_latest_date;
DESCRIBE dept_manager;
DESCRIBE salaries;
DESCRIBE titles;

#The following tables contain a numeric type column:
#current_dept_emp, dept_emp, dept_emp_latest_date, dept_manager, employees, salaries, titles

#The following tables contain a string type column:
#current_dept_emp, dept_emp, dept_manager, employees, titles

#The following tables contain a date type column:
#current_dept_emp, dept_emp, dept_emp_latest_date, dept_manager, employees, salaries, titles

#As far as I can tell, there is not a relationship between the departments and employees tables. Neither refers to any information in the other. But, of course, they are both part of the same database.

SHOW CREATE TABLE dept_manager;
#Below is the SQL used to create the table 'dept_manager'
CREATE TABLE `dept_manager` (
  `emp_no` int NOT NULL,
  `dept_no` char(4) NOT NULL,
  `from_date` date NOT NULL,
  `to_date` date NOT NULL,
  PRIMARY KEY (`emp_no`,`dept_no`),
  KEY `dept_no` (`dept_no`),
  CONSTRAINT `dept_manager_ibfk_1` FOREIGN KEY (`emp_no`) REFERENCES `employees` (`emp_no`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `dept_manager_ibfk_2` FOREIGN KEY (`dept_no`) REFERENCES `departments` (`dept_no`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=latin1

