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

ALTER TABLE cars DROP CONSTRAINT DF__cars__condition__22AA2996
ALTER TABLE cars ADD CONSTRAINT default_condition DEFAULT 'normal' FOR condition

INSERT INTO cars VALUES ('Hyundai','Kona','1.12.2012',16000,DEFAULT,DEFAULT),('Toyota','86','1.12.2011',5000,DEFAULT,DEFAULT)

ALTER TABLE cars ADD reg_code INTEGER IDENTITY(2017000, 1)

INSERT INTO cars VALUES ('Hyundai','Kona','1.12.2012',16000,DEFAULT,DEFAULT)

ALTER TABLE cars ADD PRIMARY KEY(reg_code)

UPDATE cars SET price = price - ((price * 20) / 100) WHERE price < 2000

SELECT * FROM cars

--Покупатель

CREATE TABLE customer(isikukood VARCHAR(30) PRIMARY KEY,F_name VARCHAR(30), S_name VARCHAR(30) NOT NULL, email VARCHAR(30), tel VARCHAR(30))

INSERT INTO customer VALUES(50208302215,'Aleksei', 'Kromski','aleksei.kromski@ivkhk.ee','+37259544552'),(51233213315,'Nikita', 'Merezen','Nikita.Merezen@ivkhk.ee','+37255645666')

SELECT * FROM customer

--Владелец и их машины
CREATE TABLE customer_cars(reg_code INTEGER,
	isikukood VARCHAR(30),
	date_reg DATETIME DEFAULT getdate(),
	PRIMARY KEY (reg_code,isikukood))

INSERT INTO customer_cars VALUES (2017004,50208302215,DEFAULT),(2017007,51233213315,DEFAULT)

UPDATE cars SET status = 'No' WHERE reg_code IN (SELECT reg_code FROM cars WHERE reg_code IN (SELECT reg_code FROM customer_cars ))

ALTER TABLE customer_cars ADD CONSTRAINT FK_cars FOREIGN KEY(reg_code) REFERENCES cars (reg_code)

ALTER TABLE customer_cars ADD CONSTRAINT FK_customer FOREIGN KEY(isikukood) REFERENCES customer (isikukood)

SELECT * FROM customer_cars