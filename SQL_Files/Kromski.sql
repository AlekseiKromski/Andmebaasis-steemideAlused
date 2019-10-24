--Kromski

USE	smpl_AlekseiKromski;

--SELECT * FROM employee WHERE emp_no = 25348 AND emp_lname = 'Smith' OR emp_fname = 'Matthew' AND dept_no = 'd1';

--SELECT * FROM employee WHERE (emp_no = 25348 AND emp_lname = 'Smith' OR emp_fname = 'Matthew') AND dept_no = 'd1';

--SELECT * FROM employee WHERE emp_no IN (25348,288559, 25348)

--======================================

--SELECT * FROM project WHERE budget BETWEEN 1 AND 1200000

--SELECT * FROM works_on WHERE job IS NULL AND project_no = 'p2'
 
--SELECT * FROM works_on WHERE job IS NOT NULL AND project_no = 'p2'

--SELECT *, ISNULL(job, 'no data') task FROM works_on 

--SELECT * FROM employee WHERE emp_lname LIKE '[^J-O]%' AND emp_fname LIKE '[^EZ]%'

--SELECT GETDATE()

--SELECT *, YEAR(enter_date) AS asstat FROM works_on WHERE YEAR(enter_date) = 2006


--Kromski
--”пражнение 5.1

--SELECT * FROM works_on

--”пражнение 5.2

--SELECT * FROM works_on WHERE job = 'Clerk'

--”пражнение 5.3

--SELECT * FROM works_on WHERE project_no = 'p2' AND emp_no < 10000

--”пражнение 5.4

SELECT emp_no, YEAR(enter_date) AS ss FROM works_on WHERE YEAR(enter_date) = 2007

--SELECT emp_no, YEAR(enter_date) AS asstat FROM works_on WHERE YEAR(enter_date) BETWEEN 2007 AND 2019

--”пражнение 5.5

--SELECT emp_no FROM works_on WHERE project_no = 'p1' AND (job = 'Analyst' OR job = 'Manager')

--”пражнение 5.6

--SELECT * FROM works_on WHERE job IS NULL AND project_no = 'p2'

--”пражнение 5.7

--SELECT emp_no, emp_lname FROM employee WHERE emp_fname LIKE '%tt%'

--”пражнение 5.8

--SELECT emp_no, emp_fname FROM employee WHERE emp_lname LIKE '_o%' OR emp_lname LIKE '_a%' AND emp_lname LIKE '%es'

--”пражнение 5.9

--SELECT project_name FROM project WHERE budget BETWEEN 100000 AND 300000

--SELECT project_name FROM project WHERE budget > 100000 AND budget < 300000

--”пражнение 5.10

--SELECT emp_fname, emp_lname FROM employee 

--SELECT emp_fname, emp_lname FROM employee WHERE emp_fname NOT LIKE '%[y]%' AND emp_fname NOT LIKE '%[x]%' AND emp_lname NOT LIKE '%[y]%' AND emp_lname NOT LIKE '%[x]%'


