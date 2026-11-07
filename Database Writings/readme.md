# Database Writings

A collection of in-depth technical papers, architectural guides, and reproducible SQL scripts exploring relational database internals, predicate logic, and advanced SQL querying.

---

## Contents

### 1. [Advanced SQL Joins](./Advanced%20SQL%20Joins/)
- **Document:** `Advanced SQL Joins.pdf`
- **Scripts:** `Advanced SQL Joins SQL Statements.sql`
- **Focus:** Complete operational analysis of SQL joins (`INNER`, `LEFT`, `RIGHT`, `FULL OUTER`, `CROSS`, `CROSS APPLY`, and non-equi joins) and their interaction with three-valued logic and `NULL` markers.

### 2. [Behavior of Nulls](./Behavior%20Of%20Nulls/)
- **Document:** `Behavior of Nulls.pdf`
- **Scripts:** `Behavior of Nulls SQL Statements.sql`
- **Focus:** Detailed examination of ANSI three-valued logic (`TRUE`, `FALSE`, `UNKNOWN`), truth tables, `IS NULL` vs `= NULL`, aggregation behaviors with `NULL`, and common anti-patterns in predicate evaluation.

### 3. [Database Concepts and Components](./Database%20Concepts%20And%20Components/)
- **Document:** `Database Concepts and Components.pdf`
- **Focus:** Foundational guide covering RDBMS architecture, storage structures, buffer management, transaction logging (ACID), locking/concurrency models, and indexing strategies.
