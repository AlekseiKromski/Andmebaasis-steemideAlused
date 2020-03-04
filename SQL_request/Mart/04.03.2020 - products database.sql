USE warehouse

--Create tables in database
CREATE TABLE warehouse (productId INT PRIMARY KEY, productName VARCHAR(40), productPrice MONEY, productCount INT)

CREATE TABLE orderProduct (productId INT PRIMARY KEY, productName VARCHAR(40), productPrice MONEY, productCount INT)

--System request
SELECT * FROM warehouse

SELECT * FROM orderProduct

--Insert data
INSERT INTO warehouse VALUES (1,'Milk Happy',0.80,60),(2,'Coca-cola',0.50,40),(3,'Sousage',0.30,100)

INSERT INTO orderProduct VALUES (1,'Milk Happy',0.80,60),(2,'Coca-cola',0.50,40),(3,'Sausage',0.30,100),(4,'Crisps',1.60,600)

--1
MERGE warehouse AS Target USING orderProduct AS Source ON (Target.productId = Source.productId)
	WHEN MATCHED 
		THEN UPDATE SET productCount = Source.productCount
	WHEN NOT MATCHED
		THEN INSERT VALUES (Source.productId,Source.productName,Source.productPrice,Source.productCount)
OUTPUT deleted.*, $action, inserted.*;

--2
UPDATE orderProduct SET productPrice = 0.20 WHERE productId = 1

MERGE warehouse AS Target USING orderProduct AS Source ON (Target.productId = Source.productId)
	WHEN MATCHED AND Target.productPrice = Source.productPrice OR Target.productPrice = 0
		THEN UPDATE SET productCount = Source.productCount  + Source.productCount, Target.productPrice = Source.productPrice
	WHEN NOT MATCHED
		THEN INSERT VALUES (Source.productId,Source.productName,Source.productPrice,Source.productCount)
OUTPUT deleted.*, $action, inserted.*;


SELECT * FROM warehouse

SELECT * FROM orderProduct