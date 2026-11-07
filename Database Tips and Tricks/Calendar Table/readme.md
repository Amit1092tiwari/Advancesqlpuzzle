# Creating a Calendar Table via Table-Valued Function

Author: **Scott Peters** | [https://advancedsqlpuzzles.com](https://advancedsqlpuzzles.com)

A high-performance technique for generating and querying calendar dimensions in Microsoft SQL Server using an Inline Table-Valued Function (iTVF) and parameterized views.

---

## Overview

A calendar table (or date dimension table) is a foundational asset in relational databases and data warehouses. It enables performant time-series analysis, simplifies fiscal year and holiday calculations, and avoids messy date math across queries.

While traditional implementations rely on pre-populated physical tables or slow procedural `WHILE` loops, this implementation leverages an **Inline Table-Valued Function (iTVF)**. 

### Why Use a Table-Valued Function?
- **Parameterized Views:** iTVFs act as parameterized views that can be queried directly in the `FROM` clause or combined with existing tables via `CROSS APPLY` and `OUTER APPLY`.
- **Query Optimizer Inlining:** Unlike Multi-Statement TVFs (MSTVFs) or stored procedures, SQL Server inlines iTVFs directly into the query execution plan, unlocking full index usage and parallel execution.
- **Dynamic Date Ranges:** Generate date dimensions on demand for any historical or future date span without disk storage overhead.

---

## Implementation Files

| File | Description |
|:---|:---|
| [`FnReturnCalendarTable.sql`](file:///c:/Users/amitt/Documents/github/Advancesqlpuzzle/Database%20Tips%20and%20Tricks/Calendar%20Table/FnReturnCalendarTable.sql) | Source code defining the `FnReturnCalendarTable` inline table-valued function. |
| [`FnReturnCalendarTable Example Use.sql`](file:///c:/Users/amitt/Documents/github/Advancesqlpuzzle/Database%20Tips%20and%20Tricks/Calendar%20Table/FnReturnCalendarTable%20Example%20Use.sql) | Usage patterns: standalone queries, persistent table population, views, and `CROSS APPLY` joins. |

---

## Calendar Function Columns & Attributes

The function generates comprehensive temporal attributes for every date in the requested range:

| Attribute | Data Type | Description |
|:---|:---|:---|
| `CalendarDate` | `DATE` | Calendar date (Primary Key candidate) |
| `CalendarYear` | `INT` | 4-digit calendar year (e.g. 2026) |
| `CalendarMonth` | `INT` | Month number (1 - 12) |
| `CalendarDay` | `INT` | Day of the month (1 - 31) |
| `DayOfWeekNumber` | `INT` | Day of the week (deterministic, `DATEFIRST`-independent) |
| `DayOfWeekName` | `VARCHAR(30)`| Full name of the day (`Monday`, `Tuesday`, etc.) |
| `DayOfWeekAbbreviation` | `CHAR(3)` | 3-letter abbreviation (`Mon`, `Tue`, etc.) |
| `DayOfYearNumber` | `INT` | Day of the year (1 - 366) |
| `WeekOfYearNumber` | `INT` | ISO week number of the year |
| `CalendarQuarter` | `INT` | Calendar quarter (1 - 4) |
| `IsWeekend` | `BIT` | `1` for Saturday/Sunday, `0` for weekdays |
| `IsLeapYear` | `BIT` | `1` if the year is a Gregorian leap year, else `0` |

---

## Usage Examples

### 1. Generating a Date Range for the Current Year
```sql
SELECT *
FROM   dbo.FnReturnCalendarTable('2026-01-01', '2026-12-31')
ORDER BY CalendarDate;
```

### 2. Passing Dynamic / Expression Dates
```sql
-- Generate 365 days starting from today
SELECT *
FROM   dbo.FnReturnCalendarTable(CAST(GETDATE() AS DATE), DATEADD(YEAR, 1, CAST(GETDATE() AS DATE)))
ORDER BY CalendarDate;
```

### 3. Joining to Business Tables with `CROSS APPLY`
When you need to evaluate or backfill dates against transactional records:
```sql
SELECT o.OrderID,
       o.OrderDate,
       c.DayOfWeekName,
       c.IsWeekend
FROM   Sales.Orders o
CROSS APPLY dbo.FnReturnCalendarTable(o.OrderDate, o.OrderDate) c;
```

### 4. Creating a Permanent Calendar Dimension View
To create a standard corporate view covering a 100-year horizon:
```sql
CREATE OR ALTER VIEW dbo.VwCalendarTable AS
SELECT *
FROM   dbo.FnReturnCalendarTable('1950-01-01', '2050-12-31');
GO
```

---

## Architectural & Performance Notes
1. **Set-Based Tally CTE:** The underlying implementation uses a set-based tally generator (Cross-joined CTEs) producing numbers without procedural loops or physical I/O.
2. **Leap Year Century Rule:** Gregorian leap years require century years (`YYYY % 100 = 0`) to be divisible by 400 (`YYYY % 400 = 0`). This implementation strictly enforces the 400-year rule.
3. **Deterministic Day of Week:** Uses standard integer offsets to ensure results remain deterministic regardless of session `SET DATEFIRST` or collation settings.
