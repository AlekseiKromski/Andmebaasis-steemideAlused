--Создайте базу данных (регистрация продаваемых машин), база даных на диске D:\Группа
USE master

USE cars_AK

CREATE DATABASE cars_AK
	ON (NAME = projects_dat, FILENAME = 'D:\JPTVR18\Kromski2\cars\db\projects.mdf', SIZE = 5, MAXSIZE = 100, FILEGROWTH = 5)
	LOG ON (NAME = projects_log, FILENAME = 'D:\JPTVR18\Kromski2\cars\jr\projects.ldf', SIZE = 10, MAXSIZE = 100, FILEGROWTH = 10)

CREATE TABLE cars(mark VARCHAR(30),
	model VARCHAR(30),
	startYear DATE,
	price MONEY,
    status VARCHAR(4) DEFAULT 'Yes', CHECK (status in ('Yes','No')))

INSERT INTO cars VALUES 
	('Mercedes','W123','1.12.1996',800,DEFAULT),
	('Nissan','370Z','1.12.2018',10000,DEFAULT),
	('BMW','a4','1.12.1995',1000,DEFAULT) 

ALTER TABLE cars ADD condition VARCHAR(15) DEFAULT 'good' NULL

INSERT INTO cars (condition) VALUES ('good')

INSERT INTO cars VALUES 
	('Mercedes','A22','1.12.1999',200,DEFAULT,'bad'),
	('Nissan','371Z','1.12.2018',11000,DEFAULT,'normal') 

ALTER TABLE cars DROP CONSTRAIN

INSERT INTO cars VALUES 
	('Mercedes','A22','1.12.1999',200,DEFAULT,'bad')



SELECT * FROM cars


--