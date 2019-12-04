USE master
CREATE DATABASE projects_AK
	ON (NAME = projects_dat, FILENAME = 'D:\JPTVR18\Kromski2\test\db\projects.mdf', SIZE = 5, MAXSIZE = 100, FILEGROWTH = 5)
	LOG ON (NAME = projects_log, FILENAME = 'D:\JPTVR18\Kromski2\test\jr\projects.ldf', SIZE = 10, MAXSIZE = 100, FILEGROWTH = 10)

USE projects_AK

--System requests
SELECT * FROM product
SELECT * FROM customer

--Create tables
--v1
CREATE TABLE product(product_no INTEGER IDENTITY(10000, 1) NOT NULL, product_name CHAR(30) NOT NULL, price MONEY) --(Identity - ��������� ���������)
--v2
CREATE TABLE product(product_no INTEGER IDENTITY(10000, 1) NOT NULL, product_name CHAR(30) NOT NULL, price MONEY, date_reg DATETIME DEFAULT Getdate()) --���� �� ������ �� ��������� � ������� date_reg, �� �� ������ ��������
--v3
CREATE TABLE product(product_no INTEGER IDENTITY(10000, 1) NOT NULL CONSTRAINT PK_product_no PRIMARY KEY, product_name CHAR(30) NOT NULL, price MONEY, date_reg DATETIME DEFAULT Getdate()) --���������� PK
CREATE TABLE customer(cust_no INTEGER IDENTITY(10000, 1) NOT NULL CONSTRAINT PK_cust_no PRIMARY KEY, cust_group CHAR(3) NULL, CHECK (cust_group IN ('c1','c2','c10')))

--Isert data to tables 
--v1
INSERT INTO product (product_name,price) VALUES('Iphone',999)
INSERT INTO product (product_name,price) VALUES('Xiaomi',120)
INSERT INTO product (product_name,price) VALUES('Samsung',800)
--v2
--Data for product
	INSERT INTO product (product_name,price,date_reg) VALUES('Samsung',800,DEFAULT)
	INSERT INTO product (product_name,price,date_reg) VALUES('Motorolla',NULL,'2019-12-05 06:08:58.555')
--Data for customer
	INSERT INTO customer VALUES('c2')
	INSERT INTO customer VALUES('c10')
	INSERT INTO customer VALUES('c5') -- !!! ��� �������� �� ���������� ��-�� (CHECK) !!!

--drop table
DROP TABLE product
DROP TABLE customer