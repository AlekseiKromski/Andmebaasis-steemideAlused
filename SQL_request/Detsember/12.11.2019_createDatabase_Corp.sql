--uses database
USE master
USE test_AK

--################## SYSTEM QUERY #################

--Drop table
DROP TABLE Employees
DROP TABLE #Temp

--Create database
CREATE DATABASE test_AK
	ON (NAME = test_AK_dat, FILENAME = 'D:\JPTVR18\Kromski2\test2\db\test.mdf', SIZE = 5, MAXSIZE = 100, FILEGROWTH = 5)
	LOG ON (NAME = test_AK_log, FILENAME = 'D:\JPTVR18\Kromski2\test2\jr\test.mdf', SIZE = 10, MAXSIZE = 100, FILEGROWTH = 10)

--System query
SELECT * FROM employees
SELECT * FROM #Temp
SELECT * FROM Positions
SELECT * FROM Departments

SELECT e.id_emp,e.name_emp,p.name_positions PositionName,d.name_departments DepartmentName
FROM Employees e
LEFT JOIN Departments d ON d.id_departments=e.DepartmentID
LEFT JOIN Positions p ON p.id_positions=e.PositionID
--################## SYSTEM QUERY #################


--Create table employees
CREATE TABLE employees(
	id_emp int,
	name_emp nvarchar(30) NOT NULL,
	birthday date,
	email nvarchar(30), 
	position nvarchar(30),
	department nvarchar(30)
)

CREATE TABLE employees(
  id_emp int NOT NULL,
  name_emp nvarchar(30) NOT NULL,
  birthday date,
  email nvarchar(30),
  position nvarchar(30),
  department nvarchar(30),
  CONSTRAINT PK_employees PRIMARY KEY(id_emp) -- описываем PK после всех полей, как ограничение
)

CREATE TABLE Positions(
  id_positions int IDENTITY(1,1) NOT NULL CONSTRAINT PK_Positions PRIMARY KEY,
  name_positions nvarchar(30) NOT NULL
)

CREATE TABLE Departments(
  id_departments int IDENTITY(1,1) NOT NULL CONSTRAINT PK_Departments PRIMARY KEY,
  name_departments nvarchar(30) NOT NULL
)

CREATE TABLE #Temp(
  ID int,
  Name nvarchar(30)
)

--Alter table employee
ALTER TABLE Employees ALTER COLUMN id_emp int NOT NULL
ALTER TABLE Employees ALTER COLUMN name_emp nvarchar(30) NOT NULL
ALTER TABLE Employees ADD CONSTRAINT PK_employees PRIMARY KEY(id_emp)
ALTER TABLE Employees DROP CONSTRAINT PK_Employees
ALTER TABLE Employees ADD PositionID int
ALTER TABLE Employees ADD DepartmentID int
ALTER TABLE Employees ADD CONSTRAINT FK_Employees_PositionID FOREIGN KEY(PositionID) REFERENCES Positions(id_positions)
ALTER TABLE Employees ADD CONSTRAINT FK_Employees_DepartmentID FOREIGN KEY(DepartmentID) REFERENCES Departments(id_departments)
ALTER TABLE Employees DROP COLUMN Position,Department
ALTER TABLE Employees ADD ManagerID int
ALTER TABLE Employees ADD CONSTRAINT FK_Employees_ManagerID FOREIGN KEY (ManagerID) REFERENCES Employees(id_emp)

--Insert table employee
INSERT Employees(id_emp,position,department,name_emp) VALUES
(1000,N'Директор',N'Администрация',N'Иванов И.И.'),
(1001,N'Программист',N'ИТ',N'Петров П.П.'),
(1002,N'Бухгалтер',N'Бухгалтерия',N'Сидоров С.С.'),
(1003,N'Старший программист',N'ИТ',N'Андреев А.А.')


--заполняем поле Name таблицы Positions, уникальными значениями из поля Position таблицы Employees
INSERT Positions(name_positions)
SELECT DISTINCT Position
FROM Employees
WHERE Position IS NOT NULL

INSERT Departments(name_departments)
SELECT DISTINCT Department
FROM Employees
WHERE Department IS NOT NULL

--Создание базы данных с автозаполнением с другой 
SELECT id_emp,name_emp
INTO #Temp2
FROM employees

--Update
UPDATE e
SET
  PositionID = (SELECT id_positions FROM Positions WHERE name_positions=e.Position),
  DepartmentID = (SELECT id_departments FROM Departments WHERE name_departments=e.Department)
FROM Employees e

--New action
SET IDENTITY_INSERT Departments ON
INSERT Departments(id_departments,name_departments) VALUES(3,N'ИТ')
SET IDENTITY_INSERT Departments OFF

CREATE TABLE Employees(
  id_emp int NOT NULL,
  emp_name nvarchar(30),
  birthday date,
  email nvarchar(30),
  PositionID int,
  DepartmentID int,
  ManagerID int,
	CONSTRAINT PK_Employees PRIMARY KEY (id_emp),
	CONSTRAINT FK_Employees_DepartmentID FOREIGN KEY(DepartmentID) REFERENCES Departments(id_departments)
	ON DELETE CASCADE,
	CONSTRAINT FK_Employees_PositionID FOREIGN KEY(PositionID) REFERENCES Positions(id_positions),
	CONSTRAINT FK_Employees_ManagerID FOREIGN KEY (ManagerID) REFERENCES Employees(id_emp)
)

INSERT Employees (id_emp,emp_name,birthday,PositionID,DepartmentID,ManagerID)VALUES
(1000,N'Иванов И.И.','19550219',2,1,NULL),
(1001,N'Петров П.П.','19831203',3,3,1003),
(1002,N'Сидоров С.С.','19760607',1,2,1000),
(1003,N'Андреев А.А.','19820417',4,3,1000)

INSERT Employees (id_emp,emp_name,birthday,PositionID,DepartmentID,ManagerID)VALUES
(1000,N'Иванов И.И.','19550219',2,1,NULL),
(1001,N'Петров П.П.','19831203',3,3,1003),
(1002,N'Сидоров С.С.','19760607',1,2,1000),
(1003,N'Андреев А.А.','19820417',4,3,1000)

INSERT Employees(id_emp,emp_name,email)VALUES(1004,N'Сергеев С.С.','s.sergeev@test.tt')
INSERT Employees(id_emp,email) VALUES(2000,'test@test.tt')
INSERT Employees(id_emp,email) VALUES(1500,'test@test.tt')

--Чистим таблицу
TRUNCATE TABLE Employees

--Alter table
ALTER TABLE Employees ADD HireDate date NOT NULL DEFAULT SYSDATETIME()
ALTER TABLE Employees ADD CONSTRAINT CK_Employees_ID CHECK(id_emp BETWEEN 1000 AND 1999)
ALTER TABLE Employees ADD UNIQUE(email)
ALTER TABLE Employees ADD CHECK(id_emp BETWEEN 1000 AND 1999)

--New task2
DROP TABLE Employees

CREATE TABLE Employees(
  ID int NOT NULL,
  Name nvarchar(30),
  Birthday date,
  Email nvarchar(30),
  PositionID int,
  DepartmentID int,
  HireDate date NOT NULL DEFAULT SYSDATETIME(), -- для DEFAULT я сделаю исключение
CONSTRAINT PK_Employees PRIMARY KEY (ID),
CONSTRAINT FK_Employees_DepartmentID FOREIGN KEY(DepartmentID) REFERENCES Departments(ID),
CONSTRAINT FK_Employees_PositionID FOREIGN KEY(PositionID) REFERENCES Positions(ID),
CONSTRAINT UQ_Employees_Email UNIQUE (Email),
CONSTRAINT CK_Employees_ID CHECK (ID BETWEEN 1000 AND 1999)
)