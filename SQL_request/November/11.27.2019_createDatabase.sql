USE master
CREATE DATABASE projects_AK
	ON (NAME = projects_dat, FILENAME = 'D:\JPTVR18\Kromski2\test\db\projects.mdf', SIZE = 5, MAXSIZE = 100, FILEGROWTH = 5)
	LOG ON (NAME = projects_log, FILENAME = 'D:\JPTVR18\Kromski2\test\jr\projects.ldf', SIZE = 10, MAXSIZE = 100, FILEGROWTH = 10)

USE projects_AK

--System requests
SELECT * FROM product
SELECT * FROM customer
SELECT * FROM sales

--Create tables
--v1
CREATE TABLE product(product_no INTEGER IDENTITY(10000, 1) NOT NULL, product_name CHAR(30) NOT NULL, price MONEY) --(Identity - автоматом заполняет)
--v2
CREATE TABLE product(product_no INTEGER IDENTITY(10000, 1) NOT NULL, product_name CHAR(30) NOT NULL, price MONEY, date_reg DATETIME DEFAULT Getdate()) --Если мы ничего не вставляем в столбец date_reg, то он ставит нынешнюю
--v3
CREATE TABLE product(product_no INTEGER IDENTITY(10000, 1) NOT NULL CONSTRAINT PK_product_no PRIMARY KEY, product_name CHAR(30) NOT NULL, price MONEY, date_reg DATETIME DEFAULT Getdate()) --Выставляем PK
CREATE TABLE customer(cust_no INTEGER IDENTITY(10000, 1) NOT NULL CONSTRAINT PK_cust_no PRIMARY KEY, cust_group CHAR(3) NULL, CHECK (cust_group IN ('c1','c2','c10')))
CREATE TABLE sales(
	sales_no INTEGER IDENTITY(10000, 1) CONSTRAINT PK_sales_no PRIMARY KEY,
	product INTEGER NOT NULL,
	count_product INTEGER DEFAULT 1 NOT NULL,
	sales_ClearanceDate DATETIME DEFAULT Getdate() NOT NULL,
	treatmentDate DATETIME DEFAULT Getdate() + 3, CHECK (treatmentDate >= sales_ClearanceDate),
	CONSTRAINT FK_product FOREIGN KEY(product) REFERENCES product (product_no)) 

--Isert data to tables 
--v1
INSERT INTO product (product_name,price) VALUES('Iphone',999)
INSERT INTO product (product_name,price) VALUES('Xiaomi',120)
INSERT INTO product (product_name,price) VALUES('Samsung',800)
--v2/v3
--Data for product
	INSERT INTO product (product_name,price,date_reg) VALUES('Samsung',800,DEFAULT)
	INSERT INTO product (product_name,price,date_reg) VALUES('Motorolla',NULL,'2019-12-05 06:08:58.555')
--Data for customer
	INSERT INTO customer VALUES('c2')
	INSERT INTO customer VALUES('c10')
	INSERT INTO customer VALUES('c5') -- !!! Это значение не вставиться из-за (CHECK) !!!
--Data for sales
	INSERT INTO sales (product,count_product,sales_ClearanceDate,treatmentDate) VALUES (10001,10,DEFAULT,DEFAULT)

--drop table
DROP TABLE product
DROP TABLE customer
DROP TABLE sales

--query

SELECT sales.sales_no,sales.product,sales.count_product, product.product_name, product.price, sales.count_product * product.price AS earned 
FROM sales JOIN product ON sales.product = product.product_no

SELECT SUM(sales.count_product * product.price) AS earned, COUNT(sales.count_product) as CountSales FROM sales JOIN product ON sales.product = product.product_no --Показывает, сколько всего заработано и коль.-во товара