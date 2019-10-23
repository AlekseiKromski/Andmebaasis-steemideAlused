--USE STUDENT

--SELECT * FROM Student
--SELECT *, LEFT(ID_Isikukood,1) AS First_symbol, SUBSTRING(ID_Isikukood,6,2 ) AS day, SUBSTRING(ID_Isikukood,4,2 ) AS mounth , SUBSTRING(ID_Isikukood,2,2 ) AS year FROM Student 

USE smpl_AlekseiKromski

--SELECT job FROM works_on GROUP BY job

--SELECT MAX(emp_no) AS max_emp FROM employee 

--SELECT emp_fname, emp_lname FROM employee WHERE emp_no = (SELECT emp_no FROM works_on WHERE enter_date = (SELECT MAX(enter_date) FROM works_on WHERE job = 'Manager'))

--SELECT project_no, COUNT(DISTINCT job) job_count FROM works_on GROUP BY project_no

--SELECT project_no, COUNT(job) job_count FROM works_on GROUP BY project_no

SELECT job, COUNT(*) job_count,COUNT(job) AS Job_ON , COUNT(*) - COUNT(job) AS job_NULL FROM works_on GROUP BY job
