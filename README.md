# ETB_DBMS
Blinkit_Database

Project Submitted to:
Prof. Ashok Harnal

This project includes:
- Debapriya Halder - 341008
- Pratyay Mukherjee - 341037
- Sagnik Das Gupta - 341047

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
<img width="853" height="844" alt="image" src="https://github.com/user-attachments/assets/f855e4bc-f228-425c-b410-9bff6defc575" />

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
This repository contains the database schema and EER model created for BlinkIt (Dark Stores) as part of the DBMS assignment
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Project Contents
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
| Table Name            | Description                                                                                   |
| --------------------- | --------------------------------------------------------------------------------------------- |
| **customers**         | Stores customer profile details including contact information and registration date.          |
| **dark_stores**       | Contains information about dark store locations used for order fulfillment.                   |
| **products**          | Maintains the product catalog with pricing, brand, category, and availability status.         |
| **inventory**         | Tracks product stock levels for each store with last updated timestamps.                      |
| **orders**            | Records customer orders along with store, delivery address, payment amount, and order status. |
| **order_items**       | Stores line-item details for each order including quantity and price at purchase time.        |
| **payments**          | Captures payment transactions, methods, statuses, and references for orders.                  |
| **delivery_partners** | Stores delivery partner details including vehicle type, assigned store, and status.           |
| **deliveries**        | Tracks delivery execution details such as pickup time, drop time, and customer ratings.       |

1. Introduction
Quick-commerce platforms like Blinkit rely on highly optimized databases to support ultra-fast delivery (10–15 minutes). These systems must handle:
Real-time product inventory
Micro-fulfillment centers (dark stores)
Continuous order placement
Delivery partner assignment
Payment and transaction logging
This project builds a fully functional relational database using MySQL (InnoDB) to model the operational, commercial, and logistics workflows of a quick-commerce platform.
The goal is to demonstrate real-world DBMS capabilities while maintaining data integrity, scalability, and analytical usefulness.

2. Objectives of the Project
2.1 Functional Objectives
The database captures all major components of quick-commerce operations:
Manage customers and delivery addresses
Maintain product catalog with prices and categories
Manage dark stores and their service areas
Track per-store inventory in real time
Accept customer orders and item-level details
Assign delivery partners to orders
Track delivery events, timestamps & ratings
Record payments and transaction status

2.2 Data Integrity Objectives
The system enforces:
Primary keys for entity uniqueness
Foreign keys for relational integrity
Unique constraints for business rules
NOT NULL constraints for required fields
Default values for smoother data insertion
Indexing for fast query performance

2.3 Analytical Objectives
The schema supports operational analytics such as:
Store-wise revenue
Delivery partner performance
Customer purchase trends
Inventory stock-out alerts
Sales by category or product
Order fulfilment time tracking

2.4 Scalability Objectives
To handle large-scale data operations:
Frequently queried fields are indexed
Inventory and order tables support high transaction volume
Modular design simplifies partitioning and sharding
Schema supports integration with front-end delivery apps

3. Technology Stack
Component	Choice	Explanation
DBMS	MySQL (InnoDB)	Supports foreign keys, ACID properties
Schema Name	blinkit_db	Logical grouping of project tables
Model	Normalized Relational Schema	Prevents redundancy, ensures integrity
Tools Used	SQL Scripts, MySQL Workbench ERD	Modeling, visualization & testing

4. Conceptual System Design
The system is organized into three functional domains:

4.1 Customer & Ordering Domain
Customers
Orders
Order Items
Payments
Responsible for user activity, order processing, and payment logging.

4.2 Inventory & Fulfillment Domain
Products
Dark Stores
Inventory
Responsible for stock availability and fulfilment routing.

4.3 Logistics & Delivery Domain
Delivery Partners
Deliveries
Tracks delivery partner status, assignment, delivery performance, and ratings.

5. Detailed Schema Overview
Below is an overview of the core tables (full SQL schema: Blinkit.sql → Blinkit)

5.1 Master Data Tables
Products
Stores catalog information:
Product name
Category
Brand
Base price
Unit
Active status
Dark Stores
Represents micro-fulfillment centers:
Store identity
Locality & pincode
Contact number
Operational status

5.2 Operational Workflow Tables
Inventory
Tracks product availability at each store.
Unique constraint ensures one product entry per store.
Orders
Stores high-level order metadata:
Customer
Fulfilling store
Timestamp
Total payable amount
Delivery fee
Status
Order Items
Item-wise breakdown for each order including:
Quantity
Price at time of order
Subtotal

5.3 Delivery & Logistics Tables
Delivery Partners
Stores delivery partner details:
Name
Phone number
Vehicle type
Assigned store
Status
Joined date
Deliveries
Tracks last-mile delivery operations:
Pickup time
Drop time
Delivery partner
Rating

5.4 Payment Tables
Payments
Records:
Payment method
Payment status
Amount
Transaction reference
Timestamp

6. Constraints, Integrity Rules & Relationships
Primary Keys
Every table contains an AUTO_INCREMENT primary key.

Unique Constraints
Customer phone numbers
Delivery partner phone numbers
Inventory unique per store-product pair

Foreign Keys
Maintain strict relational structure across:
orders → customers
orders → dark stores
order_items → orders & products
deliveries → delivery partners & orders
Not Null Constraints
Applied to all essential attributes.

Data Type Optimization
SMALLINT for quantities
TINYINT for ratings
CHAR(6) for pincodes
Optimized VARCHAR lengths

7. Indexing & Performance Optimization
Indexes added for high-frequency queries:
Customer and store references
Product id
Order timestamps
Payment status
Delivery partner status
Composite unique index ensures consistent inventory tracking.
The design supports future optimizations such as table partitioning and caching.

8. Sample Data
Sample data files (Blinkit_Data.sql → Blinkit_Data) populate the database with:

Customers
Products
Dark stores
Delivery partners
Inventory entries
Orders
Order items
Payments
Deliveries
These simulate realistic operations such as multiple stores stocking the same item, multiple orders from different customers, and varied delivery partner assignments.

9. Operational & Analytical Reports

9.1 Store Inventory Report
Tracks available stock across stores and flags low inventory.

9.2 Order Processing Report
Displays:
Delivery times
Order status
Store assignment
Customer location

9.3 Revenue Reports
Shows:
Total revenue per store
Payment method distribution
Top-selling products

9.4 Delivery Partner Performance
Analyzes:
Ratings
Order count
Average delivery time

9.5 Customer Insights
Useful for marketing:
Repeat customers
Most-ordered categories
High-value customers

10. Scalability, Reliability & Future Enhancements
Planned Improvements
Table partitioning (dates, stores)
Materialized views for dashboards
Trigger-based stock update logs
API integration for mobile delivery apps
Predictive analytics for demand and delivery ETAs

11. Conclusion
This project successfully demonstrates the design of a robust, scalable, and realistic quick-commerce database system. It captures end-to-end workflows—from product availability and customer ordering to delivery tracking and payment processing.
The database demonstrates:
Strong relational modelling

lean normalization
Efficient indexing
Realistic datasets
Analytical reporting capability
It serves as a comprehensive DBMS coursework project and forms a solid foundation for future development such as UI integration, analytics dashboards, and automation.
