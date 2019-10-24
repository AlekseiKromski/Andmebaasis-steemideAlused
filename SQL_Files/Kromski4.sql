USE sampleDP

--SELECT job FROM works_on

--SELECT job FROM works_on GROUP BY job --Группирует повтор. значения 

--SELECT project_no,job FROM works_on GROUP BY project_no,job --Группирует повтор. значения 

--SELECT MAX(emp_no) AS maks_empNo FROM employee

--SELECT emp_no, emp_lname FROM employee WHERE emp_no = (SELECT MAX(emp_no) FROM employee)

--SELECT emp_no FROM works_on WHERE enter_date = (SELECT MAX(enter_date) FROM works_on WHERE job = 'Manager')

SELECT COUNT(*) all_row, COUNT(job) not_null_row, COUNT(*) - COUNT(job) AS null_count FROM works_on

--SELECT project_no, COUNT(*) FROM works_on GROUP BY project_no HAVING COUNT(*) < 4

SELECT emp_fname, emp_lname, dept_no FROM employee WHERE emp_no < 20000 ORDER BY emp_lname, emp_fname