# Dynamic Data Pivoting in SQL Server

Author: **Scott Peters** | [https://advancedsqlpuzzles.com](https://advancedsqlpuzzles.com)

A robust, injection-safe dynamic pivoting stored procedure for SQL Server that eliminates the cumbersome static syntax of native `PIVOT`.

---

## Overview

The native T-SQL `PIVOT` relational operator is a powerful tool for reshaping normalized row-level data into cross-tabular reports. However, native `PIVOT` has severe limitations in day-to-day data engineering:
1. **Hardcoded Column Values:** Standard `PIVOT` requires all distinct column header values to be explicitly hardcoded inside `IN ([Val1], [Val2], ...)`.
2. **Maintenance Overhead:** When new categories or periods appear in the data, the query breaks or excludes the new values unless manually updated.
3. **Complex Syntax:** Writing and debugging native `PIVOT` statements is unintuitive and time-consuming.

`SpPivotData` solves this problem by encapsulating dynamic column generation, XML decoding, and aggregate pivoting inside a clean, reusable stored procedure.

---

## Implementation Files

| File | Description |
|:---|:---|
| [`SpPivotData.sql`](file:///c:/Users/amitt/Documents/github/Advancesqlpuzzle/Database%20Tips%20and%20Tricks/Pivoting%20Data/SpPivotData.sql) | Stored procedure definition implementing secure dynamic SQL pivoting with `QUOTENAME()` escaping and aggregate whitelisting. |
| [`Pivot Data Examples.sql`](file:///c:/Users/amitt/Documents/github/Advancesqlpuzzle/Database%20Tips%20and%20Tricks/Pivoting%20Data/Pivot%20Data%20Examples.sql) | Comprehensive example scripts illustrating multi-column row pivots, custom aggregations, and edge cases. |

---

## Stored Procedure Parameters

```sql
EXEC dbo.SpPivotData
    @vQuery         = 'Source table, view, or subquery expression',
    @vOnRows        = 'Comma-separated list of grouping/row-identifier columns',
    @vOnColumns     = 'Column whose distinct values become new column headers',
    @vAggFunction   = 'Aggregate function: COUNT, SUM, AVG, MIN, or MAX',
    @vAggColumns    = 'Column expression to aggregate (e.g. TotalAmount or *)';
```

### Parameter Reference

| Parameter | Type | Required | Description |
|:---|:---|:---|:---|
| `@vQuery` | `NVARCHAR(MAX)` | Yes | Target table name, schema-qualified view, or inner query. |
| `@vOnRows` | `NVARCHAR(MAX)` | Yes | Columns to group by (e.g., `DepartmentID, Year`). |
| `@vOnColumns` | `NVARCHAR(MAX)` | Yes | Column providing header labels (e.g., `Quarter`, `Region`). |
| `@vAggFunction` | `NVARCHAR(20)` | Yes | Aggregate function (`COUNT`, `SUM`, `AVG`, `MIN`, `MAX`). |
| `@vAggColumns` | `NVARCHAR(MAX)` | Yes | Measure column to calculate (e.g., `SalesAmount`). |

---

## Usage Examples

### 1. Pivoting System Tables
Quickly count tables grouped by schema and name:
```sql
EXEC dbo.SpPivotData
    @vQuery       = 'sys.tables',
    @vOnRows      = 'schema_id',
    @vOnColumns   = 'type_desc',
    @vAggFunction = 'COUNT',
    @vAggColumns  = '*';
```

### 2. Pivoting Sales by Region and Quarter
```sql
EXEC dbo.SpPivotData
    @vQuery       = 'Sales.SalesSummary',
    @vOnRows      = 'SalesYear, SalesPersonID',
    @vOnColumns   = 'QuarterName',
    @vAggFunction = 'SUM',
    @vAggColumns  = 'Revenue';
```

---

## Architectural & Security Highlights
- **SQL Injection Defense:** Uses `QUOTENAME()` on all dynamically parsed column names and validates `@vAggFunction` against a strict whitelist of ANSI aggregate functions.
- **Dynamic XML Header Extraction:** Employs `FOR XML PATH(''), TYPE` and `.value('.', 'NVARCHAR(MAX)')` to properly generate distinct column headers and decode XML entities (like `&`, `<`, `>`).
- **Exploratory Data Analysis (EDA):** Generates pivot tables directly inside SQL without requiring exports to Excel, Python, or R.
