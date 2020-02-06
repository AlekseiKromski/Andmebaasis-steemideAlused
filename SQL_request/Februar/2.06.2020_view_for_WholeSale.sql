USE WholeSale

GO
CREATE VIEW report AS
SELECT Customers.CustomerID, SUM(OrderDetails.Quantity) AS quantity, SUM(OrderDetails.UnitPrice * OrderDetails.Quantity) AS summa, Shippers.CompanyName AS ship, YEAR(Orders.ShippedDate) AS shipYear FROM Orders 
	INNER JOIN Customers ON Customers.CustomerID = Orders.CustomerID
	INNER JOIN Shippers ON Orders.ShipVia = Shippers.ShipperID
	INNER JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID
	GROUP BY Customers.CustomerID, YEAR(Orders.ShippedDate), Shippers.CompanyName
GO

SELECT * FROM report