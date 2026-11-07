# Database Concepts and Components: The Comprehensive Technical Handbook

Author: **Scott Peters** | [https://advancedsqlpuzzles.com](https://advancedsqlpuzzles.com)  
Author Contact: `scottpeters1188@outlook.com`

A curated, comprehensive compendium of **129 core database engineering concepts, architectural principles, algorithms, and technical interview questions** across relational theory, query optimization, storage engines, indexing, dimensional modeling, and transaction management.

---

## Table of Contents

- [Part I: Relational Theory, Mathematics & Foundations (Q1–Q13)](#part-i-relational-theory-mathematics--foundations)
- [Part II: Joins, Table Operators & Query Execution Plans (Q14–Q26)](#part-ii-joins-table-operators--query-execution-plans)
- [Part III: Database Programmability: Procedures, Functions, Triggers, Views (Q27–Q36)](#part-iii-database-programmability-procedures-functions-triggers-views)
- [Part IV: Aggregations, Window Functions & Set Operators (Q37–Q43)](#part-iv-aggregations-window-functions--set-operators)
- [Part V: Control Flow, Best Practices & Bulk Operations (Q44–Q46)](#part-v-control-flow-best-practices--bulk-operations)
- [Part VI: Physical Storage, B-Trees & Index Architecture (Q47–Q55)](#part-vi-physical-storage-b-trees--index-architecture)
- [Part VII: Normalization, ER Modeling & Schema Design (Q56–Q63, Q69–Q73, Q78–Q79)](#part-vii-normalization-er-modeling--schema-design)
- [Part VIII: Data Warehousing, Dimensional Modeling & OLAP (Q64–Q65, Q70, Q85–Q97)](#part-viii-data-warehousing-dimensional-modeling--olap)
- [Part IX: Keys, Constraints & Physical Data Types (Q66–Q68, Q77, Q80–Q84)](#part-ix-keys-constraints--physical-data-types)
- [Part X: Three-Valued Logic, NULLs & Data Storage Optimization (Q74–Q76, Q124–Q125)](#part-x-three-valued-logic-nulls--data-storage-optimization)
- [Part XI: Transactions, Concurrency, Locking & ACID (Q100–Q114)](#part-xi-transactions-concurrency-locking--acid)
- [Part XII: Database Architecture, Engines, CDC & Security (Q98–Q99, Q115–Q123, Q126–Q129)](#part-xii-database-architecture-engines-cdc--security)

---

## Part I: Relational Theory, Mathematics & Foundations

### 1. What is SQL?
SQL (Structured Query Language) is the domain-specific language of relational databases. First appearing in 1974 (developed at IBM by Donald D. Chamberlin and Raymond F. Boyce as SEQUEL), SQL is a set-based, declarative, strongly-typed, and cross-platform language based on relational algebra and tuple relational calculus. It was one of the first commercial implementations of Edgar F. Codd’s relational model.  
📖 [Wikipedia: SQL](https://en.wikipedia.org/wiki/SQL)

### 2. SQL is a declarative language. Describe what this means.
Declarative programming is a paradigm that expresses the logic of a computation without describing its detailed control flow or algorithmic steps. In short, with a declarative language you **tell the database what data you want, not how to retrieve it**. The database query optimizer is responsible for generating an efficient physical execution plan.  
📖 [Wikipedia: Declarative Programming](https://en.wikipedia.org/wiki/Declarative_programming)

### 3. What is meant by a relation in the relational database model?
In relational database theory, a **relation** is a set of tuples (rows) having the same attributes (columns). It represents a mathematical relation over sets of values. In physical RDBMS implementations, a relation corresponds to a table or view.  
📖 [Wikipedia: Relation (Database)](https://en.wikipedia.org/wiki/Relation_(database)) | [Wikipedia: Relational Model](https://en.wikipedia.org/wiki/Relational_model)

### 4. What is set theory and how does it relate to SQL?
Set theory is the branch of mathematical logic that studies sets—well-defined collections of distinct objects. SQL operates on relational tables as mathematical sets (or multisets/bags when duplicate rows are permitted). Set operations like Union, Intersection, and Difference are directly implemented in SQL. Georg Cantor founded modern set theory in the 1870s.  
📖 [Wikipedia: Set Theory](https://en.wikipedia.org/wiki/Set_theory) | [Wikipedia: Georg Cantor](https://en.wikipedia.org/wiki/Georg_Cantor)

### 5. What is the Barber Paradox in set theory?
The Barber Paradox (introduced by Bertrand Russell) considers a town barber who shaves all and only those men in town who do not shave themselves. The question arises: *Does the barber shave himself?* If he does not shave himself, he must shave himself; if he does shave himself, he must not. In set theory and mathematical logic, this paradox demonstrates that naive set theory contains inherent contradictions, necessitating axiomatic set theory (Zermelo–Fraenkel).  
📖 [Wikipedia: Barber Paradox](https://en.wikipedia.org/wiki/Barber_paradox)

### 6. What is relational algebra?
Relational algebra is a formal mathematical system with operational semantics for modeling relational data and expressing queries. Its fundamental operations include unary operators (Selection $\sigma$, Projection $\pi$, Rename $\rho$) and binary operators (Cartesian Product $\times$, Set Union $\cup$, Set Difference $-$, Join $\bowtie$, and Division $\div$).  
📖 [Wikipedia: Relational Algebra](https://en.wikipedia.org/wiki/Relational_algebra)

### 7. What is relational calculus?
Relational calculus consists of two formal query systems: **Tuple Relational Calculus (TRC)** and **Domain Relational Calculus (DRC)**. While relational algebra is procedural/algebraic (providing an order of operations), relational calculus is purely declarative, describing the desired properties of the result without prescribing evaluation sequence.  
📖 [Wikipedia: Relational Calculus](https://en.wikipedia.org/wiki/Relational_calculus)

### 8. What is tuple calculus?
Introduced by E.F. Codd, Tuple Relational Calculus (TRC) is a declarative database query notation where queries have the form $\{t \mid P(t)\}$, selecting all tuples $t$ that satisfy predicate $P$. TRC was the direct theoretical foundation for SQL.  
📖 [Wikipedia: Tuple Relational Calculus](https://en.wikipedia.org/wiki/Tuple_relational_calculus)

### 9. What is domain calculus?
Introduced by Michel Lacroix and Alain Pirotte, Domain Relational Calculus (DRC) expresses queries over individual attribute variables rather than whole tuples. It served as the theoretical inspiration for Query-by-Example (QBE).  
📖 [Wikipedia: Domain Relational Calculus](https://en.wikipedia.org/wiki/Domain_relational_calculus)

### 10. Who is E.F. Codd?
Edgar Frank "Ted" Codd (1923–2003) was a British computer scientist at IBM who invented the relational model for database management in his seminal 1970 paper *"A Relational Model of Data for Large Shared Data Banks"*. He received the Turing Award in 1981.  
📖 [Wikipedia: Edgar F. Codd](https://en.wikipedia.org/wiki/Edgar_F._Codd)

### 11. What are E.F. Codd’s 12 rules for relational database management systems?
Codd's Twelve Rules (numbered 0 to 12) define the criteria a database management system must satisfy to be considered truly relational. Rule 0 (Foundation Rule) requires the system to manage its database entirely through its relational capabilities. Other rules enforce systematic treatment of NULL values, guaranteed access, physical/logical data independence, and relational view updatability.  
📖 [Wikipedia: Codd's 12 Rules](https://en.wikipedia.org/wiki/Codd%27s_12_rules)

### 12. What is Codd’s theorem?
Codd's Theorem states that relational algebra and domain-independent relational calculus queries are equivalent in expressive power. A database query language is said to be **relationally complete** if it can express any query expressible in relational calculus.  
📖 [Wikipedia: Codd's Theorem](https://en.wikipedia.org/wiki/Codd%27s_theorem)

### 13. Does SQL have procedural extensions?
Yes. Although core SQL is declarative, major RDBMS vendors provide procedural extensions containing control-of-flow, loops, variables, and error handling:
- **T-SQL** (Transact-SQL) in Microsoft SQL Server / Sybase
- **PL/SQL** in Oracle
- **PL/pgSQL** in PostgreSQL  
📖 [Wikipedia: SQL Procedural Extensions](https://en.wikipedia.org/wiki/SQL#Procedural_extensions)

---

## Part II: Joins, Table Operators & Query Execution Plans

### 14. What are the different table joins?
Standard ANSI joins include:
- `INNER JOIN`: Preserves only rows where join predicate is TRUE.
- `LEFT OUTER JOIN`: Preserves all left table rows; un-matched right columns return NULL.
- `RIGHT OUTER JOIN`: Preserves all right table rows; un-matched left columns return NULL.
- `FULL OUTER JOIN`: Preserves un-matched rows from both tables.
- `CROSS JOIN`: Cartesian product ($M \times N$ permutations).
- Specialized joins: Self-joins, Natural joins, Non-equi (Theta) joins, Semi-joins, Anti-joins.  
📖 [Wikipedia: Join (SQL)](https://en.wikipedia.org/wiki/Join_(SQL))

### 15. Give a real-world example of a self-join.
An organizational hierarchy where an `Employees` table has both `EmployeeID` and `ManagerID`. Joining `Employees e` to `Employees m ON e.ManagerID = m.EmployeeID` returns each employee paired with their manager.  
📖 [Wikipedia: Self-join](https://en.wikipedia.org/wiki/Join_(SQL)#Self-join)

### 16. Give a real-world example of a full outer join.
Comparing items across two shopping baskets or reconciling inventory between physical warehouse counts and enterprise ledger systems to identify items present in both, missing from warehouse, or missing from ledger.  
📖 [Wikipedia: Full Outer Join](https://en.wikipedia.org/wiki/Join_(SQL)#Full_outer_join)

### 17. Give a real-world example of a cross join.
Combining a distinct calendar date dimension with a list of active sales agents to generate an exhaustive matrix of all potential agent-date combinations, against which actual sales transactions can be zero-filled.  
📖 [Wikipedia: Cross Join](https://en.wikipedia.org/wiki/Join_(SQL)#Cross_join)

### 18. What is a correlated subquery?
A correlated subquery is an inner query that references column values from the outer query. Because the inner query depends on the outer row, it conceptually evaluates once per row processed by the outer query, which can cause significant performance overhead if not rewritten or optimized into a join.  
📖 [Wikipedia: Correlated Subquery](https://en.wikipedia.org/wiki/Correlated_subquery)

### 19. What is meant by a restricted Cartesian product?
In relational theory, every join begins as a Cartesian product ($M \times N$). An `INNER JOIN` or `OUTER JOIN` applies the `ON` predicate to restrict this Cartesian product to eligible row combinations.  
📖 Reference: *T-SQL Querying* by Itzik Ben-Gan.

### 20. What is a semi-join? What is an anti-join?
- **Semi-Join:** Returns rows from the first table for which at least one match exists in the second table (implemented via `EXISTS` or `IN`). Never duplicates outer rows.
- **Anti-Join:** Returns rows from the first table for which no match exists in the second table (implemented via `NOT EXISTS` or `NOT IN`).  
📖 [Wikipedia: Relational Algebra Joins](https://en.wikipedia.org/wiki/Relational_algebra#Joins_and_join-like_operators)

### 21. What is the benefit of using a semi-join or anti-join?
1. **Guaranteed Cardinality:** Unlike standard joins, semi/anti-joins never multiply rows from the primary table even if multiple matches exist in the related table.
2. **Readability & Projection Safety:** Columns from the referenced table cannot accidentally leak into the outer `SELECT` projection.
3. **Engine Optimization:** Optimizers can stop evaluating matches as soon as the first matching record is found (`Short-circuiting`).

### 22. What are the different physical join algorithms?
Modern RDBMS engines employ three primary physical join operators:
1. **Nested Loops Join:** Scans outer table and performs indexed lookups on the inner table. Ideal for small outer sets and indexed inner sets. Supports non-equi joins.
2. **Merge Join:** Simultaneously scans two sorted inputs on equi-join keys. Very fast, linear $O(M + N)$ time complexity.
3. **Hash Join:** Hashes the smaller build input into memory, then streams and probes with the larger probe input. Ideal for large, unsorted, unindexed datasets.  
📺 [Visual Join Algorithms Guide](https://youtu.be/o1dMJ6-CKzU)

### 23. What is a database execution plan?
An execution plan is a graphical or textual tree generated by the query optimizer describing the sequence of physical operations (scans, seeks, joins, sorts, aggregations) chosen to execute an SQL statement.  
📖 [Wikipedia: Query Plan](https://en.wikipedia.org/wiki/Query_plan)

### 24. What is a query hint?
A query hint is an explicit instruction added to an SQL statement that overrides the optimizer's default heuristics (e.g., `OPTION (MERGE JOIN)`, `INDEX(IX_IndexName)`, `NOLOCK`). While useful for tactical performance fixes, hints should be used sparingly as they prevent the optimizer from adapting to data distribution changes.  
📖 [Wikipedia: Hint (SQL)](https://en.wikipedia.org/wiki/Hint_(SQL))

### 25. What is the logical processing order of a query?
SQL queries are evaluated in the following sequence:
1. `FROM` (table operators: `JOIN`, `APPLY`, `PIVOT`, `UNPIVOT`)
2. `WHERE`
3. `GROUP BY`
4. `HAVING`
5. `SELECT`
6. `DISTINCT`
7. `ORDER BY`
8. `TOP` / `OFFSET-FETCH`  
📖 Reference: *T-SQL Querying* by Itzik Ben-Gan.

### 26. What is the difference between the WHERE clause and the HAVING clause?
- **`WHERE`:** Evaluated *before* `GROUP BY`; filters individual rows. Cannot contain aggregate functions.
- **`HAVING`:** Evaluated *after* `GROUP BY`; filters aggregated groups based on summary expressions (e.g., `HAVING SUM(Sales) > 10000`).  
📖 [Wikipedia: Where (SQL)](https://en.wikipedia.org/wiki/Where_(SQL)) | [Wikipedia: Having (SQL)](https://en.wikipedia.org/wiki/Having_(SQL))

---

## Part III: Database Programmability: Procedures, Functions, Triggers, Views

### 27. What is a MERGE statement?
A `MERGE` statement (introduced in ANSI SQL:2003) combines `INSERT`, `UPDATE`, and `DELETE` operations against a target table in a single atomic statement based on matching conditions with a source dataset.  
📖 [Wikipedia: Merge (SQL)](https://en.wikipedia.org/wiki/Merge_(SQL))

### 28. What is a stored procedure?
A stored procedure is a precompiled collection of SQL statements and procedural logic stored in the database. Stored procedures accept input/output parameters, can execute DDL/DML, participate in transactions, encapsulate business logic, and reduce network traffic by caching execution plans.  
📖 [Wikipedia: Stored Procedure](https://en.wikipedia.org/wiki/Stored_procedure)

### 29. What is a trigger?
A trigger is a specialized stored procedure that executes automatically in response to specific database events (such as DML operations `INSERT`, `UPDATE`, `DELETE`, or DDL operations like `CREATE TABLE`). Triggers can be `AFTER` (post-operation) or `INSTEAD OF`.  
📖 [Wikipedia: Database Trigger](https://en.wikipedia.org/wiki/Database_trigger)

### 30. What is a view?
A view is a stored query presented to users as a virtual table. Views do not store data physically (unless indexed/materialized); they provide abstraction, security by restricting column/row access, and simplify complex queries.  
📖 [Wikipedia: View (SQL)](https://en.wikipedia.org/wiki/View_(SQL))

### 31. What is the difference between a view and a materialized view?
- **Standard View:** A virtual table whose underlying query runs each time the view is referenced.
- **Materialized View (Indexed View):** The query results are computed and physically stored on disk, with clustered and non-clustered indexes built directly on top of the view. The engine automatically synchronizes the materialized data when underlying tables are modified.  
📖 [Wikipedia: Materialized View](https://en.wikipedia.org/wiki/Materialized_view)

### 32. What is a table-valued function? What is its benefit?
A table-valued function (TVF) is a user-defined function that returns a tabular result set. An **Inline TVF (iTVF)** acts like a parameterized view; the optimizer inlines its definition directly into the calling execution plan, enabling seamless parallelism, indexing, and `CROSS APPLY` joins.  
📖 [Wikipedia: User-defined Function](https://en.wikipedia.org/wiki/User-defined_function)

### 33. What is the difference between deterministic and non-deterministic functions?
- **Deterministic:** Always returns the identical result given the same inputs and database state (e.g., `SQUARE()`, `DATEADD()`, `ABS()`). Can be indexed in computed columns and views.
- **Non-deterministic:** May return different results on each execution even with identical inputs (e.g., `GETDATE()`, `NEWID()`, `RAND()`). Cannot be indexed in persistent views.  
📖 [Microsoft Docs: Deterministic Functions](https://docs.microsoft.com/en-us/sql/relational-databases/user-defined-functions/deterministic-and-nondeterministic-functions)

### 34. What are DDL, DML, and DCL statements?
- **DDL (Data Definition Language):** Defines database structure (`CREATE`, `ALTER`, `DROP`, `TRUNCATE`).
- **DML (Data Manipulation Language):** Retrieves and manages data (`SELECT`, `INSERT`, `UPDATE`, `DELETE`).
- **DCL (Data Control Language):** Manages permissions and security (`GRANT`, `DENY`, `REVOKE`).  
📖 [Wikipedia: DDL](https://en.wikipedia.org/wiki/Data_definition_language) | [DML](https://en.wikipedia.org/wiki/Data_manipulation_language) | [DCL](https://en.wikipedia.org/wiki/Data_control_language)

### 35. What is the difference between DDL and DML in transactions?
In standard ANSI systems and SQL Server, both DDL and DML can be enclosed within an explicit user transaction (`BEGIN TRANSACTION ... ROLLBACK`). However, in certain database engines (such as Oracle or MySQL), DDL statements trigger an implicit commit before and after execution, preventing rollback.  
📖 [MSSQLTips: DDL in Transactions](https://www.mssqltips.com/sqlservertip/4591/ddl-commands-in-transactions-in-sql-server-versus-oracle/)

### 36. What is the main purpose of Common Table Expressions (CTEs)?
CTEs improve query modularity, readability, and maintainability by defining named temporary result sets. Their primary architectural superpower is **recursion**—enabling self-referencing iterations to traverse hierarchical, graph, and tree structures in a single query.  
📖 [Wikipedia: Recursive Queries in SQL](https://en.wikipedia.org/wiki/Hierarchical_and_recursive_queries_in_SQL)

---

## Part IV: Aggregations, Window Functions & Set Operators

### 37. What are aggregate functions?
Aggregate functions perform calculations across a collection of rows and return a single summary value. Except for `COUNT(*)`, all ANSI aggregate functions (`SUM`, `AVG`, `MIN`, `MAX`, `COUNT`) ignore NULL markers.  
📖 [Microsoft Docs: Aggregate Functions](https://docs.microsoft.com/en-us/sql/t-sql/functions/aggregate-functions-transact-sql)

### 38. What are window functions?
Window functions compute calculations across a defined subset of rows (a "window") related to the current row, **without collapsing individual rows into groups**. Unlike `GROUP BY`, window functions allow rows to retain their individual identities while displaying running totals, rankings, moving averages, and lead/lag values.  
📖 [Wikipedia: Window Function (SQL)](https://en.wikipedia.org/wiki/Window_function_(SQL))

### 39. Name common functions that can be windowed.
- **Ranking:** `ROW_NUMBER()`, `RANK()`, `DENSE_RANK()`, `NTILE()`
- **Aggregates:** `SUM()`, `AVG()`, `COUNT()`, `MIN()`, `MAX()`
- **Navigation / Offset:** `LAG()`, `LEAD()`, `FIRST_VALUE()`, `LAST_VALUE()`
- **Statistical:** `CUME_DIST()`, `PERCENT_RANK()`

### 40. What are the four ranking functions in SQL?
1. `ROW_NUMBER()`: Assigns a unique, sequential integer starting at 1.
2. `RANK()`: Assigns sequential ranks with gaps for ties (e.g. 1, 2, 2, 4).
3. `DENSE_RANK()`: Assigns sequential ranks without gaps for ties (e.g. 1, 2, 2, 3).
4. `NTILE(n)`: Divides ordered rows into $n$ approximately equal buckets.  
📖 [Microsoft Docs: Ranking Functions](https://docs.microsoft.com/en-us/sql/t-sql/functions/ranking-functions-transact-sql)

### 41. What is the difference between ROLLUP and CUBE?
Extensions of `GROUP BY`:
- **`ROLLUP`**: Produces hierarchical subtotals and grand totals (order-dependent: $n+1$ grouping sets for $n$ columns).
- **`CUBE`**: Produces multidimensional cross-tabular subtotals across all possible permutations ($2^n$ grouping sets).  
📖 [Microsoft Docs: GROUP BY ROLLUP/CUBE](https://docs.microsoft.com/en-us/sql/t-sql/queries/select-group-by-transact-sql)

### 42. What is the difference between UNION and UNION ALL?
- `UNION`: Combines row sets and performs a distinct sort/hash operation to **remove duplicate rows**.
- `UNION ALL`: Concatenates row sets directly, **preserving all duplicates**. Significantly faster due to skipping deduplication sorts.  
📖 [Wikipedia: Set Operations (SQL)](https://en.wikipedia.org/wiki/Set_operations_(SQL))

### 43. What is a cursor?
A database cursor is a control structure enabling row-by-row procedural traversal over a query result set. Cursors violate set-based relational design and often cause severe performance and locking bottlenecks. They should only be used when set-based alternatives do not exist.  
📖 [Wikipedia: Cursor (Databases)](https://en.wikipedia.org/wiki/Cursor_(databases))

---

## Part V: Control Flow, Best Practices & Bulk Operations

### 44. What are the control flow statements in SQL?
T-SQL control flow keywords include `BEGIN...END`, `IF...ELSE`, `WHILE`, `BREAK`, `CONTINUE`, `RETURN`, `GOTO`, and `WAITFOR`.  
📖 [Wikipedia: Transact-SQL Flow Control](https://en.wikipedia.org/wiki/Transact-SQL#Flow_control)

### 45. What is a bulk insert?
A bulk insert is a high-performance database mechanism (e.g. T-SQL `BULK INSERT`, `bcp` utility) designed to load millions of rows from flat data files (CSV, TSV) directly into database tables with minimal transaction logging.  
📖 [Wikipedia: BULK INSERT](https://en.wikipedia.org/wiki/Transact-SQL#BULK_INSERT)

### 46. What are common SQL coding standards and best practices?
- Uppercase reserved SQL keywords (`SELECT`, `FROM`, `WHERE`).
- Consistent camelCase or snake_case object naming conventions.
- Explicit schema qualification (`dbo.TableName`).
- Explicit column projections (avoid `SELECT *` in production).
- Proper indentation and block scoping.  
📖 References: *Joe Celko's SQL Programming Style*; *Oracle PL/SQL Best Practices* by Steven Feuerstein.

---

## Part VI: Physical Storage, B-Trees & Index Architecture

### 47. What are the different types of table indexes?
- **Clustered Index:** Dictates physical order of table storage.
- **Non-Clustered Index:** Separate B-tree structure pointing back to data rows.
- **Unique Index:** Guarantees key uniqueness.
- **Filtered Index:** Indexes a conditioned row subset (`WHERE IsActive = 1`).
- **Covering Index:** Includes all required query columns (`INCLUDE(...)`).
- **Columnstore Index:** Compressed columnar storage for analytics.
- **Spatial / Full-Text / XML Indexes:** Specialized domain structures.  
📖 [Wikipedia: Database Index](https://en.wikipedia.org/wiki/Database_index)

### 48. What is the difference between a clustered and non-clustered index?
| Feature | Clustered Index | Non-Clustered Index |
|:---|:---|:---|
| **Storage Structure** | The leaf level **is** the physical table data pages. | Leaf level contains index keys + row locators (RID or Clustered Key). |
| **Quantity per Table**| Exactly **one** per table. | Multiple (up to 999 in SQL Server). |
| **Additional Space** | Requires no extra storage beyond the table. | Requires additional disk space for separate B-tree. |
| **Lookup Speed** | Direct access to all columns. | May require key lookup back to clustered index if un-covered. |  
📖 [Guru99: Clustered vs Non-Clustered](https://www.guru99.com/clustered-vs-non-clustered-index.html)

### 49. What is a columnstore index?
Columnstore indexes store data in columnar format rather than traditional row-oriented pages. Data is divided into row groups (~1 million rows) and compressed column by column. Columnstore indexes deliver 10x compression and orders-of-magnitude faster aggregation performance for analytics/OLAP.  
📖 [Microsoft Docs: Columnstore Indexes](https://docs.microsoft.com/en-us/sql/relational-databases/indexes/columnstore-indexes-overview)

### 50. What is a filtered index?
A filtered index is an optimized non-clustered index that incorporates a `WHERE` predicate to index only a selective subset of rows. Filtered indexes reduce storage footprint, improve seek performance, and lower index maintenance overhead (e.g. indexing only unfulfilled orders: `WHERE Status = 'Pending'`).  
📖 [Wikipedia: Partial Index](https://en.wikipedia.org/wiki/Partial_index)

### 51. What is a covering index?
A covering index contains all columns referenced by a query (in `SELECT`, `WHERE`, `JOIN`, `ORDER BY`). By fulfilling the entire query from the index leaves, it completely eliminates costly **Key Lookups** or RID Lookups against the base table. T-SQL uses the `INCLUDE` clause for non-key covering columns.  
📖 [Wikipedia: Covering Index](https://en.wikipedia.org/wiki/Database_index#Covering_index)

### 52. What is the difference between an index seek and an index scan?
- **Index Seek:** The engine traverses the B-tree from root to leaf node to pinpoint exact matching rows based on search arguments (SARGable predicates). Fast, $O(\log N)$.
- **Index Scan:** The engine traverses all leaf pages of the index from start to finish. Performed when predicates are non-selective or non-SARGable. Slower, $O(N)$.  
📖 [MSSQLTips: Index Scans vs Seeks](https://www.mssqltips.com/sqlservertutorial/277/index-scans-and-table-scans)

### 53. What is a B-Tree structure?
A B-Tree (Balanced Tree) is a self-balancing search tree structure maintaining sorted keys with $O(\log N)$ search, insertion, and deletion complexity. SQL Server indexes use a $\text{B}^+\text{-Tree}$ variant where all data rows/locators reside solely at the leaf level, linked sequentially for range scans.  
📖 [Wikipedia: B-Tree](https://en.wikipedia.org/wiki/B-tree) | [SQLShack: SQL Server Index Structure](https://www.sqlshack.com/sql-server-index-structure-and-concepts/)

### 54. What is a database heap?
A heap is a table stored without a clustered index. Rows are stored in data pages in arbitrary, unordered fashion, identified by a Row Identifier (RID) consisting of File Number, Page Number, and Slot Number.  
📖 [Wikipedia: Database Storage Structures](https://en.wikipedia.org/wiki/Database_storage_structures)

### 55. What is a full table scan?
A full table scan (Table Scan) sequentially reads every page of a heap or clustered index from beginning to end to evaluate query criteria. It occurs when no appropriate index exists or when reading the entire table is deemed cheaper by the optimizer.  
📖 [Wikipedia: Full Table Scan](https://en.wikipedia.org/wiki/Full_table_scan)

---

## Part VII: Normalization, ER Modeling & Schema Design

### 56. What are the different normalization forms?
- **1NF (First Normal Form):** Atomic values only; no repeating groups or multivalued columns; unique row identity.
- **2NF (Second Normal Form):** Meets 1NF, and all non-key attributes are fully functionally dependent on the entire primary key (eliminates partial key dependencies).
- **3NF (Third Normal Form):** Meets 2NF, and all non-key attributes depend solely on the primary key, with no transitive dependencies ($A \rightarrow B, B \rightarrow C$).
- **BCNF (Boyce-Codd Normal Form):** Strict 3NF where every determinant is a candidate key.
- **4NF & 5NF:** Eliminate multi-valued dependencies and join dependencies.  
📖 [Wikipedia: Database Normalization](https://en.wikipedia.org/wiki/Database_normalization)

### 57. What is the benefit of Third Normal Form (3NF)?
3NF eliminates data redundancy, guarantees data consistency, prevents insert/update/delete anomalies, and reduces disk storage overhead in OLTP transactional systems.

### 58. What is database denormalization?
Denormalization is the intentional introduction of redundancy into a normalized schema to improve read query performance, eliminating expensive multi-table joins at the cost of slower writes and increased storage.  
📖 [Wikipedia: Denormalization](https://en.wikipedia.org/wiki/Denormalization)

### 59. What is database normalization?
The systematic process of organizing fields and tables to minimize redundancy and dependency, originally formulated by Edgar F. Codd.  
📖 [Wikipedia: Normalization](https://en.wikipedia.org/wiki/Database_normalization)

### 60. What is a Slowly Changing Dimension (SCD)?
A dimensional data warehouse pattern tracking historical changes over time:
- **Type 0:** Retain original (immutable).
- **Type 1:** Overwrite old value (no history).
- **Type 2:** Add new row with surrogate key and validity dates (`StartDate`, `EndDate`, `IsCurrent`).
- **Type 3:** Add previous-value column to same row.
- **Type 4:** Separate history table.
- **Type 6:** Hybrid (1 + 2 + 3).  
📖 [Wikipedia: Slowly Changing Dimension](https://en.wikipedia.org/wiki/Slowly_changing_dimension)

### 61. What is a weak entity?
An entity that cannot be uniquely identified by its own attributes alone. It depends on a foreign key relationship with an owner entity to establish its primary key (e.g., `HotelRoom` identified by `HotelID` + `RoomNumber`).  
📖 [Wikipedia: Weak Entity](https://en.wikipedia.org/wiki/Weak_entity)

### 62. What is an associative entity?
A bridge table (junction table) resolving a many-to-many ($M:N$) relationship into two one-to-many ($1:N$) relationships, containing foreign keys to both parent tables and any associative attributes.  
📖 [Wikipedia: Associative Entity](https://en.wikipedia.org/wiki/Associative_entity)

### 63. What is referential integrity? What is the benefit of disabled referential integrity?
Referential integrity enforces valid relationships between foreign keys and primary keys. Disabled foreign keys allow bulk loading of legacy or disordered data without validation failures, while retaining schema diagrams in modeling tools (like Visio or ERwin).  
📖 [Wikipedia: Referential Integrity](https://en.wikipedia.org/wiki/Referential_integrity)

### 69. What is an Entity-Relationship (ER) diagram?
A graphical model representing entity types, attributes, and relationships within a business domain.  
📖 [Wikipedia: ER Model](https://en.wikipedia.org/wiki/Entity%E2%80%93relationship_model)

### 71. What is a conceptual data model?
High-level model defining business entities, concepts, and relationships without technical implementation details.  
📖 [Wikipedia: Conceptual Schema](https://en.wikipedia.org/wiki/Conceptual_schema)

### 72. What is a logical data model?
Technology-agnostic model defining attribute names, primary keys, foreign keys, and normal forms.  
📖 [Wikipedia: Logical Schema](https://en.wikipedia.org/wiki/Logical_schema)

### 73. What is a physical data model?
Database-specific implementation defining data types, indexes, partitions, storage groups, and constraints.  
📖 [Wikipedia: Physical Schema](https://en.wikipedia.org/wiki/Physical_schema)

### 78. What is cardinality?
In relational modeling, cardinality defines the uniqueness of data values in a column or the numeric relationship between related entities ($1:1$, $1:N$, $M:N$).  
📖 [Wikipedia: Cardinality](https://en.wikipedia.org/wiki/Cardinality_(SQL_statements))

### 79. What is a unary relationship? What is a ternary relationship?
- **Unary:** Relationship between records in the same entity set (e.g. Employee $\rightarrow$ Manager).
- **Ternary:** Relationship simultaneously linking three distinct entities (e.g. Physician, Patient, Treatment).  
📖 [BC Open Textbooks: ER Model](https://opentextbc.ca/dbdesign01/chapter/chapter-8-entity-relationship-model)

---

## Part VIII: Data Warehousing, Dimensional Modeling & OLAP

### 64. What is the difference between OLAP and OLTP?
- **OLTP (Online Transaction Processing):** High volume of concurrent, fast, insert/update transactions; normalized 3NF schema; optimized for transactional write throughput.
- **OLAP (Online Analytical Processing):** Complex multi-table aggregations over millions of historical rows; denormalized star/snowflake schemas; optimized for read performance.  
📖 [Wikipedia: OLTP](https://en.wikipedia.org/wiki/Online_transaction_processing) | [OLAP](https://en.wikipedia.org/wiki/Online_analytical_processing)

### 65. What is an OLAP cube?
A multidimensional array enabling rapid slicing, dicing, drilling-down, and rolling-up of business measures across dimensions (e.g. Sales across Time, Geography, Product).  
📖 [Wikipedia: OLAP Cube](https://en.wikipedia.org/wiki/OLAP_cube)

### 70. What is a Dimensional Fact Model (DFM)?
A graphical formalism designed to model facts, measures, dimensions, and dimensional hierarchies in data warehouse projects.  
📖 [Wikipedia: Dimensional Fact Model](https://en.wikipedia.org/wiki/Dimensional_fact_model)

### 85. What is a star schema?
A dimensional model where a central fact table references multiple denormalized dimension tables directly. It provides simple queries and optimized join performance.  
📖 [Wikipedia: Star Schema](https://en.wikipedia.org/wiki/Star_schema)

### 86. What is a snowflake schema?
A variation of the star schema where dimension tables are normalized into sub-dimensions (e.g. `Product` links to `Subcategory`, which links to `Category`).  
📖 [Wikipedia: Snowflake Schema](https://en.wikipedia.org/wiki/Snowflake_schema)

### 87. What is Business Intelligence (BI)?
Strategies, architectures, and technologies converting raw enterprise data into actionable business insights through dashboards, reports, and ad-hoc analysis.  
📖 [Wikipedia: Business Intelligence](https://en.wikipedia.org/wiki/Business_intelligence)

### 88. What is a data warehouse?
A centralized, subject-oriented, integrated, time-variant, non-volatile data repository designed for enterprise reporting and decision support.  
📖 [Wikipedia: Data Warehouse](https://en.wikipedia.org/wiki/Data_warehouse)

### 89. What is a dimension table?
A table containing descriptive business context (who, what, where, when) used to filter, slice, and group fact metrics.  
📖 [Wikipedia: Dimension Table](https://en.wikipedia.org/wiki/Dimension_(data_warehouse)#Dimension_table)

### 90. What is a fact table?
A table consisting of numeric measurements, metrics, and facts resulting from a business process, surrounded by foreign keys to dimensions.  
📖 [Wikipedia: Fact Table](https://en.wikipedia.org/wiki/Fact_table)

### 91. What is a junk dimension?
A single dimension table that consolidates miscellaneous low-cardinality flags and indicators (e.g. `PaymentVerified`, `GiftWrapFlag`), avoiding clutter in the fact table.  
📖 [Wikipedia: Junk Dimension](https://en.wikipedia.org/wiki/Dimension_(data_warehouse)#Junk_dimension)

### 92. What is a hierarchy in a dimension?
A series of parent-child relationships within a dimension (e.g., `Day -> Month -> Quarter -> Year` or `Store -> City -> State -> Country`).

### 93. What is a conformed dimension?
A shared, standardized dimension that maintains identical meaning and structure across multiple business processes and data marts (e.g., enterprise `Date` or `Customer`).  
📖 [Wikipedia: Conformed Dimension](https://en.wikipedia.org/wiki/Dimension_(data_warehouse)#Conformed_dimension)

### 94. What is a data mart?
A departmental subset of a data warehouse focused on a specific business unit (e.g. Marketing Data Mart).  
📖 [Wikipedia: Data Mart](https://en.wikipedia.org/wiki/Data_mart)

### 95. What are Bill Inmon’s and Ralph Kimball’s approaches to data warehousing?
- **Bill Inmon (Top-Down):** Builds a centralized, normalized (3NF) Enterprise Data Warehouse (EDW) first; departmental dimensional data marts are derived from the EDW.
- **Ralph Kimball (Bottom-Up):** Conjoined dimensional data marts (Star Schemas) are built first using enterprise Conformed Dimensions to form the data warehouse.  
📖 [Wikipedia: Bill Inmon](https://en.wikipedia.org/wiki/Bill_Inmon) | [Ralph Kimball](https://en.wikipedia.org/wiki/Ralph_Kimball)

### 96. What is data mining?
The process of discovering non-trivial patterns, correlations, and anomalies within large datasets using machine learning, statistics, and database systems.  
📖 [Wikipedia: Data Mining](https://en.wikipedia.org/wiki/Data_mining)

### 97. What is an Operational Data Store (ODS)?
An interim database used for near-real-time operational reporting and data integration, serving as a staging feed into the long-term EDW.  
📖 [Wikipedia: Operational Data Store](https://en.wikipedia.org/wiki/Operational_data_store)

---

## Part IX: Keys, Constraints & Physical Data Types

### 66. What are the different database keys?
- **Candidate Key:** Minimal set of attributes that uniquely identifies a row.
- **Primary Key:** The candidate key officially chosen to identify rows.
- **Alternate Key:** Candidate keys not chosen as the primary key.
- **Composite Key:** Key composed of two or more attributes.
- **Superkey:** Any set of attributes containing a candidate key.
- **Natural Key:** Business key existing naturally in the domain (e.g. SSN, VIN).
- **Surrogate Key:** System-generated unique identifier without domain meaning (e.g. Identity, GUID).
- **Foreign Key:** Attribute referencing a candidate/primary key in another table.  
📖 [Wikipedia: Primary Key](https://en.wikipedia.org/wiki/Primary_key) | [Candidate Key](https://en.wikipedia.org/wiki/Candidate_key) | [Surrogate Key](https://en.wikipedia.org/wiki/Surrogate_key)

### 67. How do primary keys treat NULL markers?
Primary keys strictly disallow NULL markers. Every component of a primary key must be defined as `NOT NULL`.

### 68. What is an identity field?
A column whose values are automatically generated by the database sequentially (e.g. `IDENTITY(1,1)` in SQL Server, `AUTO_INCREMENT` in MySQL, `SERIAL` in PostgreSQL).  
📖 [Wikipedia: Identity Column](https://en.wikipedia.org/wiki/Identity_column)

### 77. How does a UNIQUE constraint treat a NULL marker?
In standard SQL, a `UNIQUE` constraint permits multiple NULLs. However, in **Microsoft SQL Server**, a standard `UNIQUE` constraint permits **only ONE NULL row** unless a filtered unique index (`WHERE Col IS NOT NULL`) is used.

### 80. What are data types?
Attributes specifying what kind of data an object can store (integers, strings, dates, binaries, decimals).

### 81. Difference between CHAR and VARCHAR?
- `CHAR(n)`: Fixed length. Pads unused space with blanks. Best for uniform data (e.g., State codes `CHAR(2)`).
- `VARCHAR(n)`: Variable length. Stores only actual characters plus 2 bytes length overhead.

### 82. Difference between VARCHAR and NVARCHAR?
- `VARCHAR`: 1 byte per character, restricted to specific non-Unicode code pages.
- `NVARCHAR`: 2 bytes per character, supporting all international Unicode characters.

### 83. What constraints can be placed on a column?
`NOT NULL`, `DEFAULT`, `CHECK`, `PRIMARY KEY`, `FOREIGN KEY`, `UNIQUE`.

### 84. What is a calendar table?
A permanent date dimension table pre-populated with attributes (holidays, weekends, fiscal periods) to replace runtime date calculations in analytical queries.

---

## Part X: Three-Valued Logic, NULLs & Data Storage Optimization

### 74. What is Three-Valued Logic (3VL) in SQL?
Because NULL represents unknown/missing data, boolean expressions evaluate to `TRUE`, `FALSE`, or `UNKNOWN`. Comparing any value to NULL yields `UNKNOWN`.

### 75. What is a NULL marker?
A special marker signifying the absence of a value. It is not zero, not blank, and has no data type.

### 76. What is an empty string?
A valid string literal (`''`) of length 0 with ASCII character representation, completely distinct from NULL.

### 124. What are sparse columns?
Columns optimized for storage of null values. In SQL Server, sparse columns consume 0 bytes when NULL, at the cost of slight CPU overhead when non-null values are accessed.  
📖 [Microsoft Docs: Sparse Columns](https://docs.microsoft.com/en-us/sql/relational-databases/tables/use-sparse-columns)

### 125. Difference between row and page compression?
- **Row Compression:** Compresses fixed-width types to variable-width; NULL and 0 consume 0 bytes.
- **Page Compression:** Includes row compression, then adds Prefix Compression and Dictionary Compression across the data page.  
📖 [Microsoft Docs: Data Compression](https://docs.microsoft.com/en-us/sql/relational-databases/data-compression/data-compression)

---

## Part XI: Transactions, Concurrency, Locking & ACID

### 100. What is database serialization?
The process of converting an in-memory object into a byte stream for storage or transmission, allowing accurate recreation later.  
📖 [Wikipedia: Serialization](https://en.wikipedia.org/wiki/Serialization)

### 101. What is database partitioning?
Dividing very large tables into smaller physical segments (partitions) based on a key (e.g. `TransactionDate`), improving query scan speed and maintenance operations.  
📖 [Wikipedia: Partition (Database)](https://en.wikipedia.org/wiki/Partition_(database))

### 102. What is concurrency control?
Mechanisms ensuring database transactions execute concurrently without violating data integrity or producing inconsistent results.  
📖 [Wikipedia: Concurrency Control](https://en.wikipedia.org/wiki/Concurrency_control)

### 103. What are ANSI isolation levels?
1. **Read Uncommitted:** Allows Dirty Reads.
2. **Read Committed:** Prevents Dirty Reads (Default in SQL Server).
3. **Repeatable Read:** Prevents Non-Repeatable Reads.
4. **Serializable:** Highest isolation; prevents Phantom Reads via range locks.  
📖 [Wikipedia: Isolation Levels](https://en.wikipedia.org/wiki/Isolation_(database_systems)#Isolation_levels)

### 104. What is a COMMIT?
Permanently writes transaction modifications to disk and log, releasing locks and making changes visible to other sessions.

### 105. What is a ROLLBACK?
Reverses all modifications made within the transaction using the transaction log, returning the database to its pre-transaction state.

### 106. What is a database checkpoint?
An internal engine operation writing all dirty log and data pages in memory cache to physical disk, establishing a known safe point for fast crash recovery.  
📖 [Microsoft Docs: Database Checkpoints](https://docs.microsoft.com/en-us/sql/relational-databases/logs/database-checkpoints-sql-server)

### 107. What are temporal tables?
System-versioned tables automatically preserving a complete history of all data modifications (`ValidFrom` to `ValidTo`), enabling point-in-time time-travel queries.  
📖 [Wikipedia: Temporal Database](https://en.wikipedia.org/wiki/Temporal_database)

### 108. What is ACID compliance?
- **Atomicity:** All operations in a transaction succeed or all roll back ("all-or-nothing").
- **Consistency:** Transactions transition database from one valid state to another.
- **Isolation:** Concurrent transactions execute without mutual interference.
- **Durability:** Committed transactions survive system crashes or power failures.  
📖 [Wikipedia: ACID](https://en.wikipedia.org/wiki/ACID)

### 109. What is a database transaction?
A logical unit of work encompassing one or more SQL operations treated as an atomic whole.

### 110. What is a record lock?
A concurrency lock preventing simultaneous, conflicting access to a data row. Types include Shared Locks (`S`) for reading and Exclusive Locks (`X`) for writing.

### 111. What is a deadlock?
A concurrency conflict where two or more transactions hold locks on resources each other requires, creating an impasse. The database engine resolves this by killing one session (deadlock victim).  
📖 [Wikipedia: Deadlock](https://en.wikipedia.org/wiki/Deadlock)

### 112. What is a dirty read?
Reading uncommitted data modified by another concurrent transaction that might ultimately roll back.

### 113. What is a transaction log?
An append-only physical log recording every transaction modification prior to page updates (Write-Ahead Logging / WAL), guaranteeing ACID durability and rollback capabilities.  
📖 [Wikipedia: Transaction Log](https://en.wikipedia.org/wiki/Transaction_log)

### 114. Who is Jim Gray and what were his contributions?
James Nicholas Gray (1944–2012) was an American computer scientist awarded the 1998 Turing Award for pioneering contributions to database transaction processing, ACID formulation, two-phase commit protocols, fine-grained locking, and the OLAP `CUBE` operator.  
📖 [Wikipedia: Jim Gray](https://en.wikipedia.org/wiki/Jim_Gray_(computer_scientist))

---

## Part XII: Database Architecture, Engines, CDC & Security

### 98. What is a hash function?
A deterministic mathematical function converting an arbitrary byte input into a fixed-length alphanumeric hash value, used for integrity verification and hash indexing.

### 99. What is an overloaded function?
A routine supporting multiple parameter signatures/data types under the same function name (supported in Oracle PL/SQL, but not in SQL Server T-SQL user functions).

### 115. What is Change Data Capture (CDC)?
A database feature that asynchronously records insert, update, and delete activity from transaction logs into tracking tables, facilitating low-latency ETL and data synchronization.  
📖 [Wikipedia: Change Data Capture](https://en.wikipedia.org/wiki/Change_data_capture)

### 116. What are temporary tables?
Volatile tables created in `tempdb`:
- Local `#Table`: Scoped to current session.
- Global `##Table`: Accessible across all concurrent user sessions.

### 117. What are catalog / metadata / INFORMATION_SCHEMA views?
System-provided views and tables describing the structure and metadata of database objects (tables, columns, constraints, indexes).

### 118. What organization sets SQL standards?
ANSI (American National Standards Institute) in 1986 (`SQL-86`) and ISO in 1987. Major revisions include SQL-92, SQL:1999, and SQL:2003.

### 119. What are popular RDBMS systems?
Microsoft SQL Server, Oracle Database, PostgreSQL, MySQL, IBM DB2, SQLite, MariaDB, Teradata.

### 120. What are other database models beyond relational?
Document stores, Key-Value stores, Graph databases, Wide-column stores, Object-oriented databases, and Hierarchical databases.

### 121. What are the benefits of NoSQL over RDBMS?
Horizontal scalability across distributed commodity clusters, dynamic flexible schema design, and optimized performance for unstructured/semi-structured JSON data.

### 122. What is a database application?
A software system whose primary function is recording, updating, and presenting data stored in a DBMS (e.g. ERP, CRM, web platforms).

### 123. What is data independence?
The architectural separation of database schemas:
- **Physical Data Independence:** Storage files or indexes can change without breaking queries or logical schemas.
- **Logical Data Independence:** Logical entities can evolve without breaking client applications.

### 126. What is the database engine?
The foundational software executing queries and managing storage, consisting of:
1. **Query Processor (Relational Engine):** Parses, compiles, and optimizes queries.
2. **Storage Engine:** Reads/writes data pages, manages buffer pools, locks, and logs.  
📖 [Wikipedia: Database Engine](https://en.wikipedia.org/wiki/Database_engine)

### 127. What is query parsing?
The initial compilation step verifying SQL syntax, resolving object identifiers, validating semantics against system catalogs, and building an abstract parse tree.

### 128. What is collation?
Rules governing character sorting, casing (`CI` vs `CS`), and accent sensitivity (`AI` vs `AS`) in strings.  
📖 [Wikipedia: Collation](https://en.wikipedia.org/wiki/Collation)

### 129. What is SQL Injection?
A severe security vulnerability where untrusted user input is concatenated directly into executable dynamic SQL strings, enabling attackers to bypass authentication or execute arbitrary database commands.  
**Mitigation:** Parameterized queries, ORM mapping, and stored procedures with strict input escaping.  
📖 [Wikipedia: SQL Injection](https://en.wikipedia.org/wiki/SQL_injection)
