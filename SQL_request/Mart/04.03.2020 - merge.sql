USE sample_AlekseiKromski

--Disable some triggers
DISABLE TRIGGER modify_budget ON project;
DISABLE TRIGGER total_budget ON project;

--Create bonus table
CREATE TABLE bonus (pr_no CHAR(4), bonus SMALLINT DEFAULT 100)

--Insert data
INSERT INTO bonus(pr_no) VALUES ('p1')

--SYSTEM REQUESTS
SELECT * FROM bonus 
SELECT * FROM project

--Change for Merge 
UPDATE project SET budget = 1000 WHERE project_no = 'p3'

--Marge
MERGE INTO bonus B
	USING (SELECT project_no, budget FROM project) E ON (B.pr_no = E.project_no)
		WHEN MATCHED THEN
		UPDATE SET B.bonus = E.budget * 0.1
	WHEN NOT MATCHED THEN
		INSERT (pr_no, bonus) VALUES (E.project_no, E.budget * 0.05);


--Delete
GO
	DECLARE @del_table table (emp_no INT, emp_lname CHAR(20))

	DELETE employee OUTPUT DELETED.emp_no, DELETED.emp_lname INTO @del_table WHERE emp_no > 15000

	SELECT * FROM @del_table
GO

GO
	DECLARE @updated_table TABLE (emp_no INT, project_no CHAR(20),old_job CHAR(20),new_job CHAR(20));
	UPDATE works_on SET job =  NULL OUTPUT DELETED.emp_no, DELETED.project_no, DELETED.job, INSERTED.job INTO @updated_table WHERE job = 'Clerk'
	SELECT * FROM @updated_table
GO