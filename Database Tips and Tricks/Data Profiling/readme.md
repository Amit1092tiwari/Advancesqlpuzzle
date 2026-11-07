# Automated Data Profiling in SQL Server

Author: **Scott Peters** | [https://advancedsqlpuzzles.com](https://advancedsqlpuzzles.com)

A robust, enterprise-grade T-SQL data profiling script designed to inspect table schemas, analyze data distributions, detect data quality defects, and discover column anomalies.

---

## Overview

Data profiling is the foundational process of examining source data to evaluate quality, understand schema structures, and capture statistical distributions.

Before embarking on data migration, ETL/ELT pipeline authoring, or analytical modeling, data profiling identifies hidden pitfalls:
- Hidden carriage returns, line feeds, tabs, or commas in text columns that break delimited exports (CSV/TSV).
- Columns dominated by `NULL` values or empty strings.
- Outlier min/max string lengths and numeric boundaries.
- Leading or trailing whitespaces that cause failed joins or broken equality constraints.
- Candidate primary keys, foreign keys, and functional dependencies.

---

## Implementation Files

| File | Description |
|:---|:---|
| [`Data Profiling.sql`](file:///c:/Users/amitt/Documents/github/Advancesqlpuzzle/Database%20Tips%20and%20Tricks/Data%20Profiling/Data%20Profiling.sql) | The complete, dynamic T-SQL data profiling script. |

---

## What the Data Profiling Script Analyzes

The script evaluates target tables across multiple critical dimensions:

| Profile Metric | Description / Diagnostic Purpose |
|:---|:---|
| `ColumnName` & `DataType` | Column schema name, physical type, max length, and ordinal position. |
| `RowCount` | Total records in the table. |
| `NullCount` & `NullPercentage` | Count and percentage of `NULL` records to assess column population. |
| `DistinctValuesCount` | Cardinality of the column to identify candidates for uniqueness or indexes. |
| `BlankCount` | Detects zero-length empty strings (`''`) or whitespace-only records. |
| `LeadingTrailingSpaces` | Identifies dirty strings with un-trimmed spaces causing join failures. |
| `MinLength` & `MaxLength` | Minimum and maximum character lengths of string values. |
| `MinValue` & `MaxValue` | Boundary inspection to detect domain violations or sentinel values (e.g. `9999-12-31`). |
| `ContainsTabs` | Flags columns containing `CHAR(9)` (Tab) characters. |
| `ContainsLineFeeds` | Flags columns containing `CHAR(10)` or `CHAR(13)` (LF/CR). |
| `ContainsCommas` | Flags columns with embedded commas (`','`) that disrupt CSV ingestion pipelines. |
| `SampleValues` | Captures representative sample values for exploratory inspection. |

---

## How to Execute the Script

1. Open [`Data Profiling.sql`](file:///c:/Users/amitt/Documents/github/Advancesqlpuzzle/Database%20Tips%20and%20Tricks/Data%20Profiling/Data%20Profiling.sql) in SQL Server Management Studio (SSMS), Azure Data Studio, or VS Code.
2. Configure the target table and schema variables at the top of the script:
   ```sql
   DECLARE @vSchemaName VARCHAR(128) = 'dbo';
   DECLARE @vTableName  VARCHAR(128) = 'YourTableNameHere';
   ```
3. Execute the script (`F5`).
4. Review the structured output grid containing comprehensive column-level profiling metrics.

---

## Strategic Value of Data Profiling

- **Assess Data Quality:** Verify adherence to domain constraints and format standards before ingestion.
- **Risk Mitigation for Integrations:** Uncover unexpected multi-byte characters, delimiters, or nullability that break foreign key joins.
- **Enterprise Governance & MDM:** Supports Master Data Management (MDM) by providing an accurate inventory of data shapes and data completeness across systems.
- **Avoid Costly Late-Stage Rework:** Catching data defects during initial profiling eliminates late-stage production pipeline debugging and costly hotfixes.
