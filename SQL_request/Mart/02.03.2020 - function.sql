USE WholeSale

SELECT * FROM Products

GO
CREATE FUNCTION productName(@ProductID INT)
	RETURNS NVARCHAR(40)
	AS 
	BEGIN
		DECLARE @productName NVARCHAR(40)
		SELECT @productName = ProductName FROM Products WHERE ProductID = @ProductID
		RETURN @productName
	END
GO

SELECT dbo.productName(30)

SELECT *,dbo.productName(ProductID) FROM OrderDetails

--Работа с категориями
SELECT * FROM Categories
SELECT * FROM Products

SELECT ProductID,ProductName, Categories.CategoryID, Categories.CategoryName, UnitPrice FROM Products INNER JOIN Categories 
ON Products.CategoryID = Categories.CategoryID

--Функция с возвращением таблицы
GO

CREATE FUNCTION ProdCat(@categoryID INT)
	RETURNS TABLE
	AS
	RETURN
		SELECT ProductID,ProductName, Categories.CategoryID, Categories.CategoryName, UnitPrice FROM Products INNER JOIN Categories 
		ON Products.CategoryID = Categories.CategoryID WHERE Categories.CategoryID = @categoryID
GO

--========================================================================

USE sample_AlekseiKromski


SELECT * FROM project

GO
	CREATE TABLE audit_budget(project_no CHAR(4) NULL, 
	user_name CHAR(16) NULL,
	date DATETIME NULL,
	budget_old FLOAT NULL,
	budget_new FLOAT NULL
	)
GO

CREATE TRIGGER modify_budget ON project AFTER UPDATE AS
	IF UPDATE(budget)
		BEGIN
			DECLARE @budget_old FLOAT
			DECLARE @budget_new FLOAT
			DECLARE @project_number CHAR(4)
			SELECT @budget_old = (SELECT budget FROM deleted)
			SELECT @budget_new = (SELECT budget FROM inserted)
			SELECT @project_number = (SELECT project_no FROM deleted)
			INSERT INTO audit_budget VALUES (@project_number, USER_NAME(), GETDATE(),@budget_old,@budget_new)
		END

UPDATE project SET budget = 15000000 WHERE project_no = 'p1'

SELECT * FROM audit_budget

CREATE TRIGGER total_budget ON project AFTER UPDATE 
	AS IF UPDATE (budget)
	BEGIN
		DECLARE @sum_old1 FLOAT	
		DECLARE @sum_old2 FLOAT	
		DECLARE @sum_new FLOAT	
		SELECT @sum_new = (SELECT SUM(budget) FROM inserted)
		SELECT @sum_old1 = (
			SELECT SUM(p.budget) FROM project p WHERE p.project_no NOT IN (SELECT d.project_no FROM deleted d)
		)
		SELECT @sum_old2 = (SELECT SUM(budget) FROM deleted)
		if @sum_new > (@sum_old1 + @sum_old2)*1.5
			BEGIN
				PRINT 'No modification of budgets'
				ROLLBACK TRANSACTION
			END
	ELSE
		PRINT 'The modification of budget executed'
	END


SELECT * FROM project

UPDATE project SET budget = 10 WHERE project_no = 'p3'

CREATE TABLE AutitTestTable(
	Id INT IDENTITY(1,1) NOT NULL,
	DtChange DATETIME NOT NULL,
	UserName VARCHAR(100) NOT NULL,
	SQL_Command VARCHAR(100) NOT NULL,
	ProductId_Old INT NULL,
	ProductId_New INT NULL,
	CategoryId_Old INT NULL,
	CategoryId_New INT NULL,
	ProductName_Old VARCHAR(100) NULL,
	ProductName_New VARCHAR(100) NULL,
	Price_Old MONEY NULL,
	Price_New MONEY NULL,
	CONSTRAINT PK_AutitTestTable PRIMARY KEY (Id)
)CREATE TABLE TestTable(
	[ProductId] [INT] IDENTITY(1,1) NOT NULL,
	[CategoryId] [INT] NOT NULL,
	[ProductName] [VARCHAR](100) NOT NULL,
	[Price] [Money] NULL
)CREATE TRIGGER TRG_Audit_TestTable ON TestTable
	AFTER INSERT, UPDATE, DELETE
AS
BEGIN
	DECLARE @SQL_Command VARCHAR(100);
	/*
	Определяем, что это за операция
	на основе наличия записей в таблицах inserted и deleted.
	На практике, конечно же, лучше делать отдельный триггер для каждой операции
	*/
	IF EXISTS (SELECT * FROM inserted) AND NOT EXISTS (SELECT * FROM deleted)
		SET @SQL_Command = 'INSERT'
	IF EXISTS (SELECT * FROM inserted) AND EXISTS (SELECT * FROM deleted)
		SET @SQL_Command = 'UPDATE'
	IF NOT EXISTS (SELECT * FROM inserted) AND EXISTS (SELECT * FROM deleted)
		SET @SQL_Command = 'DELETE'
	-- Инструкция если происходит добавление или обновление записи
	IF @SQL_Command = 'UPDATE' OR @SQL_Command = 'INSERT'
	BEGIN
		INSERT INTO AutitTestTable(DtChange, UserName, SQL_Command, ProductId_Old,ProductId_New, CategoryId_Old, CategoryId_New,ProductName_Old, ProductName_New, Price_Old, Price_New)

		SELECT GETDATE(), SUSER_SNAME(), @SQL_Command, D.ProductId, I.ProductId,D.CategoryId, I.CategoryId, D.ProductName, I.ProductName, D.Price, I.Price FROM inserted I LEFT JOIN deleted D ON I.ProductId = D.ProductId
	END
	-- Инструкция если происходит удаление записи
	IF @SQL_Command = 'DELETE'
	BEGIN
		INSERT INTO AutitTestTable(DtChange, UserName, SQL_Command, ProductId_Old,
		ProductId_New, CategoryId_Old, CategoryId_New,
		ProductName_Old, ProductName_New, Price_Old, Price_New)

		SELECT GETDATE(), SUSER_SNAME(), @SQL_Command,
		 D.ProductId, NULL,
		 D.CategoryId, NULL,
		 D.ProductName, NULL,
		 D.Price, NULL
		FROM deleted D
	END
END

--Добавляем запись
INSERT INTO TestTable
VALUES (1, 'Новый товар', 0)
--Изменяем запись
UPDATE TestTable SET ProductName = 'Наименование товара',
Price = 200
WHERE ProductName = 'Новый товар'
--Удаляем запись
DELETE TestTable WHERE ProductName = 'Наименование товара'
--Смотрим изменения
SELECT * FROM AutitTestTable

--Включение/отключение триггера 
DISABLE TRIGGER TRG_Audit_TestTable ON TestTable;ENABLE TRIGGER TRG_Audit_TestTable ON TestTable;