# MySQL & Database Practice Repository

This folder contains SQL practice scripts, query exercises, and database projects covering topics from basic `SELECT` and `INSERT` statements to advanced database concepts.

---

## Topics Covered

### 1. Basic Queries & Data Manipulation (DML)
* `SELECT`, `WHERE`, `ORDER BY`, `LIMIT`, `DISTINCT`
* `INSERT INTO` (single-row and multi-row insertion)
* `UPDATE` and `DELETE`
* Aggregate functions (`COUNT`, `SUM`, `AVG`, `MIN`, `MAX`), `GROUP BY`, and `HAVING`
* `JOIN` operations (`INNER`, `LEFT`, `RIGHT`, `CROSS`) and subqueries

### 2. Schema Design & Database Objects (DDL)
* `CREATE`, `ALTER`, `DROP`, `TRUNCATE`
* Primary Keys, Foreign Keys, and Constraints (`NOT NULL`, `UNIQUE`, `CHECK`, `DEFAULT`)
* Views, Indexes, Stored Procedures, and Triggers

### 3. Transaction Control Language (TCL)
* `START TRANSACTION` / `BEGIN`
* `COMMIT` (permanently saving changes)
* `ROLLBACK` (reverting uncommitted changes)
* `SAVEPOINT` and `ROLLBACK TO SAVEPOINT`
* ACID properties and transaction isolation levels

### 4. Row-Level Security & Access Control
* User management and privileges (`CREATE USER`, `GRANT`, `REVOKE`)
* **Row-Level Access / Security patterns:** Implementing row-level data filtering and access control in MySQL using `Views` with `USER()` / `CURRENT_USER()`, `Stored Procedures`, and role-based permissions

### 5. NoSQL & Semi-Structured Data
* Overview of NoSQL data models (Document, Key-Value, Column-Family, Graph) vs. Relational SQL
* Working with JSON in MySQL (`JSON` data type, `JSON_EXTRACT`, `->`, `->>`, and indexing generated columns)

---

## Folder Structure (Example)

```text
Course2-MYSQL/
├── 01_basics_select_insert/
├── 02_joins_subqueries_ddl/
├── 03_tcl_transactions/
├── 04_security_row_level_access/
├── 05_nosql_json/
└── README.md