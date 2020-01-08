USE sampleDP

CREATE TABLE MYTimestampTable (PriKey int PRIMARY KEY, timestamp);

--Select
SELECT * FROM MYTimestampTable

--Insert
INSERT INTO MYTimestampTable (PriKey) VALUES (100)
INSERT INTO MYTimestampTable (PriKey) VALUES (120)

--Update
UPDATE MYTimestampTable SET PriKey = 105 WHERE PriKey = 120

USE WholeSale

SELECT * FROM Products

SELECT ProductID, ProductName, UnitsInStock, CAST(ProductID AS CHAR(5)) + ProductName + ' ' + CAST(UnitsInStock AS CHAR(5)) FROM Products

SELECT UnitPrice, CONVERT(DECIMAL(10,1), UnitPrice) FROM Products

SELECT CAST(UnitPrice AS DECIMAL(10,1)) FROM Products

--Maket for site 
SELECT * FROM works_on
SELECT * FROM employee
SELECT * FROM project

SELECT project.project_name,works_on.project_no,COUNT(*) FROM works_on 
INNER JOIN project ON works_on.project_no = project.project_no 
GROUP BY works_on.project_no, project.project_name

