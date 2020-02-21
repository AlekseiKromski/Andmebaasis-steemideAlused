USE WholeSale

GO
	DECLARE @cust_id AS VARCHAR(5), @orderdate_from AS DATE, @orederdate_to AS DATE
		SET @cust_id = 'HANAR' 
		SET @orderdate_from = '1998-04-01' 
		SET @orederdate_to = '1998-07-01' 

	SELECT OrderId, CustomerID, OrderDate FROM Orders WHERE CustomerID = @cust_id AND OrderDate >= @orderdate_from AND OrderDate < @orederdate_to
GO

GO
	CREATE PROC GetCustomerOrders1
	@cust_id AS VARCHAR(5), 
	@orderdate_from AS DATE = '1998-04-01',
	@orederdate_to AS DATE = '1998-07-01'
	AS
		BEGIN
			SELECT OrderId, CustomerID, OrderDate FROM Orders WHERE CustomerID = @cust_id AND OrderDate >= @orderdate_from AND OrderDate < @orederdate_to
		END
GO

EXEC GetCustomerOrders1 'HANAR'

GO
	BEGIN
		IF OBJECT_ID('GetCustomerOrders1', 'P') IS NOT NULL 
			BEGIN
				PRINT 'OK'
			END
	END
GO

GO
	CREATE PROC GetCustomerOrders2
	@cust_id VARCHAR(5), 
	@orderdate_from DATE = '1998-04-01',
	@orederdate_to DATE = '1998-07-01',
	@numrows INT = 0 OUTPUT
	AS
		BEGIN
			SET NOCOUNT ON;
				SELECT OrderId, CustomerID, OrderDate FROM Orders WHERE CustomerID = @cust_id AND OrderDate >= @orderdate_from AND OrderDate < @orederdate_to
			SET @numrows = @@ROWCOUNT
		END
GO

GO
	DECLARE @rowreturned AS INT
	EXEC GetCustomerOrders2 'HANAR',
	'1998-04-01',
	'1998-07-01',
	@rowreturned OUTPUT;
	SELECT @rowreturned
GO

use smpl_AlekseiKromski
GO
	CREATE PROCEDURE modify_empno (@old_no INTEGER, @new_no INTEGER) AS UPDATE employee SET emp_no = @new_no WHERE emp_no = @old_no
	UPDATE works_on SET emp_no = @new_no WHERE emp_no = @old_no
GO

EXEC modify_empno '2581', '7777'