use sample_AlekseiKromski

GO
	CREATE FUNCTION compute_costs(@pervent INT = 10)
	RETURNS DECIMAL (16,2)
		BEGIN
			DECLARE @additional_costs DEC (14,2),@sum_budget DEC(16,2)
			SELECT @sum_budget = SUM(budget) FROM project SET @additional_costs = @sum_budget * @pervent/100
			RETURN @additional_costs
		END
GO

SELECT SUM(budget) FROM project

SELECT dbo.compute_costs(25)
SELECT dbo.compute_costs(5)
SELECT dbo.compute_costs(10)

GO
	CREATE FUNCTION employee_in_project(@pr_number CHAR(4))
	RETURNS TABLE
		AS RETURN (SELECT employee.emp_no,emp_fname, emp_lname FROM works_on, employee
		WHERE employee.emp_no = works_on.emp_no AND project_no = @pr_number)
GO

DROP FUNCTION employee_in_project

SELECT * FROM dbo.employee_in_project('p2')

SELECT * FROM employee

INSERT INTO employee VALUES ('9999','Alvin','Kelk',null)

SELECT * FROM employee
SELECT * FROM works_on
GO
	CREATE FUNCTION emp(@emp_no VARCHAR(20))
	RETURNS @emp TABLE (emp_no INT, FaL_name VARCHAR(20), count_project VARCHAR(20))
		BEGIN
			IF (SELECT emp_no FROM employee WHERE emp_no = '9999')
			IF @emp_no = 'All'
				BEGIN
					INSERT INTO @emp 
						SELECT employee.emp_no, employee.emp_fname + ' ' + employee.emp_lname AS FaL_name, COUNT(works_on.project_no) AS count_proj 
						FROM employee LEFT JOIN works_on ON employee.emp_no = works_on.emp_no
						GROUP BY employee.emp_no, employee.emp_fname + ' ' + employee.emp_lname
				END
			ELSE
				BEGIN
					INSERT INTO @emp 
						SELECT employee.emp_no, employee.emp_fname + ' ' + employee.emp_lname AS FaL_name, COUNT(works_on.project_no) AS count_proj 
						FROM employee INNER JOIN works_on ON employee.emp_no = works_on.emp_no WHERE employee.emp_no = @emp_no
						GROUP BY employee.emp_no, employee.emp_fname + ' ' + employee.emp_lname
				END
			RETURN
		END
GO

DROP FUNCTION emp

SELECT * FROM dbo.emp('All')

