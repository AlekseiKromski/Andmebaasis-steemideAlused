USE warehouse

--Create tables in database
CREATE TABLE warehouse (productId INT PRIMARY KEY, productName VARCHAR(40), productPrice MONEY, productCount INT)

CREATE TABLE orderProduct (productId INT PRIMARY KEY, productName VARCHAR(40), productPrice MONEY, productCount INT)

--System request
SELECT * FROM warehouse

SELECT * FROM orderProduct

--Insert data
INSERT INTO warehouse VALUES (1,'Milk Happy',0.80,60),(2,'Coca-cola',0.50,40),(3,'Sousage',0.30,100)

INSERT INTO orderProduct VALUES (1,'Milk Happy',0.80,60),(2,'Coca-cola',0.50,40),(3,'Sousage',0.30,100),(4,'Crisps',1.60,600)

