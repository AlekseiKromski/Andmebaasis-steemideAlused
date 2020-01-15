USE smpl_AlekseiKromski


SELECT * FROM department
SELECT * FROM employee
SELECT * FROM project
SELECT * FROM works_on

--1
SELECT project_no, COUNT(*) FROM works_on GROUP BY project_no

--2
SELECT employee.emp_no, emp_lname, emp_fname FROM employee INNER JOIN works_on ON employee.emp_no = works_on.emp_no 



GO
DECLARE @project varchar(3)
SET @project = 'p1'
DECLARE @people int
IF(SELECT COUNT(project_no) FROM works_on WHERE project_no = @project GROUP BY project_no) > 3
	BEGIN 
		SELECT @people = COUNT(project_no) FROM works_on WHERE project_no = @project
		PRINT 'The number of employees in the project ' + @project + ' is 4 or more'
		PRINT 'People work = ' + CAST(@people AS CHAR(10))
	END
ELSE
	BEGIN
		PRINT 'The following employees work for the project' + @project
		SELECT emp_lname, emp_fname 
		FROM employee INNER JOIN works_on ON employee.emp_no = works_on.emp_no  WHERE project_no = @project
	END
GO