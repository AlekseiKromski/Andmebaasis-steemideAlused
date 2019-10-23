USE WholeSale

--1
--SELECT * FROM Customers WHERE Country = 'Canada'

--2
--SELECT * FROM Customers WHERE PostalCode = '1010' OR PostalCode= '8010'

--3
--SELECT * FROM Customers WHERE Fax is NULL

--4
--SELECT * FROM Customers WHERE Region is not NULL

--5
--SELECT * FROM Customers WHERE Region is NULL and Fax is NULL

--6
--SELECT * FROM Customers WHERE Phone LIKE '%555%'

--7
--SELECT * FROM Customers WHERE ContactTitle = 'owner' AND Country = 'Mexico' or Country = 'USA'

--8
--SELECT * FROM Customers WHERE ContactName LIKE '%Sven%'

--9
--SELECT Country FROM Customers

--10
--SELECT * FROM Customers WHERE CustomerID LIKE 'B%'

--11
--SELECT * FROM Customers WHERE CustomerID NOT LIKE '%A%B'

--12
--SELECT * FROM Customers WHERE ContactTitle LIKE '%sales%'

--13
--SELECT * FROM Customers WHERE ContactTitle LIKE '%manager%'

--14
--SELECT * FROM Customers WHERE City LIKE '% % %'

--15
--SELECT * FROM Orders WHERE OrderDate LIKE '%1996%'

--16
--SELECT * FROM Orders WHERE OrderDate BETWEEN '1997-08-01' AND '1997-08-30'

--17
--SELECT * FROM Orders WHERE OrderDate LIKE '%1997%' AND CustomerID = 'GREAL'

--18
--SELECT * FROM Products WHERE UnitPrice > 50 AND UnitsInStock < 5

--19 
--SELECT *,UnitsInStock * UnitPrice  AS summ_tovar FROM Products

--20 
--SELECT top 4 * FROM Orders 
