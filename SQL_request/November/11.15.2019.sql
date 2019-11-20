USE smpl_AlekseiKromski

--SELECT t1.dept_no, t1.dept_name, t1.location FROM department t1 JOIN department t2 ON t1.location = t2.location WHERE t1.dept_no <> t2.dept_no

--8.1
SELECT project.*, works_on.* FROM project INNER JOIN works_on ON project.project_no = works_on.project_no -- Натуранльное соединение
SELECT project.*, works_on.* FROM project, works_on WHERE project.project_no = works_on.project_no -- декартово произведение

--8.2
--Теоретически количество таблиц, которые можно соединить в
--инструкции SELECT, неограниченно.
--(Но одно условие соединения совмещает только две таблицы!)
--Однако для компонента Database Engine количество соединяемых
--таблиц в инструкции SELECT ограничено 64 таблицами.--8.3SELECT emp_no, job FROM project JOIN works_on ON works_on.project_no = project.project_no WHERE project_name = 'Gemini'

--8.4
SELECT emp_fname, emp_lname FROM employee JOIN department ON employee.dept_no = department.dept_no WHERE dept_name = 'Research' OR dept_name = 'Accounting' 

--8.5
SELECT enter_date FROM works_on JOIN employee ON employee.emp_no = works_on.emp_no WHERE job = 'clerk'

--8.6
SELECT * FROM project WHERE project_no IN (SELECT project_no FROM works_on WHERE job = 'Clerk' GROUP BY project_no HAVING COUNT(job) >= 2)

--8.7
SELECT emp_fname, emp_lname FROM employee JOIN works_on ON employee.emp_no = works_on.emp_no JOIN project ON project.project_no = works_on.project_no WHERE job = 'Manager' AND project_name= 'Mercury'