--Create database (For school and personal pc)
CREATE DATABASE apartmentPartnership
	ON (NAME = projects_dat, FILENAME = 'D:\JPTVR18\Andmebaasis-steemideAlused\SQL_request\apartmentPartnership\db\projects.mdf', SIZE = 5, MAXSIZE = 100, FILEGROWTH = 5)
	LOG ON (NAME = projects_log, FILENAME = 'D:\JPTVR18\Andmebaasis-steemideAlused\SQL_request\apartmentPartnership\jr\projects.ldf', SIZE = 10, MAXSIZE = 100, FILEGROWTH = 10)

CREATE DATABASE apartmentPartnership
	ON (NAME = projects_dat, FILENAME = 'C:\Andmebaasis-steemideAlused\SQL_request\apartmentPartnership\db\projects.mdf', SIZE = 5, MAXSIZE = 100, FILEGROWTH = 5)
	LOG ON (NAME = projects_log, FILENAME = 'C:\Andmebaasis-steemideAlused\SQL_request\apartmentPartnership\jr\projects.ldf', SIZE = 10, MAXSIZE = 100, FILEGROWTH = 10)

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
	counterDate DATE PRIMARY KEY NOT NULL,
	counterMWH FLOAT NOT NULL,
	userEnter VARCHAR(15) NOT NULL DEFAULT 'admin',
	counterEnter DATE NOT NULL DEFAULT GETDATE()
)

--paymentApartment
CREATE TABLE paymentApartment (
	apartmentID INT NOT NULL, -- id квартиры
	heatingApartmentSquare FLOAT NOT NULL, -- Отапливаемая площадь в квартире
	apartmentSquarePrice MONEY NOT NULL, -- Цена за один м2
	apartmentePrice MONEY NOT NULL, -- Цена за всю отапливаемую площадь
	scoreDate DATE NOT NULL, -- Дата
	CONSTRAINT FK_apartmentID FOREIGN KEY(apartmentID) REFERENCES apartmentInfo (apartmentID),
	CONSTRAINT FK_scoreDate FOREIGN KEY(scoreDate) REFERENCES counter (counterDate)
)


--### QUERY ###
USE apartmentPartnership

--Drop query
DROP TABLE owners
DROP TABLE apartmentInfo
DROP TABLE tariff
DROP TABLE counter
DROP TABLE paymentApartment

--Select query
SELECT * FROM owners
SELECT * FROM apartmentInfo
SELECT * FROM tariff
SELECT * FROM counter
SELECT * FROM paymentApartment

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
	('2020-01-31',10,DEFAULT,DEFAULT),
	('2020-02-28',15,DEFAULT,DEFAULT)

INSERT INTO counter VALUES
	('2020-03-30',20,DEFAULT,DEFAULT),
	('2020-04-30',25,DEFAULT,DEFAULT)

--For test
INSERT INTO counter VALUES
	('2020-05-30',30,DEFAULT,DEFAULT),
	('2020-06-30',35,DEFAULT,DEFAULT)

INSERT INTO counter VALUES
	('2020-07-30',40,DEFAULT,DEFAULT),
	('2020-08-30',45,DEFAULT,DEFAULT)

--Procedures and functions 

--house bill
--This package show you "how much house has consumed energy per month"

--Drop proc
DROP PROCEDURE houseBill

--Create proc
GO
	CREATE PROCEDURE houseBill AS 
	BEGIN
		DECLARE @var1 AS FLOAT
		DECLARE @var2 AS FLOAT
		DECLARE @result AS FLOAT
		DECLARE @allSquare AS FLOAT
		DECLARE @oneM AS FLOAT
		DECLARE 
		BEGIN
			--Find house bill 
			SELECT TOP 1 @var1 = counterMWH FROM counter ORDER BY counterDate DESC
			SELECT TOP 1 @var2 = counterMWH FROM counter WHERE counterMWH IN (SELECT TOP 2 counterMWH FROM counter ORDER BY counterDate DESC)
			SELECT TOP 1 @result = tariffPrice FROM tariff ORDER BY tariffPrice DESC 
			SET @result = @result * (@var1 - @var2)

			--Площадь отпления в квартире 
			SELECT apartmentSquare * (apartmentPercent / 100) AS apartmentHeating FROM apartmentInfo
			SELECT @allSquare = SUM(apartmentSquare * (apartmentPercent / 100)) FROM apartmentInfo
			SET @oneM = @result/@allSquare 
		END
	END
GO

GO
		DECLARE @var1 AS FLOAT
		DECLARE @var2 AS FLOAT
		DECLARE @result AS FLOAT
		DECLARE @allSquare AS FLOAT
		DECLARE @oneMPrice AS FLOAT
		DECLARE @tariff AS FLOAT

		BEGIN
			--Поиск кол-во потребленной энергии
			SELECT TOP 1 @var1 = counterMWH FROM counter ORDER BY counterDate DESC
			SELECT TOP 1 @var2 = counterMWH FROM counter WHERE counterMWH IN (SELECT TOP 2 counterMWH FROM counter ORDER BY counterDate DESC)
			SELECT TOP 1 @tariff = tariffPrice FROM tariff ORDER BY tariffPrice DESC 
			SET @result = @tariff * (@var1 - @var2)

			--Площадь отпления в квартире 
			SELECT @allSquare = SUM(apartmentSquare * (apartmentPercent / 100)) FROM apartmentInfo
			SET @oneMPrice = @result/@allSquare

			SELECT apartmentID,
			apartmentSquare * (apartmentPercent / 100) AS heatingApartmentSquare,
			@oneMPrice AS apartmentSquarePrice,
			@oneMPrice * (apartmentSquare * (apartmentPercent / 100)) AS apartmentePrice,

			FROM apartmentInfo

			
		END
GO
INSERT INTO paymentApartment VALUES SELECT apartmentID,  FROM apartmentInfo
--Run proc. 
EXEC houseBill