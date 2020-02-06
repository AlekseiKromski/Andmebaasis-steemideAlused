USE smpl_AlekseiKromski


--21.1
GO
	CREATE VIEW zadanije_21_1 AS
	SELECT * FROM employee WHERE dept_no = 'd1'
GO

SELECT * FROM zadanije_21_1

--21.2
GO
	CREATE VIEW zadanije_21_2 (project_no, project_name) AS
	SELECT project_no, project_name FROM project
GO

SELECT * FROM zadanije_21_2

--21.3
GO
	CREATE VIEW zadanije_21_3 AS
	SELECT emp_fname, emp_lname FROM employee INNER JOIN works_on ON employee.emp_no = works_on.emp_no WHERE YEAR(works_on.enter_date) >= '2007' AND  MONTH(works_on.enter_date) >= '06'
GO

SELECT * FROM zadanije_21_3

--21.4
GO
	CREATE VIEW zadanije_21_4 (first,last) AS
	SELECT emp_fname, emp_lname FROM employee INNER JOIN works_on ON employee.emp_no = works_on.emp_no WHERE YEAR(works_on.enter_date) >= '2007' AND  MONTH(works_on.enter_date) >= '06'

GO

SELECT * FROM zadanije_21_4

--21.5
GO
	CREATE VIEW zadanije_21_5 AS
	SELECT * FROM employee WHERE SUBSTRING(emp_lname,0,2) = 'M'
GO
SELECT * FROM zadanije_21_5