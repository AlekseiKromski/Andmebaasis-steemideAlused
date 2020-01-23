USE smpl_AlekseiKromski

SELECT * FROM project
UPDATE project SET budget = 89 WHERE project_no = 'p4'

GO
DECLARE @avg_budget MONEY, @extra_budget MONEY, @name_project VARCHAR(3)
SET @extra_budget = 15000
SET @name_project = 'p2'
SELECT @avg_budget = AVG(budget) FROM project
IF(SELECT budget FROM project WHERE project_no = @name_project) < @avg_budget
	BEGIN
		UPDATE project SET budget = budget + @extra_budget WHERE project_no = @name_project
		PRINT 'Budget for ' + @name_project + 'increased by @extra_budget'
	END 
	ELSE PRINT 'budget for ' + @name_project + ' unchandeg'
GO

CREATE TABLE #Accounts (CreatedAt DATE, Balance MONEY)

GO
	DECLARE @rate FLOAT = 0.065, @period INT = 5, @sum MONEY = 10000, @date DATE = GETDATE()
	WHILE @period > 0
		BEGIN
			INSERT INTO #Accounts VALUES(@date,@sum)
			SET @period = @period - 1
			SET @date = DATEADD(year, 1 , @date)
			SET @sum = @sum + @sum * @rate
		END
GO
SELECT * FROM #Accounts

GO
	DECLARE @number INT = 1
	WHILE @number < 10
		BEGIN
			PRINT CONVERT(nvarchar, @number)
			SET @number = @number + 1
			IF @number = 7 
				BREAK
			IF @number = 4
				CONTINUE
			PRINT N'End' 
		END
GO

SELECT * FROM employee


GO
DECLARE @error INT
UPDATE employee SET dept_no = 'd11' WHERE emp_no = 2581
SET @error = @@ERROR
if @error <> 0
	BEGIN
		PRINT 'Error = ' + CAST(@error AS nvarchar(8));
		PRINT 'Narushenije'
	END
GO

INSERT INTO employee VALUES (13,'Anu','Ressi','d2','3000')

GO
	DELETE FROM employee WHERE emp_no = 2581
	PRINT N'Error = ' + CAST(@@ERROR AS NVARCHAR(8))
	PRINT N'Rows Deleted = ' + CAST(@@ROWCOUNT AS NVARCHAR(8))
GO

SELECT RAND()
SELECT RAND(115)
SELECT 20*RAND()
SELECT CONVERT(INT,20*RAND())+50

SELECT RAND()*(50-100)+100

GO
DECLARE @c smallint
SET @c = 1
WHILE @c < 5
	BEGIN
		SELECT CONVERT(INT,50*RAND())+50
	END
GO

SELECT * FROM employee_30
DELETE FROM employee_30 
--19.1 не запускать!
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
--19.2
GO
	DECLARE @emp_fname varchar(50) = 'Aleksei'
	DECLARE @emp_lname varchar(50) = 'Kromski'
	DECLARE @dept_no varchar(50) = 'd1'
	DECLARE @salary varchar(50) = '1000'
	DECLARE @rand INT = 0
	WHILE (SELECT COUNT(emp_no) FROM employee_30) < 60
		BEGIN
			SELECT @rand = CONVERT(INT,10000*RAND())+10
			IF @rand <= 999 AND @rand >= 100
				BEGIN
					INSERT INTO employee_30 VALUES (@rand,@emp_fname,@emp_lname,@dept_no,@salary)
					PRINT  'ID = ' + CAST(@rand AS varchar(50)) + ', was added'
				END
		END
GO
--19.3
GO
	DECLARE @error INT
	DECLARE @emp_fname varchar(50) = 'Aleksei'
	DECLARE @emp_lname varchar(50) = 'Kromski'
	DECLARE @dept_no varchar(50) = 'd1'
	DECLARE @salary varchar(50) = '1000'
	DECLARE @rand INT = 0
	SET @error = @@ERROR
	WHILE (SELECT COUNT(emp_no) FROM employee_30) < 90
		BEGIN
			SELECT @rand = CONVERT(INT,90*RAND())+50
			IF @rand <= 90 AND @rand >= 50
				BEGIN
					INSERT INTO employee_30 VALUES (@rand,@emp_fname,@emp_lname,@dept_no,@salary)
					SET @error = @@ERROR
					IF @error <> 0
						BEGIN
							PRINT 'Error = ' + CAST(@error AS nvarchar(8));
							PRINT 'Pohozee 4islo!!'
						END
					PRINT  'ID = ' + CAST(@rand AS varchar(50)) + ', was added'
				END
			
		END
GO

--19.5
SELECT TOP 10 * FROM employee_30 
SELECT TOP 15 * FROM employee_30  ORDER BY emp_no DESC

GO
DECLARE @PageSize int = 20, @CurrentPage INT = 4
SELECT * FROM employee_30 ORDER BY emp_no OFFSET (@PageSize*(@CurrentPage-1)) ROWS FETCH NEXT @PageSize ROWS ONLY
GO