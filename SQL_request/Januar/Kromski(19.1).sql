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
UPDATE project SET budget = 150
UPDATE project SET budget = 110 WHERE project_no IN ('p1', 'p2','p3')
UPDATE project SET budget = 80 WHERE project_no IN ('p4', 'p5')

--WHILE 
GO
DECLARE @sum1 int
DECLARE @sum2 int
SET @sum1 = 500000
SET @sum2 = 240000

BEGIN
WHILE (SELECT SUM(budget) FROM project) < @sum1
	BEGIN
		UPDATE project SET  budget = budget * 1.1
		PRINT 'Change budget'
		IF (SELECT MAX(budget) FROM project) > @sum2
			BEGIN
				BREAK
			END
		ELSE 
			CONTINUE
	END
END
GO

GO
DECLARE @ErrorVar INT
UPDATE employee SET dept_no = 'd12' WHERE emp_no = 2581
SET @ErrorVar = @@ERROR
IF @ErrorVar <> 0
	BEGIN
		PRINT 'Error = ' + CAST(@ErrorVar AS NVARCHAR(8))
		PRINT 'Narushenije'
	END
GO

--Задание номер 19.1

--System query
SELECT * FROM employee_30
DELETE employee_30

--Создание таблицы 
CREATE TABLE employee_30 (emp_no INTEGER NOT NULL CONSTRAINT PK_emp_no PRIMARY KEY,
	emp_fname varchar(50) NOT NULL,
	emp_lname varchar(50) NOT NULL,
	dept_no varchar(50) NULL,
	salary varchar(50) NULL)

--Создание пакета для вставки 30 строк
GO
	DECLARE @emp_no INT = 1
	DECLARE @emp_fname varchar(50) = 'Aleksei'
	DECLARE @emp_lname varchar(50) = 'Kromski'
	DECLARE @dept_no varchar(50) = 'd1'
	DECLARE @salary varchar(50) = '1000'

	WHILE (SELECT COUNT(emp_no) FROM employee_30) < 30
		BEGIN
			INSERT INTO employee_30 VALUES (@emp_no,@emp_fname,@emp_lname,@dept_no,@salary)
			PRINT  'ID = ' + CAST(@emp_no AS varchar(50)) + ', was added'
			SET @emp_no = @emp_no + 1
		END
GO
