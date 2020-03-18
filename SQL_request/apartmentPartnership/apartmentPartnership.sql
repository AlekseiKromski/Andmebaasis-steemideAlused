--Create database (For school and personal pc)
CREATE DATABASE apartmentPartnership
	ON (NAME = projects_dat, FILENAME = 'D:\JPTVR18\Andmebaasis-steemideAlused\SQL_request\apartmentPartnership\db\projects.mdf', SIZE = 5, MAXSIZE = 100, FILEGROWTH = 5)
	LOG ON (NAME = projects_log, FILENAME = 'D:\JPTVR18\Andmebaasis-steemideAlused\SQL_request\apartmentPartnership\jr\projects.ldf', SIZE = 10, MAXSIZE = 100, FILEGROWTH = 10)

CREATE DATABASE apartmentPartnership
	ON (NAME = projects_dat, FILENAME = 'C:\Andmebaasis-steemideAlused\SQL_request\apartmentPartnership\db\projects.mdf', SIZE = 5, MAXSIZE = 100, FILEGROWTH = 5)
	LOG ON (NAME = projects_log, FILENAME = 'C:\Andmebaasis-steemideAlused\SQL_request\apartmentPartnership\jr\projects.ldf', SIZE = 10, MAXSIZE = 100, FILEGROWTH = 10)

--######################################

USE apartmentPartnership

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
	counterEnter DATE NOT NULL 
)

--paymentApartment
CREATE TABLE paymentApartment (
	apartmentID INT NOT NULL, -- id квартиры
	apartmentSquare FLOAT NOT NULL, -- Площадь квартиры
	heatingApartmentSquare FLOAT NOT NULL, -- Отапливаемая площадь в квартире
	apartmentSquarePrice MONEY NOT NULL, -- Цена за один м2
	tariff FLOAT NOT NULL, -- Тариф
	apartmentePrice MONEY NOT NULL, -- Цена за всю отапливаемую площадь
	scoreDate DATE NOT NULL, -- Дата
	CONSTRAINT FK_apartmentID FOREIGN KEY(apartmentID) REFERENCES apartmentInfo (apartmentID) ON DELETE CASCADE,
	CONSTRAINT FK_scoreDate FOREIGN KEY(scoreDate) REFERENCES counter (counterDate) ON DELETE CASCADE
)

--houseBillHistory
CREATE TABLE houseBillHistory (
	historyID INT IDENTITY PRIMARY KEY,
    Operation NVARCHAR(200) NOT NULL,
    CreateAt DATETIME NOT NULL DEFAULT GETDATE()
)

--ownerHistory
CREATE TABLE ownerHistory (
	historyID INT IDENTITY PRIMARY KEY,
    Operation NVARCHAR(200) NOT NULL,
    CreateAt DATETIME NOT NULL DEFAULT GETDATE()
)

--apartmentInfoHistory
CREATE TABLE apartmentInfoHistory (
	historyID INT IDENTITY PRIMARY KEY,
    Operation NVARCHAR(200) NOT NULL,
    CreateAt DATETIME NOT NULL DEFAULT GETDATE()
)

--######################################

--### QUERY FOR TESTING ###

--Drop query
DROP TABLE owners
DROP TABLE apartmentInfo
DROP TABLE tariff
DROP TABLE counter
DROP TABLE paymentApartment
DROP TABLE houseBillHistory
DROP TABLE ownerHistory
DROP TABLE apartmentInfoHistory

--Delete query 
DELETE FROM paymentApartment WHERE apartmentID = 1

--Select query
SELECT * FROM owners
SELECT * FROM apartmentInfo
SELECT * FROM tariff
SELECT * FROM counter
SELECT * FROM paymentApartment
SELECT * FROM houseBillHistory
SELECT * FROM ownerHistory
SELECT * FROM apartmentInfoHistory

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
	('2019-12-15',66.26)

DELETE FROM tariff WHERE tariffID = 1

--######################################

--Make proc

GO
	CREATE PROCEDURE addCounter (@counterMWH FLOAT, @enterDate DATE) AS
		BEGIN
			IF DAY(@enterDate) <= 28
				BEGIN
					INSERT INTO counter VALUES (EOMONTH ( @enterDate, -1 ),@counterMWH,DEFAULT,@enterDate)
				END
			ELSE
				BEGIN
					INSERT INTO counter VALUES (EOMONTH ( @enterDate, -2 ),@counterMWH,DEFAULT,@enterDate)
				END
		END
GO

--Drop proc
DROP PROCEDURE addCounter

--Run proc. 
EXEC addCounter '1','2020-01-20'


GO
	CREATE PROCEDURE houseBill AS 
	BEGIN
		DECLARE @var1 AS FLOAT
		DECLARE @var2 AS FLOAT
		DECLARE @result AS FLOAT
		DECLARE @allSquare AS FLOAT
		DECLARE @oneMPrice AS FLOAT
		DECLARE @tariff AS FLOAT
		DECLARE @date AS DATE
		BEGIN
			--Create variable for future requsets
			SELECT TOP 1 @date = counterDate FROM counter ORDER BY counterDate DESC
			SELECT TOP 1 @tariff = tariffPrice FROM tariff ORDER BY tariffPrice DESC 

			--Find amount of energy consumed
			IF(SELECT COUNT(*) FROM counter) > 1
				BEGIN
					SELECT TOP 1 @var1 = counterMWH FROM counter ORDER BY counterDate DESC
					SELECT TOP 1 @var2 = counterMWH FROM counter WHERE counterMWH IN (SELECT TOP 2 counterMWH FROM counter ORDER BY counterDate DESC)
					SET @result = @tariff * (@var1 - @var2)
				END
			ELSE
				BEGIN
					SELECT TOP 1 @var1 = counterMWH FROM counter ORDER BY counterDate DESC
					SET @result = @tariff * @var1
				END

			--Identification of all areas and the search for 1 m2
			SELECT @allSquare = SUM(apartmentSquare * (apartmentPercent / 100)) FROM apartmentInfo
			SET @oneMPrice = @result/@allSquare

			--Insert data into table
			INSERT INTO paymentApartment 
				SELECT apartmentID,
				apartmentSquare AS apartmentSquare,
				apartmentSquare * (apartmentPercent / 100) AS heatingApartmentSquare,
				@oneMPrice AS apartmentSquarePrice,
				@tariff AS tariff,
				@oneMPrice * (apartmentSquare * (apartmentPercent / 100)) AS apartmentePrice,
				@date AS scoreDate
				FROM apartmentInfo

			--Вывод данных, которые были только-что вставленны
			SELECT * FROM paymentApartment
		END
	END
GO

--Drop proc
DROP PROCEDURE houseBill

--Run proc. 
EXEC houseBill

--######################################

--Make triggers

--This trigger will be insert data into 'houseBillHistory' table 
GO
	CREATE TRIGGER houseBillHistory_inserted ON paymentApartment AFTER INSERT
	AS 
		BEGIN
			INSERT INTO houseBillHistory (Operation,CreateAt) VALUES ('new calculations for the month', DEFAULT)
			SELECT * FROM houseBillHistory
		END
GO

--Drop houseBillHistory_inserted trigger
DROP TRIGGER houseBillHistory_inserted

--Requset to houseBillHistory_inserted
SELECT * FROM houseBillHistory

--Triggers for ownerHistory

GO
	CREATE TRIGGER owner_inserted ON owners AFTER INSERT
	AS
		BEGIN
			INSERT INTO ownerHistory (Operation,CreateAt) VALUES ('INSERT', DEFAULT)
			SELECT * FROM ownerHistory
		END	
GO

GO
	CREATE TRIGGER owner_updated ON owners AFTER UPDATE
	AS
		IF UPDATE(ownerId)
			BEGIN
				INSERT INTO ownerHistory (Operation,CreateAt) VALUES ('UPDATE', DEFAULT)
				SELECT * FROM ownerHistory
			END	
GO

GO
	CREATE TRIGGER owner_deleted ON owners AFTER DELETE
	AS
		BEGIN
			INSERT INTO ownerHistory (Operation,CreateAt) VALUES ('DELETE', DEFAULT)
			SELECT * FROM ownerHistory
		END	
GO

--Drop owner trigger
DROP TRIGGER owner_inserted
DROP TRIGGER owner_deleted
DROP TRIGGER owner_updated

--Requset to owner

UPDATE owners SET ownerId = '50208302215' WHERE ownerId = '15' 
UPDATE owners SET ownerId = '15' WHERE ownerId = '50208302215' 

DELETE FROM owners WHERE ownerId = '15'

SELECT * FROM owners

--Triggers for apartmentInfoHistory
GO
	CREATE TRIGGER apartmentInfoHistory_inserted ON apartmentInfo AFTER INSERT
	AS
		BEGIN
			INSERT INTO apartmentInfoHistory (Operation,CreateAt) VALUES ('INSERT', DEFAULT)
			SELECT * FROM apartmentInfoHistory
		END	
GO

GO
	CREATE TRIGGER apartmentInfoHistory_updated ON apartmentInfo AFTER UPDATE
	AS
		IF UPDATE(apartmentSquare)
			BEGIN
				INSERT INTO apartmentInfoHistory (Operation,CreateAt) VALUES ('UPDATE', DEFAULT)
				SELECT * FROM apartmentInfoHistory
			END	
		IF UPDATE(apartmentTypeHeating)
			BEGIN
				INSERT INTO apartmentInfoHistory (Operation,CreateAt) VALUES ('UPDATE', DEFAULT)
				SELECT * FROM apartmentInfoHistory
			END	
		IF UPDATE(apartmentPercent)
			BEGIN
				INSERT INTO apartmentInfoHistory (Operation,CreateAt) VALUES ('UPDATE', DEFAULT)
				SELECT * FROM apartmentInfoHistory
			END
		IF UPDATE(apartmentOwner)
			BEGIN
				INSERT INTO apartmentInfoHistory (Operation,CreateAt) VALUES ('UPDATE', DEFAULT)
				SELECT * FROM apartmentInfoHistory
			END
GO

GO
	CREATE TRIGGER apartmentInfoHistory_deleted ON apartmentInfo AFTER DELETE
	AS
		BEGIN
			INSERT INTO apartmentInfoHistory (Operation,CreateAt) VALUES ('DELETE', DEFAULT)
			SELECT * FROM apartmentInfoHistory
		END
GO

--Drop apartmentInfo trigger
DROP TRIGGER apartmentInfoHistory_inserted
DROP TRIGGER apartmentInfoHistory_updated
DROP TRIGGER apartmentInfoHistory_deleted

--Requset to apartmentInfoHistory
UPDATE apartmentInfo SET apartmentPercent = '200' WHERE apartmentPercent = '100' 

DELETE FROM apartmentInfo WHERE apartmentPercent = '200'

SELECT * FROM apartmentInfo

--######################################

--Function to display owner information
GO
	CREATE FUNCTION	ownerInfo (@ownerId VARCHAR(15))
	RETURNS TABLE
		AS RETURN (SELECT * FROM owners WHERE ownerId = @ownerId)
GO

SELECT * FROM ownerInfo('50208302215')

--Function for displaying information about the apartment by owner 
GO
	CREATE FUNCTION	apartmentInfoByOwner (@ownerId VARCHAR(15))
	RETURNS TABLE
		AS RETURN (SELECT * FROM apartmentInfo WHERE apartmentOwner = @ownerId)
GO

SELECT * FROM apartmentInfoByOwner('50208302215')

--Conclusion of apartment bills
GO
	CREATE FUNCTION	houseBullByOwner (@ownerId VARCHAR(15))
	RETURNS TABLE
		AS RETURN (SELECT paymentApartment.*, apartmentInfo.apartmentOwner FROM paymentApartment 
		INNER JOIN apartmentInfo ON paymentApartment.apartmentID = apartmentInfo.apartmentID WHERE apartmentOwner = @ownerId)
GO

DROP FUNCTION houseBullByOwner

SELECT * FROM houseBullByOwner('50209232215')

--######################################

--Display all user information
CREATE VIEW allInfoAboutOwner AS
	SELECT * FROM apartmentInfo
	INNER JOIN owners ON apartmentInfo.apartmentOwner = owners.ownerId

DROP VIEW allInfoAboutOwner

SELECT * FROM allInfoAboutOwner

--######################################
--Create users 

--Create admin account
CREATE LOGIN admin WITH PASSWORD ='admin'

--Make admin role in db
CREATE SERVER ROLE admin_ap AUTHORIZATION admin
