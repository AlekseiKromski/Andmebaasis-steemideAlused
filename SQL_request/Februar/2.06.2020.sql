USE smpl_AlekseiKromski

SELECT * FROM department
SELECT * FROM employee
SELECT * FROM works_on
SELECT * FROM project


GO
	CREATE VIEW v_job_clerk
	AS
	SELECT * FROM works_on WHERE job = 'Clerk'
GO

Select * from v_job_clerk

GO
	CREATE VIEW projectCount(project_no, count_project) AS
	SELECT project_no, COUNT(*) FROM works_on GROUP BY project_no
GO

SELECT * FROM projectCount

GO
	CREATE VIEW v_project_2 AS
	Select * from v_job_clerk WHERE project_no = 'p3'
GO

SELECT * FROM v_project_2

GO
	CREATE VIEW v_dept AS
	SELECT dept_no, dept_name FROM department
GO

SELECT * FROM v_dept

GO
	CREATE VIEW v_works_2006 AS
	SELECT * FROM works_on WHERE YEAR(enter_date) = '2006'
	WITH CHECK OPTION
GO

SELECT * FROM v_works_2006

INSERT INTO v_works_2006 VALUES (77777, 'p2','IT','02-06-2020')

DROP VIEW v_works_2006