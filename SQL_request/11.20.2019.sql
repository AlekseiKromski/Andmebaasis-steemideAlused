USE smpl_AlekseiKromski

SELECT * INTO employee_enh FROM employee

SELECT * FROM employee_enh

SELECT domicile FROM employee_enh UNION SELECT location FROM department

SELECT emp_no FROM employee WHERE dept_no = 'd1' INTERSECT SELECT emp_no FROM works_on WHERE enter_date < '01.01.2008'

SELECT emp_no FROM works_on WHERE enter_date < '01.01.2008' EXCEPT SELECT emp_no FROM employee WHERE dept_no = 'd1'

SELECT project_name, CASE WHEN budget > 0 AND budget < 100000 THEN 1 WHEN budget >= 100000 AND budget < 200000 THEN 2 WHEN budget >= 200000 AND budget < 300000 THEN 3 ELSE 4 END budget_weight FROM project

SELECT emp_no, emp_lname, salary, CASE WHEN salary >= 3000 THEN 'palk >=3000' WHEN salary >= 2000 THEN 'palk >=2000' ELSE 'palk < 2000' END salaryTypeWithElse,CASE WHEN salary >= 3000 THEN 'palk >=3000' WHEN salary >= 2000 THEN 'palk >=2000' END salaryType  FROM employee_enh

SELECT * FROM employee_enh

SELECT emp_fname, emp_lname, salary, 
CASE 
	WHEN e1.salary < (SELECT AVG(e2.salary) FROM employee_enh e2 )
		THEN 'below average' 
	WHEN e1.salary = (SELECT AVG(e2.salary) FROM employee_enh e2 )
		THEN'on average' 
	WHEN e1.salary > (SELECT AVG(e2.salary) FROM employee_enh e2 )
		THEN 'above average'
END salary_status
FROM employee_enh e1

SELECT emp_no, emp_lname, salary, dept_no,
CASE
	WHEN dept_no = 'd2' THEN '10%' -- 10% 
	WHEN dept_no = 'd3' THEN '15%' -- 15%
	ELSE '5%'
END NewYearBonusPercent,
salary/100*
CASE
	WHEN dept_no = 'd2' THEN 10
	WHEN dept_no = 'd3' THEN 15
	ELSE 5
END BonusAmunt
FROM employee_enh