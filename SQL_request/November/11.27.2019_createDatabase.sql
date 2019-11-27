USE master
CREATE DATABASE projects_AK
	ON (NAME = projects_dat, FILENAME = 'D:\JPTVR18\Kromski2\test\db\projects.mdf', SIZE = 5, MAXSIZE = 100, FILEGROWTH = 5)
	LOG ON (NAME = projects_log, FILENAME = 'D:\JPTVR18\Kromski2\test\jr\projects.ldf', SIZE = 10, MAXSIZE = 100, FILEGROWTH = 10)

USE projects_AK

--System requests
SELECT * FROM product

--Create tables
CREATE TABLE product(product_no INTEGER IDENTITY(10000, 1) NOT NULL, product_name CHAR(30) NOT NULL, price MONEY) --(Identity - автоматом заполняет)

--Isert data to tables 
INSERT INTO product (product_name,price) VALUES('Iphone',999)
INSERT INTO product (product_name,price) VALUES('Xiaomi',120)
INSERT INTO product (product_name,price) VALUES('Samsung',800)