/*----------------------------------------
Scott Peters
https://advancedsqlpuzzles.com
Creating a Calendar Table Example Usage

Principal Architecture Modernization:
- Idempotent schema creation (DROP TABLE IF EXISTS).
- High-performance set-based tally table population (eliminating procedural WHILE loop).
- CREATE OR ALTER VIEW for idempotent view deployment.
*/----------------------------------------

DROP TABLE IF EXISTS dbo.CalendarDays;
GO

CREATE TABLE dbo.CalendarDays
(
    DateKey INT NOT NULL PRIMARY KEY,
    CalendarDate DATE NOT NULL
);
GO

-----------------------------------------------------
-- Populate the CalendarTable (Set-Based Tally Table Generator)
DECLARE @vStartDate DATE = '2020-01-01';
DECLARE @vEndDate   DATE = '2030-12-31';

WITH Tally(N) AS
(
    SELECT TOP (DATEDIFF(DAY, @vStartDate, @vEndDate) + 1)
        ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) - 1
    FROM sys.all_objects a
    CROSS JOIN sys.all_objects b
)
INSERT INTO dbo.CalendarDays (DateKey, CalendarDate)
SELECT 
    CONVERT(INT, CONVERT(VARCHAR(8), DATEADD(DAY, N, @vStartDate), 112)) AS DateKey,
    DATEADD(DAY, N, @vStartDate) AS CalendarDate
FROM Tally;
GO

-- Basic usage with CROSS APPLY
SELECT  ct.*
FROM    dbo.CalendarDays cd 
CROSS APPLY dbo.FnReturnCalendarTable(cd.CalendarDate) ct;
GO

-- Create or Alter the View for seamless enterprise consumption
CREATE OR ALTER VIEW dbo.VwCalendarTable AS
SELECT  ct.*
FROM    dbo.CalendarDays cd 
CROSS APPLY dbo.FnReturnCalendarTable(cd.CalendarDate) ct;
GO

-- Query the Calendar View
SELECT * FROM dbo.VwCalendarTable;
GO
