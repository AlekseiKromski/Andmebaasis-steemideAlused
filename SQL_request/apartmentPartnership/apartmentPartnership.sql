--Create database 
CREATE DATABASE apartmentPartnership
	ON (NAME = projects_dat, FILENAME = 'D:\JPTVR18\Andmebaasis-steemideAlused\SQL_request\apartmentPartnership\db\projects.mdf', SIZE = 5, MAXSIZE = 100, FILEGROWTH = 5)
	LOG ON (NAME = projects_log, FILENAME = 'D:\JPTVR18\Andmebaasis-steemideAlused\SQL_request\apartmentPartnership\jr\projects.ldf', SIZE = 10, MAXSIZE = 100, FILEGROWTH = 10)

--Create tables
--Owner table
CREATE TABLE owners (ownerId VARCHAR(11) PRIMARY KEY NOT NULL,
		ownerLname VARCHAR(40) NOT NULL,
		ownerFname VARCHAR(40) NOT NULL,
		ownerPhone VARCHAR(15) NOT NULL,
		ownerEmail VARCHAR(40) NOT NULL
	)

--Apartment table
CREATE TABLE apartmentInfo (apartmentID INT PRIMARY KEY NOT NULL,
	apartmentSquare FLOAT NOT NULL,
	apartmentTypeHeating VARCHAR(15) NOT NULL DEFAULT 'central',
	CHECK(apartmentTypeHeating IN ('central','electro','gas')),
	apartmentPercent FLOAT NOT NULL DEFAULT 100,
	apartmentOwner VARCHAR(11) NOT NULL,
	CONSTRAINT FK_apartmentOwner FOREIGN KEY(apartmentOwner) REFERENCES owners (ownerId)
	)

--Tariff table 
CREATE TABLE tariff (
	tariffID INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	tariffDate DATE NOT NULL,
	tariffPrice MONEY NOT NULL
)

--Counter table 
CREATE TABLE counter (
	counterDate DATE NOT NULL,
	counterMWH FLOAT NOT NULL,
	userEnter VARCHAR(15) NOT NULL DEFAULT 'admin',
	counterEnter DATE NOT NULL DEFAULT GETDATE()
)

--### QUERY ###
USE apartmentPartnership

--Drop query
DROP TABLE owners
DROP TABLE apartmentInfo
DROP TABLE tariff
DROP TABLE counter

--Select query
SELECT * FROM owners
SELECT * FROM apartmentInfo
SELECT * FROM tariff
SELECT * FROM counter

--Insert query

--Owners insert 
INSERT INTO owners VALUES
	(50208302215,'Aleksei','Kromski','+37259433588','aleksei.kromski@ivkhk.ee'),
	(50209292215,'Maksim','Kovalski','3728812399309','aojv@mail.ru'),
	(50209282215,'Eric','Perez','+3723424342343','kggfpxw@yandex.ru'),
	(50209272215,'Richard','Reed','+37244223444','oxxv@yandex.ru'),
	(50209262215,'John','Hall','+37275577557','f9jxjd14@gmail.com'),
	(50209252215,'Diego','Powell','+3725573799','p24a@mail.ru'),
	(50209242215,'Thomas','White','+37226644766','ahbg@yandex.ru'),
	(50209232215,'Daniel','Hall','+3725794445677','xl9bc5@gmail.com'),
	(50209222215,'Tyler','Robinson','+37235766533','q4aptu@mail.ru'),
	(50209212215,'Matthew','Nelson','+37211234577','n4zc9kz@yandex.ru')

--apartmentInfo insert
INSERT INTO apartmentInfo VALUES
	(1,60.0,DEFAULT,DEFAULT,'50208302215'),
	(2,40.0,'electro',12.0,'50209292215'),
	(3,50.0,'electro',7.0,'50209282215'),
	(4,60.0,'gas',12.0,'50209272215'),
	(5,40.0,DEFAULT,DEFAULT,'50209262215'),
	(6,60.0,'gas',7.0,'50209252215'),
	(7,50.0,'electro',17.0,'50209242215'),
	(8,40.0,'gas',5.0,'50209232215'),
	(9,40.0,'electro',19.0,'50209222215'),
	(10,50.0,DEFAULT,DEFAULT,'50209212215')

--tariff insert
INSERT INTO tariff (tariffDate,tariffPrice) VALUES
	('2020-03-06',66.26)

--Counter insert
INSERT INTO counter VALUES
	(GETDATE(),29.439,DEFAULT,DEFAULT)