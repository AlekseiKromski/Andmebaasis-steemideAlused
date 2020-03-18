use	 sampleDP

SELECT * FROM sys.system_objects

SELECT * FROM sys.columns

SELECT * FROM sys.database_principals

SELECT object_id, principal_id, type FROM sys.objects WHERE name = 'employee'

SELECT sys.objects.name FROM sys.objects INNER JOIN
sys.columns ON sys.objects.object_id = sys.columns.object_id
WHERE sys.objects.type = 'U' AND sys.columns.name = 'project_no'

SELECT sys.database_principals.name FROM sys.database_principals
INNER JOIN sys.objects ON sys.database_principals.principal_id =
sys.objects.schema_id
WHERE sys.objects.name = 'employee' AND sys.objects.type = 'U'

EXEC sp_configure 'show advanced options', 1
RECONFIGURE WITH OVERRIDE
EXEC sp_configure 'fill factor', 100
RECONFIGURE WITH OVERRIDE

sp_help 'employee'

SELECT OBJECT_ID FROM sys.objects where name = 'employee'

SELECT object_id('employee')

GO
	IF OBJECTPROPERTY(object_id('dbo.employee'), 'IsTable') = 1
		PRINT 'This is a table'
	ELSE IF OBJECTPROPERTY(object_id('dbo.employee'), 'IsTable') = 0
		PRINT 'This is not a table'
	ELSE IF OBJECTPROPERTY(object_id('dbo.employee'), 'IsTable') IS NULL
		PRINT 'ERROR: this is mot a valid object'
GO