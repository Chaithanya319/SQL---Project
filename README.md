# 🚚 Last-Mile Delivery Operations Analytics

## MySQL Business Analytics Project

### 📌 Project Overview

This project focuses on analysing last-mile delivery operations for **QuickRoute Logistics** using **MySQL and SQL**.

The objective is to understand delivery demand, customer behaviour, delivery performance, driver and vehicle utilization, and delivery problems. The analysis converts business requirements into SQL-based insights to support operational decision-making.

---

## 🎯 Business Objectives

- Understand delivery demand across different delivery zones and service types
- Analyse customer ordering behaviour
- Evaluate delivery performance and delivery outcomes
- Analyse driver and vehicle performance
- Identify delivery problems and multiple delivery attempts
- Generate meaningful business insights and recommendations

---

## 🗂️ Database Tables

The project contains five relational tables:

- `customers` – Customer details and customer types
- `orders` – Order details, service types, priorities, package weights, and order values
- `deliveries` – Delivery details, status, attempts, distance, and duration
- `drivers` – Driver details, employment type, ratings, and active status
- `vehicles` – Vehicle details, fuel type, payload capacity, depot, and active status

### 🔗 Table Relationships

```text
Customers
    |
    | customer_id
    ↓
Orders
    |
    | order_id
    ↓
Deliveries
   / \
  /   \
 ↓     ↓
Drivers  Vehicles
📊 Dataset Overview
Table	Rows	Columns
Customers	400	7
Orders	3,000	8
Deliveries	3,500	10
Drivers	80	6
Vehicles	50	7
🔍 Project Analysis
Sprint 1 – Business Understanding and Data Understanding
Company background and business context
Data Analyst role
ER diagram interpretation
Identification of tables, columns, keys, and relationships
Analytical thinking for business situations
Logical approach to solving business problems before writing SQL
Sprint 2 – Database Setup
Created the MySQL database based on the ER diagram
Created relational tables
Defined primary keys and foreign keys
Applied appropriate data types and constraints
Imported CSV datasets
Verified the imported data
Sprint 3 – Basic Analysis

The project includes SQL analysis for:

Total number of customers
Total number of orders
Total number of deliveries
Available service types
Active drivers
Available vehicle types
Total order value
Average package weight
Sprint 4 – Objective-Based Analysis
4.1 Delivery Demand
Orders across delivery zones
Orders by service type
Orders by priority
Order volume over time
Order value across different groups
4.2 Customer Order Behaviour
Customers with multiple orders
Customer order frequency
High-value customers
Customer activity by delivery zone
Business vs Individual customers
Customer ordering patterns over time
4.3 Delivery Performance
Delivery outcomes across zones
Delivery duration analysis
Delivery status analysis
Delivery activity across zones
Delivery performance over time
Delivery attempts
4.4 Driver and Vehicle Performance
Number of deliveries handled by drivers
Driver delivery outcomes
Driver ratings
Delivery duration across drivers
Vehicle utilization
Vehicle type usage
Delivery performance across vehicles
4.5 Delivery Problems
Deliveries requiring multiple attempts
Failed deliveries
Common delivery statuses
Problem patterns
Performance of orders with multiple attempts
Delivery problems across different zones
🛠️ Tools & Technologies
MySQL
SQL
MySQL Workbench
CSV
Git
GitHub
💡 SQL Concepts Used
CREATE DATABASE
CREATE TABLE
Primary Keys
Foreign Keys
SELECT
WHERE
GROUP BY
ORDER BY
HAVING
JOIN
LEFT JOIN
Aggregate Functions
COUNT()
SUM()
AVG()
MIN()
MAX()
CASE
Date Functions
Subqueries
Conditional Analysis
📁 Project Structure
Last-Mile-Delivery-Operations-Analytics/
│
├── README.md
│
├── database/
│   └── create_tables.sql
│
├── queries/
│   ├── sprint_3_basic_analysis.sql
│   ├── sprint_4_1_delivery_demand.sql
│   ├── sprint_4_2_customer_behaviour.sql
│   ├── sprint_4_3_delivery_performance.sql
│   ├── sprint_4_4_driver_vehicle_performance.sql
│   └── sprint_4_5_delivery_problems.sql
│
├── data/
│   ├── customers.csv
│   ├── orders.csv
│   ├── deliveries.csv
│   ├── drivers.csv
│   └── vehicles.csv
│
└── documentation/
    └── project_report.pdf
📈 Business Insights

The analysis is designed to identify:

High-demand delivery zones
Frequently used service types
Important customer segments
High-value and repeat customers
Delivery performance differences across zones
Drivers handling higher delivery volumes
Vehicle utilization patterns
Deliveries requiring multiple attempts
Areas with higher delivery problems
Relationships between package weight, distance, and delivery duration
