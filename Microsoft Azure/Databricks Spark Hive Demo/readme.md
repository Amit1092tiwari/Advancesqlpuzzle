# Azure Databricks, PySpark & Delta Lake (Hive) Demo

Author: **Scott Peters** | [https://advancedsqlpuzzles.com](https://advancedsqlpuzzles.com)

An end-to-end cloud data pipeline demonstrating how to import raw CSV data from Azure Data Lake Storage (ADLS Gen2), perform Delta Lake transformations in Databricks, and publish clean relational tables to Azure SQL Database via Azure Data Factory.

---

## Documents & Code

| File | Type | Description |
|:---|:---|:---|
| [`DATABRICKS_SPARK_HIVE_DEMO.md`](file:///c:/Users/amitt/Documents/github/Advancesqlpuzzle/Microsoft%20Azure/Databricks%20Spark%20Hive%20Demo/DATABRICKS_SPARK_HIVE_DEMO.md) | Technical Guide | Complete 66-slide walkthrough: provisioning, AKV secret scopes, ADLS Gen2 layout, PySpark staging/merge functions, and sequential ADF orchestration. |
| [`SuppliersAndParts.dbc`](file:///c:/Users/amitt/Documents/github/Advancesqlpuzzle/Microsoft%20Azure/Databricks%20Spark%20Hive%20Demo/SuppliersAndParts.dbc) | Databricks Archive | Importable Databricks workspace containing all 8 PySpark notebooks. |
| [`SuppliersAndPartsDDL.sql`](file:///c:/Users/amitt/Documents/github/Advancesqlpuzzle/Microsoft%20Azure/Databricks%20Spark%20Hive%20Demo/SuppliersAndPartsDDL.sql) | T-SQL Scripts | Target schema (`supp_parts_hive`) and table DDL for Azure SQL Database. |
| `Suppliers.csv`, `Parts.csv`, `Shipments.csv` | Sample Data | Relational benchmark dataset based on C.J. Date's Suppliers and Parts database. |
