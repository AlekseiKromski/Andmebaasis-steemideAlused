USE	smpl_AlekseiKromski;

SELECT * FROM department;

SELECT dept_no, dept_name FROM department;

SELECT DISTINCT location FROM department;

SELECT dept_name, dept_no FROM department WHERE location = 'Dallas';

SELECT * FROM works_on --WHERE enter_date > '2007-01-01';
 -- WHERE enter_date > '2007/01/01';
 -- WHERE enter_date > '2007.01.01';
 -- WHERE enter_date > '01/01/2007';

 SELECT emp_lname, emp_fname FROM employee WHERE emp_no >= 15000;
 
