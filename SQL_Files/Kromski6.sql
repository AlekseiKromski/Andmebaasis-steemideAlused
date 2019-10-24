USE WholeSale

SELECT YEAR(OrderDate) AS aasta, COUNT(*) AS zakazi FROM Orders WHERE YEAR(OrderDate) = '1996' GROUP BY YEAR(OrderDate)

SELECT ShipCountry, COUNT(ShipCountry) AS Dostavki FROM Orders GROUP BY ShipCountry

SELECT TOP(7) OrderID, CustomerID, ShipCountry, Freight FROM Orders ORDER BY Freight DESC

SELECT MAX(EmployeeID) AS maksimum_zakaz FROM Orders

SELECT COUNT(*) - COUNT(ShippedDate) AS ei_oli_shippedDate FROM Orders

SELECT TOP(15) CustomerID,EmployeeID FROM Orders ORDER BY EmployeeID

SELECT ShipCountry, ShipCity FROM Orders GROUP BY ShipCountry, ShipCity HAVING  COUNT(CustomerID) >= 2

SELECT CategoryID,COUNT(ProductName) as count_tovar FROM Products GROUP BY CategoryID

SELECT CategoryID,COUNT(ProductName) as count_tovar FROM Products GROUP BY CategoryID

SELECT CategoryID,SUM(UnitPrice * UnitsInStock)  as count_tovar FROM Products GROUP BY CategoryID

SELECT * FROM Orders





