# sales-data-warehouse-sqlserver
# Sales Data Warehouse – AdventureWorks (Microsoft SQL Server)

This project implements a dimensional Data Warehouse based on the `AdventureWorks2022` sample database using **Microsoft SQL Server**. It follows a classical **star schema** and includes ETL processes and OLAP queries for multidimensional analysis.

Originally developed as part of a university course, the project has been restructured for personal use and professional demonstration.

---

## 🎯 Objectives

- Model and create a **star schema**-based data warehouse
- Implement a consistent ETL process (Extract – Transform – Load)
- Populate dimension and fact tables with real business data
- Run OLAP queries (`GROUP BY`, `CUBE`, `ROLLUP`, slicing) for advanced reporting

---

## 🧰 Technologies Used

- Microsoft SQL Server 2022
- SQL Server Management Studio (SSMS)
- Transact-SQL (T-SQL)
- AdventureWorks2022 dataset

---

## 📁 Repository Structure
sql/
│ ├── create_tables.sql # Definitions of dimension and fact tables
│ ├── add_foreign_keys.sql # Foreign key constraints added after table creation
│ ├── populate_tables.sql # ETL scripts to populate the Data Warehouse
│ └── olap_queries.sql # OLAP queries for business insights
│
├── schema/
  └── star_schema_diagram.png 

⚙️ Setup Instructions

1. Restore the `AdventureWorks2022` database in SQL Server.
2. Run `create_tables.sql` to create the star schema structure.
3. Run `add_foreign_keys.sql` to define referential integrity constraints.
4. Run `populate_tables.sql` to load data from AdventureWorks into your DWH.
5. Run `olap_queries.sql` to analyze the data using multidimensional techniques.

---

## 🔍 OLAP Operations Examples

- Total sales by product category
- Sales by year and month using `ROLLUP`
- Top salespeople by revenue and commission
- Sales by territory and store using `CUBE`
- Slicing sales data for a specific year

---

## 📎 Notes

- Time dimension (`DimDate`) is generated programmatically using a `WHILE` loop.
- Data is integrated and cleaned from multiple normalized sources in AdventureWorks.
- This project demonstrates strong understanding of dimensional modeling and data warehousing concepts.

---

