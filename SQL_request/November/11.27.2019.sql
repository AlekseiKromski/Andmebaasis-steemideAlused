USE smpl_AlekseiKromski

--system requests
SELECT * FROM employee
SELECT * FROM emp_d1_d2
SELECT * FROM works_on
SELECT * FROM emp_2008
SELECT * FROM emp_2008_2
SELECT * FROM works_on
SELECT * FROM project
SELECT * FROM department

--9.1
INSERT INTO employee VALUES (11111,'Julia','Long',NULL, NULL)

--9.2
CREATE TABLE emp_d1_d2 (emp_no INT NOT NULL, emp_fname varchar(50),emp_lname varchar(50),dept_no varchar(50),salary varchar(50))

INSERT INTO emp_d1_d2 (emp_no,emp_fname,emp_lname,dept_no,salary)
SELECT * FROM employee WHERE dept_no = 'd1' OR dept_no = 'd2'

--9.3
--1
CREATE TABLE emp_2008 (emp_no INT NOT NULL, emp_fname varchar(50),emp_lname varchar(50),dept_no varchar(50),salary varchar(50))

INSERT INTO emp_2008 (emp_no,emp_fname,emp_lname,dept_no,salary)
SELECT * FROM employee WHERE emp_no in (SELECT emp_no FROM works_on WHERE YEAR(enter_date) = 2008)
--2
SELECT emp_no, emp_fname, emp_lname, dept_no, salary INTO emp_2008_2 FROM employee WHERE emp_no in (SELECT emp_no FROM works_on WHERE YEAR(enter_date) = 2008)

--9.4
UPDATE works_on SET job = 'Clerk' WHERE project_no = 'p1'

--9.5
UPDATE project SET budget = NULL WHERE project_no = 'p1' AND project_no = 'p3'

--9.6
UPDATE works_on SET job = 'Manager' WHERE emp_no = '28559'

--9.7
UPDATE project SET budget = budget + (budget/10)  WHERE project_no IN (SELECT project_no FROM works_on WHERE job = 'Manager' AND emp_no = '10102')

--9.8
UPDATE department SET dept_name = 'Sales'  WHERE dept_no IN (SELECT dept_no FROM employee WHERE emp_fname = 'James')

--9.9
UPDATE works_on SET enter_date = '2009-12-12' FROM works_on, department, employee WHERE works_on.emp_no = employee.emp_no AND employee.dept_no = department.dept_no AND project_no = 'p1' AND dept_name = 'Sales'
