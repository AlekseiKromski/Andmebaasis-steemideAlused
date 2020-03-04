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


--### QUERY ###
--Drop query
DROP TABLE apartmentInfo

--Select query
SELECT * FROM owners
SELECT * FROM apartmentInfo

--Insert query
INSERT INTO owners VALUES
	(50208302215,'Aleksei','Kromski','+37259433588','aleksei.kromski@ivkhk.ee'),
	(50209292215,'Maksim','Kovalski','3728812399309','aojv@mail.ru'),
	(50209282215,'Лобанов','Нестор','+3723424342343','kggfpxw@yandex.ru'),
	(50209272215,'Яромир','Шестаков','+37244223444','oxxv@yandex.ru'),
	(50209262215,'Харитон','Петров','+37275577557','f9jxjd14@gmail.com'),
	(50209252215,'Харитон','Захарченко','+3725573799','p24a@mail.ru'),
	(50209242215,'Арсений','Денисов','+37226644766','ahbg@yandex.ru'),
	(50209232215,'Жерар','Вишняков','+3725794445677','xl9bc5@gmail.com'),
	(50209222215,'Платон','Алексеев','+37235766533','q4aptu@mail.ru'),
	(50209212215,'Харитон','Блинов','+37211234577','n4zc9kz@yandex.ru')
