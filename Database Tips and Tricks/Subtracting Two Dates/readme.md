# High-Precision Date Subtraction in SQL Server

Author: **Scott Peters** | [https://advancedsqlpuzzles.com](https://advancedsqlpuzzles.com)

High-precision T-SQL functions that calculate the exact granular breakdown of years, months, days, hours, minutes, seconds, and nanoseconds between any two timestamps.

---

## Overview

The native SQL Server `DATEDIFF()` function only measures boundary crossings rather than completed intervals of time:
- `DATEDIFF(YEAR, '2025-12-31 23:59:59', '2026-01-01 00:00:00')` returns `1`, even though only **1 second** has elapsed.
- `DATEDIFF(MONTH, '2026-01-31', '2026-02-01')` returns `1`, even though only **1 day** has elapsed.

Furthermore, `DATEDIFF()` cannot break down a duration into a composite representation (e.g. "5 years, 10 months, 28 days, 23 hours, 59 minutes, 59 seconds").

To solve this limitation, two complementary functions are provided:
1. **`FnDateDiffPartsTable`**: An **Inline Table-Valued Function (iTVF)** that returns the decomposed duration as individual numeric columns.
2. **`FnDateDiffPartsChar`**: A scalar function that formats the duration into a clean, human-readable string (e.g. `5y 10m 28d 23h 59m 59s 889000100n`).

---

## Implementation Files

| File | Type | Description |
|:---|:---|:---|
| [`FnDateDiffPartsTable.sql`](file:///c:/Users/amitt/Documents/github/Advancesqlpuzzle/Database%20Tips%20and%20Tricks/Subtracting%20Two%20Dates/FnDateDiffPartsTable.sql) | Inline Table-Valued Function (iTVF) | Computes years, months, days, hours, minutes, seconds, and nanoseconds as integer/bigint columns. Enables query plan inlining and `CROSS APPLY` parallelism. |
| [`FnDateDiffPartsChar.sql`](file:///c:/Users/amitt/Documents/github/Advancesqlpuzzle/Database%20Tips%20and%20Tricks/Subtracting%20Two%20Dates/FnDateDiffPartsChar.sql) | Scalar Function | Formats the calculated difference into a compact string representation (`Xy Xm Xd Xh Xm Xs Xn`). Returns `'0s'` on identical timestamps. |

---

## Function Specifications

### 1. `FnDateDiffPartsTable` (iTVF)

#### Syntax
```sql
SELECT *
FROM dbo.FnDateDiffPartsTable(@StartDate, @EndDate);
```

#### Output Columns
| Column | Data Type | Description |
|:---|:---|:---|
| `YearDifference` | `INT` | Total completed calendar years |
| `MonthDifference` | `INT` | Total completed months (0 - 11) |
| `DayDifference` | `INT` | Total completed days (0 - 30) |
| `HourDifference` | `INT` | Total completed hours (0 - 23) |
| `MinuteDifference` | `INT` | Total completed minutes (0 - 59) |
| `SecondDifference` | `INT` | Total completed seconds (0 - 59) |
| `NanoDifference` | `BIGINT` | Remaining nanoseconds (0 - 999,999,999) |

---

### 2. `FnDateDiffPartsChar` (Scalar)

#### Syntax
```sql
SELECT dbo.FnDateDiffPartsChar(@StartDate, @EndDate) AS DateDifference;
```

#### Output
A formatted `VARCHAR(100)` string:
```text
5y 10m 28d 23h 59m 59s 889000100n
```

---

## Usage Examples

### Standalone Function Invocations
```sql
-- Scalar format
SELECT dbo.FnDateDiffPartsChar('20110619 00:00:00.1110000', '20170518 00:00:00.0000001') AS DateDifference;
-- Output: 5y 10m 28d 23h 59m 59s 889000100n

-- Table format
SELECT *
FROM   dbo.FnDateDiffPartsTable('20110619 00:00:00.1110000', '20170518 00:00:00.0000001');
```

### Table Join with `CROSS APPLY`
Combine both functions in a single query across table rows:
```sql
-- Sample transaction dates
DROP TABLE IF EXISTS #ExampleDateTimes;
SELECT CONVERT(DATETIME2, '2017-08-25 22:56:43.0000000') AS StartDate,
       CONVERT(DATETIME2, '2020-12-01 02:11:01.5000000') AS EndDate
INTO   #ExampleDateTimes;

SELECT a.StartDate,
       a.EndDate,
       diff.YearDifference,
       diff.MonthDifference,
       diff.DayDifference,
       diff.HourDifference,
       diff.MinuteDifference,
       diff.SecondDifference,
       dbo.FnDateDiffPartsChar(a.StartDate, a.EndDate) AS FormattedDuration
FROM   #ExampleDateTimes a
CROSS APPLY dbo.FnDateDiffPartsTable(a.StartDate, a.EndDate) diff;
```

---

## Performance & Optimization Notes
- **Order-Agnostic Comparison:** Both functions automatically order inputs such that the earlier timestamp is subtracted from the later timestamp, preventing negative duration errors.
- **Inline Table-Valued Function (iTVF):** `FnDateDiffPartsTable` is written as a single set-based inline query. The SQL Server query optimizer inlines it into the outer plan without context switching, enabling index seeks and parallel scan execution.
- **Zero-Duration Boundary:** When identical dates are supplied, `FnDateDiffPartsChar` safely outputs `'0s'`.
