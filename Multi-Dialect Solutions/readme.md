# Multi-Dialect SQL Architecture & Cross-Engine Solutions

This directory provides comprehensive cross-engine translations, optimizer comparisons, and modern dialect solutions for the most challenging relational problem archetypes.

---

## 📂 Contents

| Document | Focus | Dialects Covered |
| :--- | :--- | :--- |
| [`MULTI_DIALECT_GUIDE.md`](file:///c:/Users/amitt/Documents/github/Advancesqlpuzzle/Multi-Dialect%20Solutions/MULTI_DIALECT_GUIDE.md) | **Cross-Engine Architecture & Solutions** | **T-SQL** • **PostgreSQL 16+** • **Snowflake** • **Google BigQuery** • **DuckDB** |

---

## 🎯 Key Architectural Paradigms Covered

1. **Gaps & Islands (Workflow Transitions):**
   - The classical double `ROW_NUMBER()` offset technique (T-SQL, PostgreSQL).
   - Modern `MATCH_RECOGNIZE` row pattern matching (Snowflake, DuckDB).
2. **Window Function Filtering (`QUALIFY` vs. CTE Wrapping):**
   - Storage-pushdown window filtering via `QUALIFY` (Snowflake, BigQuery, DuckDB).
   - Derived table / CTE encapsulation requirements (T-SQL, PostgreSQL).
3. **Relational Division & Set Comparison:**
   - Single-pass `FULL OUTER JOIN` and bidirectional `EXCEPT` (T-SQL).
   - Array aggregation and set equality operators (PostgreSQL).
   - High-throughput array transformations (BigQuery).
4. **Hierarchical Trees & Graph Recursion:**
   - T-SQL implicit `WITH` recursion + `OPTION (MAXRECURSION)`.
   - ANSI standard `WITH RECURSIVE` (PostgreSQL, BigQuery, DuckDB).
   - Snowflake native `CONNECT BY` traversal.
5. **Conditional Aggregation & Reshaping:**
   - PostgreSQL `FILTER (WHERE ...)`.
   - BigQuery / Snowflake `COUNTIF()`.
   - T-SQL `SUM(CASE WHEN ...)`.
