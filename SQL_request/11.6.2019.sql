USE smpl_AlekseiKromski


SELECT employee.*, department.* FROM employee INNER JOIN department ON department.dept_no = employee.dept_no

SELECT employee.*, department.* FROM employee, department WHERE department.dept_no = employee.dept_no

SELECT emp_fname, emp_lname FROM works_on JOIN employee ON works_on.emp_no = employee.emp_no JOIN department ON employee.dept_no = department.dept_no AND location = 'Seattle' AND job = 'analyst'

SELECT * FROM employee LEFT JOIN works_on ON employee.emp_no = works_on.emp_no

SELECT * FROM works_on RIGHT JOIN project ON works_on.project_no = project.project_no

INSERT INTO employee VALUES (1552311,'Kianu','Rivs', NULL),(15581,'ZZZ','sdd', NULL)

INSERT INTO department VALUES ('d4','HuMANS', 'FENIX'),('d5','DDS', 'Los-Angeles'),('d6','H0w2', 'Estonia')

UPDATE works_on SET job = 'IT' WHERE job IS NULL

SELECT * FROM works_on