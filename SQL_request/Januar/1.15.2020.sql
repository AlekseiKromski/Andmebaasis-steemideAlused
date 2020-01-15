USE smpl_AlekseiKromski


SELECT * FROM department
SELECT * FROM employee
SELECT * FROM project
SELECT * FROM works_on

--1
SELECT project_no, COUNT(*) FROM works_on GROUP BY project_no

--2
SELECT employee.emp_no, emp_lname, emp_fname FROM employee INNER JOIN works_on ON employee.emp_no = works_on.emp_no 


--IF
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

SELECT * FROM project
UPDATE project SET budget = 1
UPDATE project SET budget = budget - 150 WHERE project_no IN ('p1', 'p2','p4')
UPDATE project SET budget = budget / 100 WHERE project_no IN ('p3', 'p2','p5')

--WHILE 
GO
DECLARE @sum1 money
DECLARE @sum2 money
SET @sum1 = 500000
SET @sum2 = 240000

WHILE (SELECT SUM(budget) FROM project) < @sum1
	BEGIN
		UPDATE project SET  budget = budget*1.1
		PRINT 'Change budget' 
		IF (SELECT MAX(budget) FROM project) > @sum2
			BEGIN
				SELECT MAX(budget) FROM project
				BREAK
			END
		ELSE			
			CONTINUE
	END
GO
