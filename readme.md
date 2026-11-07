# Advanced SQL Puzzles & Enterprise Database Engineering

[![SQL Engine CI](https://github.com/Amit1092tiwari/Advancesqlpuzzle/actions/workflows/sql-ci.yml/badge.svg)](https://github.com/Amit1092tiwari/Advancesqlpuzzle/actions/workflows/sql-ci.yml)
[![Pages Deployment](https://github.com/Amit1092tiwari/Advancesqlpuzzle/actions/workflows/static.yml/badge.svg)](https://github.com/Amit1092tiwari/Advancesqlpuzzle/actions/workflows/static.yml)
[![Platform](https://img.shields.io/badge/Platform-Microsoft%20SQL%20Server%20%7C%20Azure%20SQL%20%7C%20Databricks-blue.svg)](https://azure.microsoft.com/)
[![Dialect](https://img.shields.io/badge/Dialect-T--SQL%20%7C%20ANSI--SQL-orange.svg)](#)
[![Puzzles](https://img.shields.io/badge/Puzzles-55%20Solved-brightgreen.svg)](#55-advanced-sql-puzzles-directory)

A comprehensive repository of **55 Advanced SQL Puzzles**, enterprise database utility routines, metadata profilers, technical papers on relational database internals, and Microsoft Azure cloud data engineering architectures.

All puzzle solutions and database routines are authored in **Microsoft SQL Server T-SQL** (compatible with SQL Server 2016–2022, Azure SQL Database, Azure Synapse, and adaptable to PostgreSQL, Snowflake, Databricks Spark SQL, and Google BigQuery).

---

## 🌐 Interactive Web Portal

This repository deploys an interactive, searchable portal via GitHub Pages:
👉 **[Launch Advanced SQL Puzzles Web Directory](https://amit1092tiwari.github.io/Advancesqlpuzzle/)**

---

## 📂 Repository Architecture

```text
Advancesqlpuzzle/
├── .github/
│   └── workflows/
│       ├── sql-ci.yml              # Ephemeral MSSQL 2022 container automated CI testing
│       └── static.yml              # GitHub Pages deployment pipeline
├── Advanced SQL Puzzles/
│   ├── Advanced SQL Puzzles DDL.sql        # Schemas and sample data for Puzzles #1 - #55
│   ├── Advanced SQL Puzzles Solutions.sql  # Multi-strategy solutions for Puzzles #1 - #55
│   ├── ADVANCED_SQL_PUZZLES.md             # Complete specifications for 55 puzzles + 11 bonus puzzles
│   └── readme.md
├── Database Tips and Tricks/
│   ├── Calendar Table/             # High-performance calendar dimension function (ITVF)
│   ├── Data Profiling/             # Table metadata, statistical distributions, & quality profiler
│   ├── Pivoting Data/              # SQL-injection safe dynamic PIVOT stored procedure
│   ├── Subtracting Two Dates/      # Nanosecond-precision interval difference routines
│   └── readme.md
├── Database Writings/
│   ├── Advanced SQL Joins/         # Mechanics of SQL joins & NULL handling (Markdown Guide + SQL)
│   ├── Behavior Of Nulls/          # Three-valued logic & boolean evaluation (Markdown Guide + SQL)
│   ├── Database Concepts And Components/ # Engine internals, storage, ACID, & indexing
│   └── readme.md
├── Microsoft Azure/
│   ├── Data Factory Metadata Demo/ # ADF metadata auditing & TVP ingestion pipeline
│   ├── Databricks Spark Hive Demo/ # Spark SQL, Hive metastore, & Delta Lake integration
│   └── readme.md
├── Multi-Dialect Solutions/        # Cross-engine guides (T-SQL, PostgreSQL, Snowflake, BigQuery, DuckDB)
│   ├── MULTI_DIALECT_GUIDE.md      # Paradigm analysis (Gaps & Islands, MATCH_RECOGNIZE, QUALIFY)
│   └── readme.md
├── .gitattributes                  # EOL normalization & binary tracking
├── index.html                      # Modern, searchable web landing page
└── readme.md                       # Main architectural documentation
```

---

## 🧩 55 Advanced SQL Puzzles Directory

The puzzles test deep problem-solving skills across complex relational algorithms:

| Category | Puzzle Numbers & Topics |
| :--- | :--- |
| **Hierarchies & Recursion** | **#2** Managers & Employees (Hierarchical Trees), **#11** Permutations, **#41** Associate IDs |
| **Gaps & Islands** | **#6** Workflow Steps, **#28** Fill the Gaps (LOCF), **#29** Count Groupings, **#47** Work Schedule |
| **Pivoting & Unpivoting** | **#5** Phone Directory, **#17** De-grouping, **#52** Phone Numbers Unpivot |
| **Relational Division & Sets** | **#1** Shopping Carts, **#7** Mission to Mars, **#9** Matching Sets, **#21** Table Differences, **#54** Winning Numbers, **#55** Table Audit (Single-pass FULL OUTER JOIN) |
| **Window Functions & Ranking** | **#4** Two Predicates, **#12** Average Days, **#24** Page Views, **#25** Top Vendors, **#26** Previous Year Sales, **#31** Second Highest, **#43** Unbounded Preceding, **#48** Consecutive Sales |
| **Temporal & SCD Modeling** | **#19** Back to the Future, **#44** Slowly Changing Dimension (SCD Type 2) Part I, **#45** SCD Part II |
| **Mathematics & Statistics** | **#10** Mean, Median, Mode & Range, **#36** Traveling Salesman, **#39** Prime Numbers Sieve, **#49** Sum of Hex Values |
| **Data Integrity & Logic** | **#3** Fiscal Year Table Constraints, **#8** Workflow Cases, **#13** Inventory Tracking, **#14** Indeterminate Logs, **#16** Reciprocals, **#18** Seating Chart, **#20** Price Points, **#27** Delete Duplicates, **#30** Select Star, **#32** First & Last, **#33** Deadlines, **#34** Specific Exclusion, **#35** Domestic vs International, **#37** Group Criteria, **#38** Reporting Elements, **#40** Sort Order, **#42** Mutual Friends, **#46** Positive Balances, **#50** Terms Clarification, **#51** Primary & Secondary Keys, **#53** Spouse Pairings |

---

## 🛠️ Enterprise Database Utilities (`Database Tips and Tricks`)

### 1. Deterministic Calendar Dimension Table (`FnReturnCalendarTable.sql`)
- Zero-overhead inline table-valued function generating full calendar attributes.
- Native string parsing (eliminates costly .NET CLR `FORMAT()` context switches).
- Full Gregorian leap year century calculation rule support.
- Weekday calculation independent of session-level `@@DATEFIRST` configuration.

### 2. SQL-Injection Hardened Dynamic PIVOT (`SpPivotData.sql`)
- Secure dynamic pivoting stored procedure utilizing `QUOTENAME()` on all identifiers.
- Strict input whitelisting for aggregate functions (`COUNT`, `SUM`, `AVG`, `MIN`, `MAX`).
- Automated XML entity decoding and clean column alias construction.

### 3. High-Precision Date Difference Engine (`FnDateDiffPartsTable.sql` & `FnDateDiffPartsChar.sql`)
- Precision down to the nanosecond (`DATETIME2(7)`).
- Refactored as an **Inline Table-Valued Function (ITVF)**, enabling query optimizer inlining, sub-query unrolling, and full engine parallelism.

### 4. Table Profiler & Metadata Analyzer (`Data Profiling.sql`)
- Comprehensive profiling script computing null percentages, zeros/blanks, distinct values, text length distributions, whitespace/newline flags, and numeric statistics (mean, stdev, sum).

---

## ☁️ Microsoft Azure Data Engineering Architectures

### 1. Azure Data Factory Metadata Ingestion Pattern
- Automated metadata harvesting (file size, MD5 hash, column counts, pipeline run IDs).
- Stored procedure ingestion via Table-Valued Parameters (TVP) for high-throughput batching.
- Right-sized enterprise schema data types (`BIGINT` for file sizes, `UNIQUEIDENTIFIER` for run GUIDs, `CHAR(32)` for MD5 hashes).

### 2. Databricks Spark & Hive Metastore Integration
- Classic Suppliers-Parts-Shipments relational design.
- Includes Databricks notebook workspace (`SuppliersAndParts.dbc`) and source SQL Server DDL (`SuppliersAndPartsDDL.sql`).

---

## 🚀 Getting Started

### Prerequisites
- **Microsoft SQL Server 2016+** / **Azure SQL Database** / **Azure SQL Managed Instance**
- **SQL Server Management Studio (SSMS)**, **Azure Data Studio**, or the `sqlcmd` utility.

### Running Puzzles Locally
1. Clone the repository:
   ```bash
   git clone https://github.com/Amit1092tiwari/Advancesqlpuzzle.git
   cd Advancesqlpuzzle
   ```
2. Open `Advanced SQL Puzzles/Advanced SQL Puzzles DDL.sql` in SSMS or Azure Data Studio and execute the script to create the temporary tables and sample data.
3. Open `Advanced SQL Puzzles/Advanced SQL Puzzles Solutions.sql` to inspect and execute the solution queries.

---

## 🤖 Continuous Integration & Verification

The repository includes a GitHub Actions CI pipeline (`.github/workflows/sql-ci.yml`) that spins up an ephemeral **Microsoft SQL Server 2022** Linux container (`mcr.microsoft.com/mssql/server:2022-latest`) to validate:
- DDL compilation and syntax correctness.
- Utility function and stored procedure creation (`CREATE OR ALTER`).
- Integrity of all SQL puzzle schemas and seed data.

---

## 📄 License & Attribution

- Puzzles and original database concepts by **Scott Peters** ([advancedsqlpuzzles.com](https://advancedsqlpuzzles.com)).
- Architectural refactorings, security hardening, CI/CD verification pipelines, and web directory maintained by **Amitkumar Tiwari**.
