--Create test data
IF OBJECT_ID('dbo.TestPivot') IS NOT NULL
	DROP TABLE dbo.TestPivot


CREATE TABLE dbo.TestPivot
(
Distributor VARCHAR(20),
TransactionDate DATE,
TransactionType VARCHAR(20),
TotalTransactions INTEGER,
SumTransactions INTEGER
);
GO


INSERT INTO dbo.TestPivot VALUES
('ACE','2019-01-01','ATM',1,1),
('ACE','2019-01-02','ATM',2,2),
('ACE','2019-01-03','ATM',3,3),
('ACE','2019-01-04','ATM',4,4),
-----
('ACE','2019-01-01','Signature',5,5),
('ACE','2019-01-03','Signature',6,6),
('ACE','2019-01-04','Signature',7,7),
('ACE','2019-01-05','Signature',8,8),
-----
('IniTech','2019-01-01','ATM',1,1),
('IniTech','2019-01-02','ATM',2,2),
('IniTech','2019-01-03','ATM',3,3),
('IniTech','2019-01-04','ATM',4,4),
-----
('IniTech','2019-01-01','Signature',5,5),
('IniTech','2019-01-03','Signature',6,6),
('IniTech','2019-01-04','Signature',7,7),
('IniTech','2019-01-05','Signature',8,8)

GO


 
-------------------------------------------------------------
-------------------------------------------------------------
-------------------------------------------------------------
--Create a data dictionary using the pivot
SELECT	c.Name AS SchemaName, b.Name AS TableName, a.Name AS ColumnName, d.Name AS DataType
INTO	##DataDictionary
FROM	sys.Columns a INNER JOIN 
		sys.Tables b on a.object_id = b.object_id INNER JOIN 
		sys.Schemas c on b.schema_id = c.schema_id INNER JOIN 
		sys.Types d on a.user_type_id = d.user_type_id
WHERE b.[Name] = 'TestPivot';


--Pivot the data
EXEC dbo.SpPivotData
  @vQuery    = 'SELECT SchemaName, TableName, ColumnName, DataType FROM ##DataDictionary',
  @vOnRows  =  'SchemaName, TableName, ColumnName',
  @vOnColumns  = 'DataType',
  @vAggFunction = 'COUNT',
  @vAggColumns  = '*';


--Number of datatypes by table
EXEC dbo.SpPivotData
  @vQuery    = 'SELECT TableName, DataType, COUNT(*) AS NumberOfDataTypes FROM ##DataDictionary GROUP BY TableName, DataType',
  @vOnRows  = 'TableName',
  @vOnColumns  = 'DataType',
  @vAggFunction = 'SUM',
  @vAggColumns  = 'NumberOfDataTypes';


-------------------------------------------------------------
-------------------------------------------------------------
-------------------------------------------------------------
--Pivot by TransactionType
EXEC dbo.SpPivotData
  @vQuery    = 'dbo.TestPivot',
  @vOnRows  = 'TransactionType',
  @vOnColumns  = 'TransactionDate',
  @vAggFunction = 'SUM',
  @vAggColumns  = 'TotalTransactions';

--Pivot by Distributor and TransactionType
EXEC dbo.SpPivotData
  @vQuery    = 'dbo.TestPivot',
  @vOnRows  = 'Distributor, TransactionType',
  @vOnColumns  = 'TransactionDate',
  @vAggFunction = 'SUM',
  @vAggColumns  = 'TotalTransactions';


--Maximum Avg per day
EXEC dbo.SpPivotData
  @vQuery    = 'dbo.TestPivot',
  @vOnRows  = 'TransactionType',
  @vOnColumns  = 'TransactionDate',
  @vAggFunction = 'MAX',
  @vAggColumns  = 'SumTransactions/TotalTransactions';


