-- 1. Insert 5 Customers
INSERT INTO customers (customer_id, phone_number, full_name, email, address_line, city, pincode, registered_on) VALUES
(1, '9876543210', 'Rahul Sharma', 'rahul.sharma@email.com', 'Flat 401, Sapphire Residency', 'Bangalore', '560001', '2024-01-15'),
(2, '8877665544', 'Priya Singh', 'priya.singh@email.com', '12/A, Green Park Apartments', 'Bangalore', '560001', '2024-02-20'),
(3, '7766554433', 'Arun Kumar', 'arun.kumar@email.com', 'H-10, Block C, Marigold Twp', 'Bangalore', '560010', '2024-03-01'),
(4, '9988776655', 'Sneha Patel', 'sneha.patel@email.com', 'Shop No. 5, Commercial Complex', 'Bangalore', '560010', '2024-04-10'),
(5, '9000111222', 'Vishal Menon', 'vishal.m@email.com', 'House 2B, Near Temple Road', 'Bangalore', '560037', '2024-05-05');

-- 2. Insert 5 Products (Products 1-5)
INSERT INTO products (product_id, product_name, category, brand, base_price, unit, short_description, is_active) VALUES
(1, 'Fresh Red Apples', 'Fruits & Vegetables', 'Generic', 150.00, '1 kg', 'Crispy and delicious apples.', TRUE),
(2, 'Dark Chocolate Bar', 'Snacks & Sweets', 'ChocoKing', 100.00, '100 gm', '70% cocoa dark chocolate.', TRUE),
(3, 'Toned Milk', 'Dairy & Eggs', 'DairyPure', 60.00, '1 Litre', 'Pasteurized, healthy milk.', TRUE),
(4, 'Orange Soda Can', 'Beverages', 'FizzUp', 45.00, '300 ml', 'Refreshing orange flavoured soda.', TRUE),
(5, 'Salted Potato Chips', 'Snacks & Sweets', 'CrunchyBites', 99.50, '1 Pack', 'Classic salted potato chips.', TRUE);

-- 3. Insert 3 Dark Stores (3 stores is sufficient for 5 orders)
INSERT INTO dark_stores (store_id, store_name, locality, city, pincode, contact_number, status) VALUES
(1, 'Blinkit - Koramangala', 'Koramangala 4th Block', 'Bangalore', '560001', '0802345678', 'Operational'),
(2, 'Blinkit - Indiranagar', 'Indiranagar 100ft Road', 'Bangalore', '560037', '0809876543', 'Operational'),
(3, 'Blinkit - Electronic City', 'Phase 1, Electronic City', 'Bangalore', '560010', '0801122334', 'Operational');

-- 4. Insert 4 Delivery Partners (linking to Dark Stores)
INSERT INTO delivery_partners (partner_id, partner_name, phone_number, vehicle_type, assigned_store, status, joined_on) VALUES
(1, 'Gopal Singh', '9123456789', 'Motorcycle', 1, 'Busy', '2023-11-01'),
(2, 'Lakshmi Rao', '8123456789', 'Scooter', 2, 'Available', '2023-12-10'),
(3, 'Sanjay Das', '7123456789', 'Bicycle', 3, 'Available', '2024-01-25'),
(4, 'Aisha Khan', '9555444333', 'Motorcycle', 2, 'Available', '2024-02-14');

-- 5. Insert Inventory (showing stock in different stores)
INSERT INTO inventory (inventory_id, store_id, product_id, available_qty, last_updated) VALUES
(1, 1, 1, 150, NOW()), -- Store 1 has Apples
(2, 1, 2, 80, NOW()),  -- Store 1 has Chocolate
(3, 1, 4, 200, NOW()), -- Store 1 has Soda
(4, 2, 2, 120, NOW()), -- Store 2 has Chocolate
(5, 2, 5, 90, NOW()),  -- Store 2 has Chips
(6, 3, 1, 50, NOW()),  -- Store 3 has Apples
(7, 3, 3, 60, NOW()),  -- Store 3 has Milk
(8, 3, 5, 110, NOW()); -- Store 3 has Chips

-- 6. Insert 5 Orders (linking customers and stores)
INSERT INTO orders (order_id, customer_id, store_id, order_timestamp, delivery_address, payable_amount, delivery_fee, order_status, delivered_at) VALUES
(1001, 1, 1, '2024-11-20 18:30:00', 'Flat 401, Sapphire Residency, Bangalore 560001', 429.00, 29.00, 'DELIVERED', '2024-11-20 18:45:00'),
(1002, 2, 1, '2024-11-20 19:15:00', '12/A, Green Park Apartments, Bangalore 560001', 74.00, 29.00, 'DELIVERED', '2024-11-20 19:30:00'),
(1003, 3, 2, '2024-11-21 10:40:00', 'H-10, Block C, Marigold Twp, Bangalore 560010', 499.00, 0.00, 'DELIVERED', '2024-11-21 10:55:00'),
(1004, 4, 3, '2024-11-21 14:05:00', 'Shop No. 5, Commercial Complex, Bangalore 560010', 338.50, 29.00, 'CANCELLED', NULL),
(1005, 5, 2, '2024-11-21 17:50:00', 'House 2B, Near Temple Road, Bangalore 560037', 368.50, 29.00, 'PLACED', NULL);

-- 7. Insert 5 Payments (linking to orders)
INSERT INTO payments (payment_id, order_id, payment_method, payment_status, amount, transaction_ref, paid_at) VALUES
(5001, 1001, 'UPI', 'PAID', 429.00, 'UPI1234567890', '2024-11-20 18:30:15'),
(5002, 1002, 'Card', 'PAID', 74.00, 'CARD45458899', '2024-11-20 19:15:20'),
(5003, 1003, 'UPI', 'PAID', 499.00, 'UPI5678901234', '2024-11-21 10:40:50'),
(5004, 1004, 'COD', 'REFUNDED', 338.50, NULL, NULL), -- Cancelled COD order, amount refunded is 0 but status shows action on payment
(5005, 1005, 'Card', 'PENDING', 368.50, 'CARD11223344', '2024-11-21 17:51:00');

-- 8. Insert Order Items (linking to orders and products)
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, price_at_time, subtotal) VALUES
-- Order 1 (Total: 400.00)
(2001, 1001, 1, 2, 150.00, 300.00), -- 2 kg Apples
(2002, 1001, 2, 1, 100.00, 100.00), -- 1 Chocolate Bar
-- Order 2 (Total: 45.00)
(2003, 1002, 4, 1, 45.00, 45.00), -- 1 Soda Can
-- Order 3 (Total: 499.00)
(2004, 1003, 2, 3, 100.00, 300.00), -- 3 Chocolate Bars
(2005, 1003, 5, 2, 99.50, 199.00), -- 2 Salted Potato Chips
-- Order 4 (Total: 309.50)
(2006, 1004, 1, 1, 150.00, 150.00), -- 1 kg Apples
(2007, 1004, 5, 1, 99.50, 99.50), -- 1 Chips
(2008, 1004, 3, 1, 60.00, 60.00), -- 1 Litre Milk
-- Order 5 (Total: 339.50)
(2009, 1005, 4, 2, 45.00, 90.00), -- 2 Soda Cans
(2010, 1005, 1, 1, 150.00, 150.00), -- 1 kg Apples
(2011, 1005, 5, 1, 99.50, 99.50); -- 1 Chips

-- 9. Insert 5 Deliveries (linking to orders and partners)
INSERT INTO deliveries (delivery_id, order_id, partner_id, pickup_time, drop_time, rating) VALUES
(3001, 1001, 1, '2024-11-20 18:32:00', '2024-11-20 18:45:00', 5), -- Delivered by Gopal
(3002, 1002, 2, '2024-11-20 19:18:00', '2024-11-20 19:30:00', 4), -- Delivered by Lakshmi
(3003, 1003, 4, '2024-11-21 10:43:00', '2024-11-21 10:55:00', 5), -- Delivered by Aisha
(3004, 1004, 3, '2024-11-21 14:08:00', NULL, NULL), -- Picked up but order was CANCELLED before drop
(3005, 1005, 2, NULL, NULL, NULL); -- Order is still 'PLACED', delivery not started


select * from customers;