/* LAST-MILE DELIVERY OPERATIONS ANALYTICS

MySQL Business Analytics Project

SPRINT 1: BUSINESS UNDERSTANDING AND DATA UNDERSTANDING

1.1 COMPANY BACKGROUND

QuickRoute Logistics is a last-mile delivery company serving customers across multiple delivery zones. The company manages customer orders, delivery operations, drivers, and vehicles to fulfil customer deliveries.
The Operations team wants to use data to understand delivery demand, customer ordering behaviour, delivery performance, driver and vehicle utilization, and operational problems.
The purpose of this project is to analyse the company's delivery operations using MySQL and provide meaningful business insights to support operational decision-making.

1.2 ROLE

Assume the role of a Data Analyst supporting the Operations team.
The responsibility is to understand the business and database structure, create the MySQL database, import and validate the data, formulate analytical questions, write SQL queries, analyse delivery operations, and provide business insights and recommendations.

1.3 ER DIAGRAM INTERPRETATION

The project contains five tables:

customers
orders
deliveries
drivers
vehicles

PRIMARY KEYS
customers       → customer_id
orders          → order_id
deliveries      → delivery_id
drivers         → driver_id
vehicles        → vehicle_id

FOREIGN KEYS
orders.customer_id
    → customers.customer_id
deliveries.order_id
    → orders.order_id
deliveries.driver_id
    → drivers.driver_id
deliveries.vehicle_id
    → vehicles.vehicle_id

RELATIONSHIPS
One customer can place many orders.
One order can have many delivery records.
One driver can handle many deliveries.
One vehicle can be used for many deliveries.

RELATIONSHIP FLOW
customers → orders → deliveries
drivers → deliveries
vehicles → deliveries

COMPLETE RELATIONSHIP STRUCTURE
customers
    |
    | customer_id
    ↓
orders
    |
    | order_id
    ↓
deliveries
   / \
  /   \
 ↓     ↓
drivers vehicles

1.4 ANALYTICAL THINKING FROM THE ER DIAGRAM

QUESTION 1
Management wants to find customers who have placed multiple orders. What information would you need to identify them?
Answer:
The customers and orders tables are required.
Columns:
customers.customer_id
customers.customer_name
orders.customer_id
orders.order_id
The customer_id connects customers with their orders. The number of orders can be counted for each customer to identify customers who have placed multiple orders.

QUESTION 2
The Operations team wants to identify orders that required more than one delivery attempt. Where would you find the information needed to investigate this?
Answer:
The deliveries table is required.
Columns:
delivery_id
order_id
delivery_attempt
status
The order_id identifies the order associated with the delivery, while delivery_attempt indicates how many attempts were made.

QUESTION 3
The Customer team wants to compare Business and Individual customers based on their ordering activity. Which tables and columns would you need?
Answer:
The customers and orders tables must be connected.
Columns:
customers.customer_id
customers.customer_type
orders.customer_id
orders.order_id
orders.total_value
The customer_type can be used to compare Business and Individual customers based on order count and total order value.

QUESTION 4
The Operations team wants to compare different service types based on how far deliveries travel and how long they take. Which tables would you need to connect?
Answer:
The orders and deliveries tables are required.
Columns:
orders.order_id
orders.service_type
deliveries.order_id
deliveries.distance_km
deliveries.delivery_duration_min
The order_id connects the order with its delivery information.

QUESTION 5
The team wants to identify which drivers have handled deliveries and examine their recorded ratings. What information would you need?
Answer:
The drivers and deliveries tables are required.
Columns:
drivers.driver_id
drivers.driver_name
drivers.rating
deliveries.driver_id
deliveries.delivery_id
deliveries.status
The driver_id connects each driver with the deliveries they handled.

QUESTION 6
Operations wants to understand whether different types of vehicles are being used for different deliveries. Which tables and columns would you need?
Answer:
The vehicles and deliveries tables are required.
Columns:
vehicles.vehicle_id
vehicles.vehicle_type
vehicles.fuel_type
deliveries.vehicle_id
deliveries.delivery_id
deliveries.status
The vehicle_id connects vehicles with their delivery records.

QUESTION 7
Management wants to compare delivery performance across different delivery zones. What information would you need from the database?
Answer:
The orders and deliveries tables must be connected.
Columns:
orders.order_id
orders.delivery_zone_id
deliveries.order_id
deliveries.status
deliveries.delivery_duration_min
deliveries.distance_km
deliveries.delivery_attempt
The delivery_zone_id is available in the orders table, while delivery performance information is available in the deliveries table.

QUESTION 8
The Operations team wants to investigate whether heavier packages are associated with longer delivery durations. Which information would you need, and where would you find it?
Answer:
The orders and deliveries tables are required.
Columns:
orders.order_id
orders.package_weight_kg
deliveries.order_id
deliveries.delivery_duration_min
The order_id connects package information with delivery duration.

QUESTION 9
Management wants to understand whether delivery outcomes differ across service types. What tables and information would you bring together?
Answer:
The orders and deliveries tables should be connected.
Columns:
orders.order_id
orders.service_type
deliveries.order_id
deliveries.status
The service_type identifies the delivery service, while status identifies the delivery outcome.

QUESTION 10
The Operations team wants to understand which customers have placed orders and how their orders are being handled. What information would you need to connect a customer with their orders and deliveries?
Answer:
The customers, orders, and deliveries tables are required.
Relationships:
customers.customer_id
    →
orders.customer_id
orders.order_id
    →
deliveries.order_id
Therefore, the relationship is:
customers → orders → deliveries
The required information includes customer details, order information, and delivery status, attempts, drivers and vehicles.
*/


/* -- SPRINT 2: DATABASE SETUP

-- 2.1 CREATE DATABASE
CREATE DATABASE quickroute_logistics_analytics;
USE quickroute_logistics_analytics;

-- 2.2 CREATE CUSTOMERS TABLE
CREATE TABLE customers (
    customer_id VARCHAR(20) PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    city VARCHAR(50) NOT NULL,
    delivery_zone_id VARCHAR(10) NOT NULL,
    preferred_time_slot VARCHAR(30) NOT NULL,
    customer_type VARCHAR(20) NOT NULL,
    account_since DATE NOT NULL
);

-- 2.3 CREATE DRIVERS TABLE
CREATE TABLE drivers (
    driver_id VARCHAR(10) PRIMARY KEY,
    driver_name VARCHAR(100) NOT NULL,
    hire_date DATE NOT NULL,
    rating DECIMAL(3,2) NOT NULL,
    employment_type VARCHAR(20) NOT NULL,
    is_active VARCHAR(3) NOT NULL
);

-- 2.4 CREATE VEHICLES TABLE
CREATE TABLE vehicles (
    vehicle_id VARCHAR(10) PRIMARY KEY,
    vehicle_type VARCHAR(20) NOT NULL,
    fuel_type VARCHAR(20) NOT NULL,
    max_payload_kg DECIMAL(7,2) NOT NULL,
    depot VARCHAR(10) NOT NULL,
    last_service_date DATE NOT NULL,
    is_active VARCHAR(3) NOT NULL
);

-- 2.5 CREATE ORDERS TABLE
CREATE TABLE orders (
    order_id VARCHAR(20) PRIMARY KEY,
    customer_id VARCHAR(20) NOT NULL,
    order_date DATE NOT NULL,
    delivery_zone_id VARCHAR(10) NOT NULL,
    package_weight_kg DECIMAL(5,2) NOT NULL,
    service_type VARCHAR(20) NOT NULL,
    priority VARCHAR(10) NOT NULL,
    total_value DECIMAL(10,2) NOT NULL,


    FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id)
);

-- 2.6 CREATE DELIVERIES TABLE
CREATE TABLE deliveries (
    delivery_id VARCHAR(20) PRIMARY KEY,
    order_id VARCHAR(20) NOT NULL,
    driver_id VARCHAR(10) NOT NULL,
    vehicle_id VARCHAR(10) NOT NULL,
    assigned_date DATE NOT NULL,
    actual_delivery_date DATE,
    status VARCHAR(20) NOT NULL,
    delivery_attempt TINYINT NOT NULL,
    distance_km DECIMAL(6,2) NOT NULL,
    delivery_duration_min INT NOT NULL,


    FOREIGN KEY (order_id)
        REFERENCES orders(order_id),


    FOREIGN KEY (driver_id)
        REFERENCES drivers(driver_id),


    FOREIGN KEY (vehicle_id)
        REFERENCES vehicles(vehicle_id)
);

-- 2.7 CHECK TABLES
SHOW TABLES;

--- Select the project database
USE quickroute_logistics_analytics;

-- Verify all five tables
SHOW TABLES;
TRUNCATE TABLE deliveries;

ALTER TABLE deliveries
MODIFY actual_delivery_date VARCHAR(20) NULL;

-- Verify the number of records imported

SELECT 'customers' AS table_name, COUNT(*) AS total_rows
FROM customers

UNION ALL

SELECT 'drivers', COUNT(*)
FROM drivers

UNION ALL

SELECT 'vehicles', COUNT(*)
FROM vehicles

UNION ALL

SELECT 'orders', COUNT(*)
FROM orders

UNION ALL

SELECT 'deliveries', COUNT(*)
FROM deliveries;

-- Check table structures
DESCRIBE customers;

DESCRIBE drivers;

DESCRIBE vehicles;

DESCRIBE orders;

DESCRIBE deliveries;
*/


/* SPRINT 3: BASIC ANALYSIS / DATA EXPLORATION

USE quickroute_logistics_analytics;

-- QUESTION 1
What is the total number of customers?

SELECT COUNT(*) AS total_customers
FROM customers;

-- QUESTION 2
What is the total number of orders?

SELECT COUNT(*) AS total_orders
FROM orders;

-- QUESTION 3
What is the total number of deliveries?

SELECT COUNT(*) AS total_deliveries
FROM deliveries;

-- QUESTION 4
What are the different service types available?

SELECT DISTINCT service_type
FROM orders
ORDER BY service_type;

-- QUESTION 5
How many drivers are currently active?

SELECT COUNT(*) AS active_drivers
FROM drivers
WHERE is_active = 'Yes';

-- QUESTION 6
What are the different vehicle types?

SELECT DISTINCT vehicle_type
FROM vehicles
ORDER BY vehicle_type;

-- QUESTION 7
What is the total order value?

SELECT
    ROUND(SUM(total_value), 2)
        AS total_order_value
FROM orders;

-- QUESTION 8
What is the average package weight?

SELECT
    ROUND(AVG(package_weight_kg), 2)
        AS average_package_weight
FROM orders;
*/

/* SPRINT 4: OBJECTIVE-BASED ANALYSIS

The following analytical questions are formulated from the five Sprint 4 objectives.

The queries are used to analyse:

delivery demand
customer order behaviour
delivery performance
driver and vehicle performance
delivery problems

/* 4.1 UNDERSTAND DELIVERY DEMAND

-- QUESTION 4.1.1
Which delivery zones have the highest order volume?
SELECT
    delivery_zone_id,
    COUNT(order_id) AS order_volume
FROM orders
GROUP BY delivery_zone_id
ORDER BY order_volume DESC;

-- QUESTION 4.1.2
How does order volume differ across service types?
SELECT
    service_type,
    COUNT(order_id) AS order_volume
FROM orders
GROUP BY service_type
ORDER BY order_volume DESC;

-- QUESTION 4.1.3
How does order volume differ across priority levels?
SELECT
    priority,
    COUNT(order_id) AS order_volume
FROM orders
GROUP BY priority
ORDER BY order_volume DESC;

-- QUESTION 4.1.4
How does order demand change over time?
SELECT
    YEAR(order_date) AS order_year,
    MONTH(order_date) AS order_month,
    COUNT(order_id) AS order_volume
FROM orders
GROUP BY
    YEAR(order_date),
    MONTH(order_date)
ORDER BY
    order_year,
    order_month;

-- QUESTION 4.1.5
Which delivery zones contribute the highest order value?
SELECT
    delivery_zone_id,
    COUNT(order_id) AS order_volume,
    ROUND(SUM(total_value), 2) AS total_order_value
FROM orders
GROUP BY delivery_zone_id
ORDER BY total_order_value DESC;

/*
-- 4.2 UNDERSTAND CUSTOMER ORDER BEHAVIOUR

-- QUESTION 4.2.1
Which customers have the highest number of orders?
SELECT
    c.customer_id,
    c.customer_name,
    COUNT(o.order_id) AS order_count
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY
    c.customer_id,
    c.customer_name
ORDER BY order_count DESC;
 
 -- QUESTION 4.2.2
Which customers have the highest cumulative order value?
SELECT
    c.customer_id,
    c.customer_name,
    ROUND(SUM(o.total_value), 2)
        AS cumulative_order_value
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY
    c.customer_id,
    c.customer_name
ORDER BY cumulative_order_value DESC;
 
 -- QUESTION 4.2.3
How does customer activity differ across delivery zones?
SELECT
    c.delivery_zone_id,
    COUNT(DISTINCT c.customer_id) AS customer_count,
    COUNT(o.order_id) AS order_count
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY c.delivery_zone_id
ORDER BY order_count DESC;

-- QUESTION 4.2.4
How do Business and Individual customers differ in ordering activity?
SELECT
    c.customer_type,
    COUNT(DISTINCT c.customer_id) AS customer_count,
    COUNT(o.order_id) AS order_count,
    ROUND(SUM(o.total_value), 2)
        AS total_order_value
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_type
ORDER BY order_count DESC;

-- QUESTION 4.2.5
How do customer ordering patterns change over time?
SELECT
    YEAR(o.order_date) AS order_year,
    MONTH(o.order_date) AS order_month,
    c.customer_type,
    COUNT(o.order_id) AS order_count
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY
    YEAR(o.order_date),
    MONTH(o.order_date),
    c.customer_type
ORDER BY
    order_year,
    order_month,
    c.customer_type;
    
--- 4.3 EVALUATE DELIVERY PERFORMANCE

-- QUESTION 4.3.1
How do delivery outcomes differ across delivery zones?
SELECT
    o.delivery_zone_id,
    d.status,
    COUNT(d.delivery_id) AS delivery_count
FROM orders o
JOIN deliveries d
    ON o.order_id = d.order_id
GROUP BY
    o.delivery_zone_id,
    d.status
ORDER BY
    o.delivery_zone_id,
    delivery_count DESC;

-- QUESTION 4.3.2
What are the average delivery distance and delivery duration?
SELECT
    ROUND(AVG(distance_km), 2)
        AS average_distance_km,
    ROUND(AVG(delivery_duration_min), 2)
        AS average_delivery_duration
FROM deliveries;

-- QUESTION 4.3.3
How many deliveries are Delivered, Failed, Pending, and Rescheduled?
SELECT
    status,
    COUNT(*) AS delivery_count
FROM deliveries
GROUP BY status
ORDER BY delivery_count DESC;

-- QUESTION 4.3.4
Which zones have higher delivery activity or poorer outcomes?
SELECT
    o.delivery_zone_id,
    COUNT(d.delivery_id) AS total_deliveries,
    SUM(
        CASE
            WHEN d.status IN
                ('Failed', 'Pending', 'Rescheduled')
            THEN 1
            ELSE 0
        END
    ) AS problem_deliveries
FROM orders o
JOIN deliveries d
    ON o.order_id = d.order_id
GROUP BY o.delivery_zone_id
ORDER BY
    problem_deliveries DESC,
    total_deliveries DESC;

-- QUESTION 4.3.5
How does delivery performance change over time?
SELECT
    YEAR(actual_delivery_date) AS delivery_year,
    MONTH(actual_delivery_date) AS delivery_month,
    COUNT(delivery_id) AS delivery_count,
    ROUND(
        AVG(delivery_duration_min),
        2
    ) AS average_delivery_duration
FROM deliveries
WHERE actual_delivery_date IS NOT NULL
GROUP BY
    YEAR(actual_delivery_date),
    MONTH(actual_delivery_date)
ORDER BY
    delivery_year,
    delivery_month;
    
---- 4.4 UNDERSTAND DRIVER AND VEHICLE PERFORMANCE

-- QUESTION 4.4.1
Which drivers handled the highest number of deliveries?
SELECT
    dr.driver_id,
    dr.driver_name,
    COUNT(d.delivery_id) AS delivery_count
FROM drivers dr
JOIN deliveries d
    ON dr.driver_id = d.driver_id
GROUP BY
    dr.driver_id,
    dr.driver_name
ORDER BY delivery_count DESC;
--- QUESTION 4.4.2
How do driver delivery outcomes compare?
SELECT
    dr.driver_id,
    dr.driver_name,
    d.status,
    COUNT(d.delivery_id) AS delivery_count
FROM drivers dr
JOIN deliveries d
    ON dr.driver_id = d.driver_id
GROUP BY
    dr.driver_id,
    dr.driver_name,
    d.status
ORDER BY
    dr.driver_name,
    delivery_count DESC;
-- QUESTION 4.4.3
How does delivery duration differ across drivers?
SELECT
    dr.driver_id,
    dr.driver_name,
    COUNT(d.delivery_id) AS delivery_count,
    ROUND(
        AVG(d.delivery_duration_min),
        2
    ) AS average_delivery_duration
FROM drivers dr
JOIN deliveries d
    ON dr.driver_id = d.driver_id
GROUP BY
    dr.driver_id,
    dr.driver_name
ORDER BY average_delivery_duration DESC;

-- QUESTION 4.4.4
How is vehicle usage distributed across vehicle types?
SELECT
    v.vehicle_type,
    COUNT(d.delivery_id) AS delivery_count
FROM vehicles v
JOIN deliveries d
    ON v.vehicle_id = d.vehicle_id
GROUP BY v.vehicle_type
ORDER BY delivery_count DESC;

-- QUESTION 4.4.5
How does delivery performance differ across vehicle types?
SELECT
    v.vehicle_type,
    COUNT(d.delivery_id) AS delivery_count,
    ROUND(
        AVG(d.delivery_duration_min),
        2
    ) AS average_delivery_duration,
    ROUND(
        AVG(d.distance_km),
        2
    ) AS average_distance
FROM vehicles v
JOIN deliveries d
    ON v.vehicle_id = d.vehicle_id
GROUP BY v.vehicle_type
ORDER BY delivery_count DESC;

--- 4.5 IDENTIFY DELIVERY PROBLEMS

-- QUESTION 4.5.1
Which orders required multiple delivery attempts?
SELECT
    order_id,
    COUNT(*) AS delivery_attempt_count
FROM deliveries
GROUP BY order_id
HAVING COUNT(*) > 1
ORDER BY delivery_attempt_count DESC;

-- QUESTION 4.5.2
What are the common delivery problem statuses?
SELECT
    status,
    COUNT(*) AS delivery_count
FROM deliveries
WHERE status IN
    ('Failed', 'Pending', 'Rescheduled')
GROUP BY status
ORDER BY delivery_count DESC;
--- QUESTION 4.5.3
Is delivery duration higher for deliveries requiring multiple attempts?
SELECT
    CASE
        WHEN delivery_attempt > 1
        THEN 'Multiple Attempts'
        ELSE 'Single Attempt'
    END AS attempt_category,
    COUNT(*) AS delivery_count,
    ROUND(
        AVG(delivery_duration_min),
        2
    ) AS average_delivery_duration
FROM deliveries
GROUP BY
    CASE
        WHEN delivery_attempt > 1
        THEN 'Multiple Attempts'
        ELSE 'Single Attempt'
    END
ORDER BY average_delivery_duration DESC;

-- QUESTION 4.5.4
Which delivery zones have more failed, pending, or rescheduled deliveries?
SELECT
    o.delivery_zone_id,
    d.status,
    COUNT(d.delivery_id) AS problem_count
FROM orders o
JOIN deliveries d
    ON o.order_id = d.order_id
WHERE d.status IN
    ('Failed', 'Pending', 'Rescheduled')
GROUP BY
    o.delivery_zone_id,
    d.status
ORDER BY problem_count DESC;
-- QUESTION 4.5.5
Is package weight associated with delivery duration?
SELECT
    CASE
        WHEN o.package_weight_kg <= 10
            THEN '0-10 kg'
        WHEN o.package_weight_kg <= 25
            THEN '10-25 kg'
        WHEN o.package_weight_kg <= 40
            THEN '25-40 kg'
        ELSE 'Above 40 kg'
    END AS weight_category,
    COUNT(d.delivery_id) AS delivery_count,
    ROUND(
        AVG(d.delivery_duration_min),
        2
    ) AS average_delivery_duration
FROM orders o
JOIN deliveries d
    ON o.order_id = d.order_id
GROUP BY
    CASE
        WHEN o.package_weight_kg <= 10
            THEN '0-10 kg'
        WHEN o.package_weight_kg <= 25
            THEN '10-25 kg'
        WHEN o.package_weight_kg <= 40
            THEN '25-40 kg'
        ELSE 'Above 40 kg'
    END
ORDER BY average_delivery_duration DESC;
*/

/* FINDINGS
1. QuickRoute Logistics contains 400 customers, 3,000 orders,
3,500 delivery records, 80 drivers, and 50 vehicles.

2. ZONE0005 records the highest order volume with 240 orders,
making it one of the most important delivery zones for demand planning.

3. Standard service records the highest order volume among the
available service types.

4. High-priority orders represent the largest priority category
with 1,035 orders.

5. Order demand increased significantly over time, from 608 orders
in 2022 to 1,229 orders in 2024.

6. Individual customers represent the larger customer segment
and contribute the highest overall number of orders and order value.

7. The highest-volume customer placed 19 orders, showing that
some customers have considerably higher ordering activity.

8. Delivered is the dominant delivery outcome, accounting for
2,581 of the 3,500 delivery records.

9. ZONE0020 has the lowest delivery success rate among the zones,
indicating a potential operational problem area.

10. Express service has the highest delivered percentage, while
Economy service has the highest failure percentage.

11. Cargo Bikes and Trucks handle the largest number of deliveries,
indicating high utilization of these vehicle types.

12. Motorbikes have the shortest average delivery duration,
while Trucks and Electric Vans show strong delivery outcomes.

13. A total of 165 delivery records required more than one attempt,
representing approximately 4.71% of delivery records.

14. ZONE0019 has the highest multiple-attempt delivery rate,
while ZONE0020 also shows relatively high repeated-attempt activity.

15. Package weight does not show a strong relationship with
delivery duration in the available dataset.
*/

/* BUSINESS INSIGHTS
1. High-demand delivery zones should receive sufficient driver
and vehicle capacity to handle order volumes efficiently.

2. ZONE0005 should be closely monitored because it has the highest
order volume and represents an important area of delivery demand.

3. The increase in order volume between 2022 and 2024 indicates
growing delivery demand and the need for future capacity planning.

4. Individual customers generate the largest overall demand,
while Business customers remain an important customer segment.

5. High-frequency customers should be monitored because they
represent repeat business and may be important for customer retention.

6. Delivery outcomes vary across zones, with ZONE0020 showing
weaker delivery performance and therefore requiring investigation.

7. Economy service should be reviewed because it has weaker
delivery outcomes compared with higher-performing services.

8. Cargo Bikes and Trucks have high delivery utilization,
so their availability should be considered when planning capacity.

9. Drivers should be evaluated using delivery volume, success rate,
duration, and rating rather than using rating alone.

10. Multiple delivery attempts increase operational effort and
should be investigated to identify the underlying causes.

11. Zones with high failed, pending, rescheduled, or repeated-attempt
deliveries should receive additional operational attention.

12. Package weight does not appear to be a major factor affecting
delivery duration in the current dataset.

13. Overall, the analysis can help QuickRoute improve delivery
planning, resource allocation, customer service, and operational efficiency.
*/

/*FINAL CONCLUSION

The Last-Mile Delivery Operations Analytics project successfully used MySQL to analyse QuickRoute Logistics' delivery operations. The project covered database design, ER diagram interpretation, CSV data import, data exploration, and objective-based business analysis.
The analysis identified important patterns in delivery demand, customer order behaviour, delivery performance, driver and vehicle utilization, and delivery problems.
The results show that delivery demand has increased over time, with certain zones generating significantly higher order volumes. Delivery performance also varies across zones and service types, highlighting areas that require operational attention.
The analysis further identified differences in driver and vehicle utilization and showed that repeated delivery attempts are an important operational issue. These findings can help the Operations team improve resource allocation, delivery planning, service performance, and customer experience.
Overall, the project demonstrates how MySQL and business analytics can support data-driven decision-making in last-mile delivery operations.
*/

/* PRACTICAL RECOMMENDATIONS

1. Allocate additional delivery resources to high-demand zones.

2. Closely monitor ZONE0005 because of its high order volume.

3. Investigate the causes of poor delivery performance in ZONE0020.

4. Review Economy service operations because of its higher failure rate.

5. Monitor customers with high order frequency and high order value.

6. Balance driver workloads based on delivery volume and performance.

7. Optimize vehicle allocation according to delivery demand,
distance, package requirements, and vehicle capabilities.

8. Investigate deliveries requiring multiple attempts.

9. Monitor zones with high Failed, Pending, and Rescheduled deliveries.

10. Track delivery duration and delivery outcomes together when
evaluating operational performance.

11. Continue monitoring delivery demand over time for future
driver and vehicle capacity planning.

12. Use SQL-based operational analysis regularly to support
continuous improvement in delivery operations.
*/