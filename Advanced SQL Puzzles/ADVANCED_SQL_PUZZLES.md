# Advanced SQL Puzzles: Problem Statements & Specifications

Author: **Scott Peters** | [https://advancedsqlpuzzles.com](https://advancedsqlpuzzles.com)  
Companion SQL Scripts:
- [`Advanced SQL Puzzles Solutions.sql`](file:///c:/Users/amitt/Documents/github/Advancesqlpuzzle/Advanced%20SQL%20Puzzles/Advanced%20SQL%20Puzzles%20Solutions.sql) (Complete T-SQL Solutions)
- [`Advanced SQL Puzzles DDL.sql`](file:///c:/Users/amitt/Documents/github/Advancesqlpuzzle/Advanced%20SQL%20Puzzles/Advanced%20SQL%20Puzzles%20DDL.sql) (DDL & Sample Data Only)

---

## Welcome

This catalog contains **55 challenging SQL puzzles** plus **11 mathematical and algorithmic bonus puzzles**.

These problems are designed to train data professionals to **think in sets**—leveraging declarative relational techniques (window functions, recursive CTEs, conditional aggregation, set operators, and cross joins) rather than imperative row-by-row constructs like cursors or iterative `WHILE` loops.

---

## Quick Navigation

| # | Puzzle Name | Focus / Technique |
|:---:|:---|:---|
| [1](#puzzle-1-shopping-carts) | Shopping Carts | `FULL OUTER JOIN` comparison |
| [2](#puzzle-2-managers-and-employees) | Managers and Employees | Recursive CTE hierarchy depth |
| [3](#puzzle-3-fiscal-year-table-constraints) | Fiscal Year Pay Rates | Declarative table constraints (`CHECK`, `PK`) |
| [4](#puzzle-4-two-predicates) | Two Predicates | Correlated subquery / relational division |
| [5](#puzzle-5-phone-directory) | Phone Directory | Column pivoting & conditional aggregation |
| [6](#puzzle-6-workflow-steps) | Workflow Steps | Incomplete workflow detection with `COUNT` |
| [7](#puzzle-7-mission-to-mars) | Mission to Mars | Relational division with candidate skill sets |
| [8](#puzzle-8-workflow-cases) | Workflow Cases | Boolean matrix aggregation |
| [9](#puzzle-9-matching-sets) | Matching Sets | Set equivalence matching |
| [10](#puzzle-10-mean-median-mode-and-range) | Mean, Median, Mode, and Range | Statistical measures in SQL |
| [11](#puzzle-11-permutations) | Permutations | Cross join combinatorics |
| [12](#puzzle-12-average-days) | Average Days | Date diffing & moving interval calculations |
| [13](#puzzle-13-inventory-tracking) | Inventory Tracking | Running totals via window `SUM()` |
| [14](#puzzle-14-indeterminate-process-log) | Indeterminate Process Log | Multi-state status reconciliation |
| [15](#puzzle-15-group-concatenation) | Group Concatenation | `STRING_AGG()` ordered aggregation |
| [16](#puzzle-16-reciprocals) | Reciprocals | Symmetric pair deduplication |
| [17](#puzzle-17-de-grouping) | De-Grouping | Tally table un-pivoting |
| [18](#puzzle-18-seating-chart) | Seating Chart | Gaps and islands analysis |
| [19](#puzzle-19-back-to-the-future) | Back to the Future | Merging overlapping date intervals |
| [20](#puzzle-20-price-points) | Price Points | Effective-date SCD point lookup |
| [21](#puzzle-21-average-monthly-sales) | Average Monthly Sales | Multi-level grouping & `HAVING` filters |
| [22](#puzzle-22-occurrences) | Occurrences | Mode frequency ranking via `DENSE_RANK()` |
| [23](#puzzle-23-divide-in-half) | Divide in Half | `NTILE(2)` percentile binning |
| [24](#puzzle-24-page-views) | Page Views | `OFFSET-FETCH` pagination |
| [25](#puzzle-25-top-vendors) | Top Vendors | Ranked customer vendor attribution |
| [26](#puzzle-26-previous-years-sales) | Previous Year's Sales | Cross-year pivot / `LAG()` comparisons |
| [27](#puzzle-27-delete-the-duplicates) | Delete the Duplicates | Set deduplication with `ROW_NUMBER()` |
| [28](#puzzle-28-fill-the-gaps) | Fill the Gaps | Last Non-Null Value ("Data Smear") |
| [29](#puzzle-29-count-the-groupings) | Count the Groupings | Consecutive run-length island counting |
| [30](#puzzle-30-select-star) | Select Star | Forcing compilation error on `SELECT *` |
| [31](#puzzle-31-second-highest) | Second Highest | Nth-highest value algorithms |
| [32](#puzzle-32-first-and-last) | First and Last | Extreme boundary lookups per group |
| [33](#puzzle-33-deadlines) | Deadlines | Cumulative assembly times vs delivery dates |
| [34](#puzzle-34-specific-exclusion) | Specific Exclusion | Predicate logic with negative conjunctions |
| [35](#puzzle-35-international-vs-domestic-sales) | International vs Domestic Sales | Exclusive OR (`XOR`) set classification |
| [36](#puzzle-36-traveling-salesman) | Traveling Salesman | Graph path finding and cost summation |
| [37](#puzzle-37-group-criteria-keys) | Group Criteria Keys | Dense rank multi-column key generation |
| [38](#puzzle-38-reporting-elements) | Reporting Elements | Dimension preservation with zero-filling |
| [39](#puzzle-39-prime-numbers) | Prime Numbers | Sieve and modulus factorization |
| [40](#puzzle-40-sort-order) | Sort Order | Custom expression sorting |
| [41](#puzzle-41-associate-ids) | Associate IDs | Connected component graph clustering |
| [42](#puzzle-42-mutual-friends) | Mutual Friends | Social graph edge analysis |
| [43](#puzzle-43-unbounded-preceding) | Unbounded Preceding | Running minimum window frame |
| [44](#puzzle-44-slowly-changing-dimension-part-i) | SCD Part I | Converting snapshots into Type 2 SCD ranges |
| [45](#puzzle-45-slowly-changing-dimension-part-ii) | SCD Part II | Overlapping validity date interval detection |
| [46](#puzzle-46-negative-account-balances) | Negative Account Balances | Identifying accounts with no positive balance |
| [47](#puzzle-47-work-schedule) | Work Schedule | Interval chopping and shift timeline fusion |
| [48](#puzzle-48-consecutive-sales) | Consecutive Sales | Consecutive annual streaks |
| [49](#puzzle-49-sumo-wrestlers) | Sumo Wrestlers | Cumulative weight cutoff (Knapsack constraint) |
| [50](#puzzle-50-baseball-balls-and-strikes) | Baseball Balls and Strikes | Stateful running event counters |
| [51](#puzzle-51-primary-key-creation) | Primary Key Creation | Deterministic surrogate keys via `HASHBYTES` |
| [52](#puzzle-52-phone-numbers-table) | Phone Numbers Table | Regex pattern check constraints |
| [53](#puzzle-53-spouse-ids) | Spouse IDs | Bidirectional relationship pairing |
| [54](#puzzle-54-winning-the-lottery) | Winning the Lottery | Match count scoring and payout rules |
| [55](#puzzle-55-table-audit) | Table Audit | Multi-way table comparison & mismatch audit |
| [Bonus](#additional-bonus-puzzles) | 11 Additional Puzzles | Permutations, games, Monte Carlo, and math |

---

## Puzzle Specifications

### Puzzle #1: Shopping Carts
**Requirement:** Audit two shopping carts. Match identical items and display unmatched items from each cart.
- **Input:** `#Cart1` (`Sugar`, `Bread`, `Juice`, `Soda`, `Flour`), `#Cart2` (`Sugar`, `Bread`, `Butter`, `Cheese`, `Fruit`).
- **Expected Output:**
  | Item Cart 1 | Item Cart 2 |
  |:---|:---|
  | `Sugar` | `Sugar` |
  | `Bread` | `Bread` |
  | `Juice` | *NULL* |
  | `Soda` | *NULL* |
  | `Flour` | *NULL* |
  | *NULL* | `Butter` |
  | *NULL* | `Cheese` |
  | *NULL* | `Fruit` |

---

### Puzzle #2: Managers and Employees
**Requirement:** Given an organizational table, determine the hierarchy depth level of each employee starting from the President (Depth = 0).
- **Input:** `#Employees` (`EmployeeID`, `ManagerID`, `JobTitle`, `Salary`).
- **Expected Output:**
  | Employee ID | Manager ID | Job Title | Salary | Depth |
  |:---:|:---:|:---|:---:|:---:|
  | 1001 | *NULL* | President | $185,000 | 0 |
  | 2002 | 1001 | Director | $120,000 | 1 |
  | 3003 | 1001 | Office Manager | $97,000 | 1 |
  | 4004 | 2002 | Engineer | $110,000 | 2 |
  | 5005 | 2002 | Engineer | $142,000 | 2 |
  | 6006 | 2002 | Engineer | $160,000 | 2 |

---

### Puzzle #3: Fiscal Year Table Constraints
**Requirement:** Enforce constraints on `#EmployeePayRecords` (`EmployeeID`, `FiscalYear`, `StartDate`, `EndDate`, `PayRate`):
1. Composite Primary Key on `(EmployeeID, FiscalYear)`.
2. `StartDate` must always be January 1st of `FiscalYear`.
3. `EndDate` must always be December 31st of `FiscalYear`.
4. `PayRate` must be greater than zero.

---

### Puzzle #4: Two Predicates
**Requirement:** For every customer who had at least one order delivered to California (`CA`), return all their orders delivered to Texas (`TX`).
- **Expected Output:** Orders `Ord143876`, `Ord654876`, `Ord814356` for Customer `1001`.

---

### Puzzle #5: Phone Directory
**Requirement:** Pivot customer phone numbers (`Cellular`, `Work`, `Home`) so each customer occupies a single row.
- **Expected Output:**
  | Customer ID | Cellular | Work | Home |
  |:---:|:---:|:---:|:---:|
  | 1001 | `555-897-5421` | `555-897-6542` | `555-698-9874` |
  | 2002 | `555-963-6544` | `555-812-9856` | *NULL* |
  | 3003 | `555-987-6541` | *NULL* | *NULL* |

---

### Puzzle #6: Workflow Steps
**Requirement:** Identify all workflows that have started (`Step 1` has a `CompletionDate`), but have not completed (at least one subsequent step has a `NULL` completion date).
- **Expected Output:** Workflows `Bravo` and `Charlie`.

---

### Puzzle #7: Mission to Mars
**Requirement:** Given mission skill requirements (`Geologist`, `Astrogator`, `Technician`), find all candidates who possess **all** required skills.
- **Expected Output:** Candidate `1001`.

---

### Puzzle #8: Workflow Cases
**Requirement:** Count the number of passed test cases (value = 1) across columns `Case 1`, `Case 2`, and `Case 3` per workflow.
- **Expected Output:** `Alpha: 0`, `Bravo: 2`, `Charlie: 1`, `Delta: 0`.

---

### Puzzle #9: Matching Sets
**Requirement:** Identify pairs of employees who hold the exact same set of professional licenses.
- **Expected Output:** Employee `1001` and Employee `2002` (both have `Class A`, `Class B`, `Class C`).

---

### Puzzle #10: Mean, Median, Mode, and Range
**Requirement:** Compute Mean (average), Median (50th percentile), Mode (most frequent), and Range ($\max - \min$) for an integer dataset: `5, 6, 10, 10, 13, 14, 17, 20, 81, 90, 76`.

---

### Puzzle #11: Permutations
**Requirement:** Given test cases `A`, `B`, `C`, generate all 6 ordered permutations ($3!$): `A,B,C`, `A,C,B`, `B,A,C`, `B,C,A`, `C,A,B`, `C,B,A`.

---

### Puzzle #12: Average Days
**Requirement:** Calculate the average elapsed days between consecutive workflow execution dates.
- **Expected Output:** `Alpha: 7`, `Bravo: 9`, `Charlie: 14`.

---

### Puzzle #13: Inventory Tracking
**Requirement:** Compute a chronological running balance of warehouse inventory given daily positive and negative quantity adjustments.

---

### Puzzle #14: Indeterminate Process Log
**Requirement:** Determine overall workflow status across multiple steps:
- All steps `Complete` $\rightarrow$ `Complete`
- All steps `Error` $\rightarrow$ `Error`
- Mix of `Complete` and `Running` $\rightarrow$ `Running`
- Mix containing `Error` with `Complete` or `Running` $\rightarrow$ `Indeterminate`

---

### Puzzle #15: Group Concatenation
**Requirement:** Group-concatenate ordered tokens into an executable SQL string:  
`SELECT Product, UnitPrice, EffectiveDate FROM Products WHERE UnitPrice > 100`.

---

### Puzzle #16: Reciprocals
**Requirement:** Consolidate symmetrical game scores between two players (`Player A`, `Player B`), combining `(3003, 4004)` and `(4004, 3003)` into a single aggregate total.
- **Expected Output:** `(1001, 2002): 150`, `(3003, 4004): 140`.

---

### Puzzle #17: De-Grouping
**Requirement:** Given products and quantities (`Pencil: 3`, `Eraser: 4`, `Notebook: 2`), expand the rows so each unit appears as an individual row of quantity 1.

---

### Puzzle #18: Seating Chart
**Requirement:** In a reserved seating chart (`7, 13, 14, 15, 27-35, 52-54`), report all continuous gaps of unreserved seats (`GapStart` to `GapEnd`), total missing count (38), and count of missing even/odd seats.

---

### Puzzle #19: Back to the Future
**Requirement:** Merge and consolidate continuous or overlapping date intervals into contiguous timeline blocks.
- **Input:** `1/15–1/19`, `1/12–1/16`, `1/10–1/11`, `1/3–1/9`, `1/1–1/5`.
- **Expected Output:** `1/12/2018–1/19/2018`, `1/10/2018–1/11/2018`, `1/1/2018–1/9/2018`.

---

### Puzzle #20: Price Points
**Requirement:** Retrieve the latest active unit price for each product as of the current date.

---

### Puzzle #21: Average Monthly Sales
**Requirement:** Return states where customer average monthly sales consistently exceed $100 across every month recorded.
- **Expected Output:** `Texas (TX)`.

---

### Puzzle #22: Occurrences
**Requirement:** For each distinct log message, return the workflow in which it occurred the highest number of times.

---

### Puzzle #23: Divide in Half
**Requirement:** Rank players by score into two equal halves (Top 50% = 1, Bottom 50% = 2) using `NTILE(2)`.

---

### Puzzle #24: Page Views
**Requirement:** Retrieve rows 10 through 20 from a table containing 1,000 unique records using standard pagination syntax (`OFFSET 9 ROWS FETCH NEXT 11 ROWS ONLY`).

---

### Puzzle #25: Top Vendors
**Requirement:** Return the vendor from which each customer has placed the highest order count.
- **Expected Output:** `Customer 1001: Direct Parts`, `Customer 2002: ACME`.

---

### Puzzle #26: Previous Year's Sales
**Requirement:** Pivot annual sales into columns displaying current year (`2018`), prior year (`2017`), and two years prior (`2016`).

---

### Puzzle #27: Delete the Duplicates
**Requirement:** Delete duplicate integer entries from `#SampleData` in-place, keeping only one instance of each distinct value.

---

### Puzzle #28: Fill the Gaps (Data Smear / Flash Fill)
**Requirement:** Propagate the most recent non-null `Workflow` label downward into subsequent rows until a new workflow begins.

---

### Puzzle #29: Count the Groupings
**Requirement:** Count consecutive runs of identical statuses (`Passed`, `Failed`) and return their start/end step boundaries and length.

---

### Puzzle #30: Select Star
**Requirement:** Add an invisible or pseudo-column to `#Products` (such as a hidden column or dropped constraint) such that running `SELECT * FROM #Products` fails with an engine error.

---

### Puzzle #31: Second Highest
**Requirement:** Write multiple declarative queries returning the second highest integer from a sequence.

---

### Puzzle #32: First and Last
**Requirement:** For each job description, identify the Spaceman ID with the highest mission count (Most Experienced) and lowest mission count (Least Experienced).

---

### Puzzle #33: Deadlines
**Requirement:** Compare promised delivery dates against total assembly days required across manufactured subcomponents. Return orders that can be fulfilled on time.

---

### Puzzle #34: Specific Exclusion
**Requirement:** Filter a customer orders dataset to exclude only orders where `CustomerID = 1001 AND Amount = $50` without accidentally eliminating other records.

---

### Puzzle #35: International vs Domestic Sales
**Requirement:** Find sales representatives who have closed *either* domestic sales *or* international sales, but **not both** (logical XOR).

---

### Puzzle #36: Traveling Salesman
**Requirement:** Using graph edge traversal, determine all possible flight paths from Austin to Des Moines, identifying the cheapest and most expensive routes.

---

### Puzzle #37: Group Criteria Keys
**Requirement:** Assign a sequential integer `CriteriaID` to each distinct combination of `Distributor`, `Facility`, and `Zone` using `DENSE_RANK()`.

---

### Puzzle #38: Reporting Elements
**Requirement:** Generate a comprehensive cross-tabular report showing sales for every distributor across every region, outputting `$0` where no sales occurred.

---

### Puzzle #39: Prime Numbers
**Requirement:** Write an SQL query to determine which integers in `#SampleData (1..10)` are prime numbers.

---

### Puzzle #40: Sort Order
**Requirement:** Sort the cities `Atlanta`, `Baltimore`, `Chicago`, `Denver` into the custom sequence: `Baltimore`, `Denver`, `Atlanta`, `Chicago`.

---

### Puzzle #41: Associate IDs
**Requirement:** Cluster bidirectional associate pairs into connected group networks.

---

### Puzzle #42: Mutual Friends
**Requirement:** Given social connections, calculate the total count of mutual friends between every pair of individuals.

---

### Puzzle #43: Unbounded Preceding
**Requirement:** Calculate the running minimum quantity from the start of each customer's history up to the current row using window framing (`MIN(Quantity) OVER (PARTITION BY CustomerID ORDER BY [Order] ROWS UNBOUNDED PRECEDING)`).

---

### Puzzle #44: Slowly Changing Dimension Part I
**Requirement:** Convert point-in-time balance snapshot records into a contiguous Type 2 SCD table with `StartDate` and `EndDate` (capping active rows with `12/31/9999`).

---

### Puzzle #45: Slowly Changing Dimension Part II
**Requirement:** Identify customer records that contain invalid overlapping time intervals.

---

### Puzzle #46: Negative Account Balances
**Requirement:** Return accounts that have never had a positive balance, written via 5 different SQL constructs (`HAVING`, `NOT EXISTS`, `EXCEPT`, `NOT IN`, `LEFT JOIN`).

---

### Puzzle #47: Work Schedule
**Requirement:** Given shift start/end times and scheduled activities (meetings, breaks), fill gaps with `Work` intervals to create a seamless schedule.

---

### Puzzle #48: Consecutive Sales
**Requirement:** Return customer IDs that generated at least one sale in the current year and each of the previous two consecutive years.

---

### Puzzle #49: Sumo Wrestlers
**Requirement:** Given a queue of Sumo wrestlers entering an elevator with a 2,000-pound limit, determine the last wrestler who can board before the limit is exceeded.

---

### Puzzle #50: Baseball Balls and Strikes
**Requirement:** Given pitch-by-pitch at-bat outcomes, compute the running ball and strike count before and after each pitch, adhering to baseball rules (maximum 4 balls, 3 strikes; fouls cannot produce strike 3).

---

### Puzzle #51: Primary Key Creation
**Requirement:** Generate unique, reproducible surrogate primary keys from compound attributes (`AssemblyID`, `Part`) using `HASHBYTES('SHA2_256', ...)` and `CHECKSUM()`.

---

### Puzzle #52: Phone Numbers Table
**Requirement:** Apply a table `CHECK` constraint validating that phone numbers strictly adhere to the mask `(999)-999-9999` using `LIKE '([0-9][0-9][0-9])-[0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]'`.

---

### Puzzle #53: Spouse IDs
**Requirement:** Match married couples where each spouse appears as both `PrimaryID` and `SpouseID`, assigning a single canonical `GroupID` to each couple.

---

### Puzzle #54: Winning the Lottery
**Requirement:** Calculate office lottery pool winnings: $100 if a ticket matches all winning numbers, $10 if it matches some (but not all) numbers.

---

### Puzzle #55: Table Audit
**Requirement:** Compare `#ProductsA` and `#ProductsB` in a single pass, categorizing records into:
1. `Matches in both tables`
2. `Product does not exist in table A`
3. `Product does not exist in table B`
4. `Quantity in table A and table B do not match`

---

## Additional Bonus Puzzles

### Bonus Puzzle #1: Double or Add 1
Starting with 10 cents ($0.10), in each iteration you may double your balance or add $1.00. What is the minimum number of steps required to reach exactly or exceed $1,000,000?

### Bonus Puzzle #2: Dice Throw Game
Given a 6-sided die, roll repeatedly to reach 100 points:
- Rolls 1–5: Add face value to score.
- Roll 6: Re-roll and subtract face value (score cannot drop below 0).
Compute the average, minimum, and maximum rolls needed across 1,000,000 Monte Carlo trials.

### Bonus Puzzle #3: The Josephus Problem
$N$ people stand in a circle. Every $k$-th person is eliminated until one remains. Determine the surviving position using recursive modular arithmetic.

### Bonus Puzzle #4: Non-Adjacent Numbers
Given numbers $1, 2, \dots, 10$, determine the number of permutations where no two adjacent positions contain consecutive integers.

### Bonus Puzzle #5: Add the Numbers Up
Insert `+` or `-` operators between the digits $1, 2, 3, 4, 5, 6, 7, 8, 9, 10$ (or concatenate them into multi-digit numbers). Compute all possible permutations and resulting sums.

### Bonus Puzzle #6: High-Low Card Game
Simulate a full deck traversal of the card game High-Low, choosing Higher or Lower based on bayesian probability of remaining cards.

### Bonus Puzzle #7: Pascal's Triangle
Compute Pascal's Triangle coefficients using combinatorial binomial expansions:
$$\binom{n}{k} = \frac{n!}{k!(n-k)!}$$

### Bonus Puzzle #8: Binary Permutations
Generate all $2^6 = 64$ binary permutations of length 6 (`000000` to `111111`).

### Bonus Puzzle #9: Permutations 1 through 10
Generate all 2-digit ordered permutations from $\{1, \dots, 10\}$.

### Bonus Puzzle #10: Parametric Monty Hall Simulation
Simulate the Monty Hall problem with $N$ doors, $G$ goats/prizes, $C$ contestant choices, and $H$ doors revealed by the host.

### Bonus Puzzle #11: Four Vehicles Combinatorics
Given 4 vehicles (1-seat motorcycle, 2-seat sidecar, 3-seat golf cart, 4-seat car) and 10 people (5 adults, 5 children), with the constraint that only an adult can drive each vehicle:  
Calculate and generate all 7,200 valid seating allocations:
$$\text{Arrangements} = \frac{5!}{1!} \times \frac{6!}{3! \times 2! \times 1! \times 0!} = 7,200$$
