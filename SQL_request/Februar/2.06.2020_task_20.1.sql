USE smpl_AlekseiKromski

--Сложный запрос на базе оптовых задачь
--USE WholeSale
GO
CREATE VIEW report AS
SELECT Customers.CustomerID, SUM(OrderDetails.Quantity) AS quantity, SUM(OrderDetails.UnitPrice * OrderDetails.Quantity) AS summa, Shippers.CompanyName AS ship, YEAR(Orders.ShippedDate) AS shipYear FROM Orders 
	INNER JOIN Customers ON Customers.CustomerID = Orders.CustomerID
	INNER JOIN Shippers ON Orders.ShipVia = Shippers.ShipperID
	INNER JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID
	GROUP BY Customers.CustomerID, YEAR(Orders.ShippedDate), Shippers.CompanyName
GO

SELECT * FROM report

--Aleksei Kromski JPTVR18 (20.1)

--21.1
GO
	CREATE VIEW zadanije_21_1 AS
	SELECT * FROM employee WHERE dept_no = 'd1'
GO

SELECT * FROM zadanije_21_1

--21.2
GO
	CREATE VIEW zadanije_21_2 (project_no, project_name) AS
	SELECT project_no, project_name FROM project
GO

SELECT * FROM zadanije_21_2

--21.3
GO
	CREATE VIEW zadanije_21_3 AS
	SELECT emp_fname, emp_lname FROM employee INNER JOIN works_on ON employee.emp_no = works_on.emp_no WHERE YEAR(works_on.enter_date) >= '2007' AND  MONTH(works_on.enter_date) >= '06'
GO

SELECT * FROM zadanije_21_3

--21.4
GO
	CREATE VIEW zadanije_21_4 (first,last) AS
	SELECT emp_fname, emp_lname FROM zadanije_21_3 INNER JOIN works_on ON employee.emp_no = works_on.emp_no WHERE YEAR(works_on.enter_date) >= '2007' AND  MONTH(works_on.enter_date) >= '06'

GO

SELECT * FROM zadanije_21_4

--21.5
GO
	CREATE VIEW zadanije_21_5 AS
	SELECT * FROM employee WHERE SUBSTRING(emp_lname,0,2) = 'M'
GO
SELECT * FROM zadanije_21_5

--21.6
GO
	CREATE VIEW zadanije_21_6 AS
	SELECT * FROM project WHERE project_no = (SELECT project_no FROM works_on WHERE emp_no = (SELECT emp_no FROM employee WHERE emp_lname = 'Smith'))
GO
SELECT * FROM zadanije_21_6

--21.7
GO
	ALTER VIEW zadanije_21_1 AS SELECT * FROM employee  WHERE dept_no = 'd1' OR dept_no = 'd2'
GO
SELECT * FROM zadanije_21_1

--21.8
GO
	DROP view zadanije_21_3
GO

--21.9
GO
	INSERT INTO zadanije_21_2 VALUES ('p6','Raketa')
GO

--21.10
GO
	CREATE VIEW zadanije_21_10 AS
	SELECT * FROM employee WHERE emp_no < 10000 WITH CHECK OPTION
GO
SELECT * FROM zadanije_21_10
INSERT INTO zadanije_21_10 (emp_no, emp_lname, dept_no) VALUES ('22123','Kont','d3')

--21.11
--Без WITH CHECK OPTION можно спокойно добавить данные, которые не подходят под условие.
--!!!Данные не вставяться, т.к будет дублирование ключа!!!
GO
	CREATE VIEW zadanije_21_11 AS
	SELECT * FROM employee WHERE emp_no < 10000
GO
DROP VIEW zadanije_21_11
--!!!Нужно изменить emp_no!!!
INSERT INTO zadanije_21_11 (emp_no, emp_lname, dept_no) VALUES ('22123','Kont','d3')

--21.12
GO
	CREATE VIEW zadanije_21_12 AS
	SELECT * FROM works_on WHERE YEAR(enter_date) = '2007' OR  YEAR(enter_date) = '2008' WITH CHECK OPTION
GO
SELECT * FROM zadanije_21_12

UPDATE zadanije_21_12 SET enter_date = '2006-01-06' WHERE emp_no = '2581'

--21.13
-- Без WITH CHECK OPTION можно спокойно добавить данные, проверка не работает
GO
	CREATE VIEW zadanije_21_13 AS
	SELECT * FROM works_on WHERE YEAR(enter_date) = '2007' OR  YEAR(enter_date) = '2008'
GO
SELECT * FROM zadanije_21_13

UPDATE zadanije_21_13 SET enter_date = '2006-01-06' WHERE emp_no = '2581'