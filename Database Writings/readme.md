# Database Writings

A collection of in-depth technical whitepapers, architectural guides, and reproducible SQL scripts exploring relational database internals, predicate logic, and advanced SQL querying.

---

## Contents

### 1. [Advanced SQL Joins](./Advanced%20SQL%20Joins/)
- **Document:** [`ADVANCED_SQL_JOINS.md`](./Advanced%20SQL%20Joins/ADVANCED_SQL_JOINS.md)
- **Scripts:** [`Advanced SQL Joins SQL Statements.sql`](./Advanced%20SQL%20Joins/Advanced%20SQL%20Joins%20SQL%20Statements.sql)
- **Focus:** Complete operational analysis of SQL joins (`INNER`, `LEFT`, `RIGHT`, `FULL OUTER`, `CROSS`, and non-equi joins), physical join algorithms (nested loop, merge, hash), logical query processing lifecycle, and graph-based problem solving (Mutual Friends puzzle).

### 2. [Behavior of Nulls](./Behavior%20Of%20Nulls/)
- **Document:** [`BEHAVIOR_OF_NULLS.md`](./Behavior%20Of%20Nulls/BEHAVIOR_OF_NULLS.md)
- **Scripts:** [`Behavior of Nulls SQL Statements.sql`](./Behavior%20Of%20Nulls/Behavior%20of%20Nulls%20SQL%20Statements.sql)
- **Focus:** Detailed examination of ANSI three-valued logic (`TRUE`, `FALSE`, `UNKNOWN`), truth tables, `IS NULL` vs `= NULL`, the `NOT IN` anti-join trap, unique constraints vs filtered indexes, and NULL function semantics (`COALESCE`, `ISNULL`, `NULLIF`).

### 3. [Database Concepts and Components](./Database%20Concepts%20And%20Components/)
- **Document:** [`DATABASE_CONCEPTS_AND_COMPONENTS.md`](./Database%20Concepts%20And%20Components/DATABASE_CONCEPTS_AND_COMPONENTS.md)
- **Focus:** Foundational reference covering 129 core questions on RDBMS architecture, relational algebra, normal forms (1NF–6NF), B-Tree storage structures, ACID transaction logging, concurrency/isolation levels, and Kimball vs. Inmon dimensional modeling.
