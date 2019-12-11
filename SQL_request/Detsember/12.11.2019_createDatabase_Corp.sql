--uses database
USE master
USE test_AK

--################## SYSTEM QUERY #################

--
DROP TABLE employee

--Create database
CREATE DATABASE test_AK
	ON (NAME = test_AK_dat, FILENAME = 'D:\JPTVR18\Kromski2\test2\db\test.mdf', SIZE = 5, MAXSIZE = 100, FILEGROWTH = 5)
	LOG ON (NAME = test_AK_log, FILENAME = 'D:\JPTVR18\Kromski2\test2\jr\test.mdf', SIZE = 10, MAXSIZE = 100, FILEGROWTH = 10)

--System query
SELECT * FROM employee

--################## SYSTEM QUERY #################


/*
* 
* 
*/

--Create table employee
CREATE TABLE employee(
	id_emp int,
	name_emp nvarchar(30) NOT NULL,
	birthday date,
	email nvarchar(30), 
	position nvarchar(30),
	department nvarchar(30)
)

--Alter table employee
ALTER TABLE employee ALTER COLUMN id_emp int NOT NULL
ALTER TABLE employee ALTER COLUMN name_emp nvarchar(30) NOT NULL
ALTER TABLE employee ADD CONSTRAINT PK_employees PRIMARY KEY(id_emp)

--Insert table employee
INSERT employee(id_emp,position,department,name_emp) VALUES
(1000,N'Директор',N'Администрация',N'Иванов И.И.'),
(1001,N'Программист',N'ИТ',N'Петров П.П.'),
(1002,N'Бухгалтер',N'Бухгалтерия',N'Сидоров С.С.'),
(1003,N'Старший программист',N'ИТ',N'Андреев А.А.')

