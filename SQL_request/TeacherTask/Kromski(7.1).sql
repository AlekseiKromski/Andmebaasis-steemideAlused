USE smpl_AlekseiKromski

--SELECT * FROM employee
--SELECT * FROM department
--SELECT * FROM project
--SELECT * FROM works_on

--SELECT * FROM employee WHERE dept_no = (SELECT dept_no FROM department WHERE dept_name = 'Research')

--SELECT * FROM employee WHERE dept_no IN (SELECT dept_no FROM department WHERE location = 'Dallas') -- in работает со списком 

--SELECT * FROM employee WHERE emp_no IN (SELECT emp_no FROM works_on WHERE project_no IN (SELECT project_no FROM project WHERE project_name = 'Gemini'))

--Задания 7.1 (Kromski)
--6.18

SELECT * FROM department WHERE dept_no IN (SELECT TOP(1) dept_no FROM employee  GROUP by dept_no ORDER BY COUNT(dept_no) DESC)

SELECT * FROM department WHERE dept_no IN (SELECT dept_no FROM employee GROUP BY dept_no HAVING COUNT(dept_no) = (SELECT TOP 1 COUNT(dept_no) FROM employee  GROUP BY dept_no ORDER BY 1 DESC))

SELECT * FROM department WHERE dept_no IN (SELECT dept_no FROM employee GROUP BY dept_no HAVING COUNT(dept_no) = (SELECT TOP 1 COUNT(dept_no) FROM employee  GROUP BY dept_no ORDER BY 1))

SELECT * FROM department WHERE dept_no IN (SELECT TOP(1) dept_no FROM employee  GROUP by dept_no ORDER BY COUNT(dept_no))

--6.19

SELECT location FROM department WHERE dept_no = (SELECT TOP(1) dept_no FROM employee  GROUP by dept_no ORDER BY COUNT(dept_no))

--6.20

SELECT * FROM employee WHERE dept_no IN (SELECT dept_no FROM department WHERE location = 'Seattle')
SELECT * FROM employee WHERE dept_no IN (SELECT dept_no FROM department WHERE location = 'Dallas')

--6.21

SELECT emp_fname, emp_lname FROM employee WHERE emp_no = (SELECT emp_no FROM works_on WHERE enter_date = '2007-01-04')
SELECT emp_fname, emp_lname FROM employee WHERE emp_no IN (SELECT emp_no FROM works_on WHERE MONTH(enter_date) = '1' OR MONTH(enter_date) = '2')

--6.22

SELECT * FROM employee WHERE dept_no = 'd3' OR emp_no IN (SELECT emp_no FROM works_on WHERE job = 'Clerk')

--6.23

SELECT project_name FROM project WHERE project_no IN (SELECT project_no FROM works_on WHERE Job = 'Clerk')

--После того, как мы в под. запросе сделали вывод всех номеров проекта, где работа была Clerk. В старом запросе стоит '=', но при этом он возвращает несколько значений.
--Для того, чтобы это починить, надо использовать 'IN', а не =


