CREATE DATABASE if not exists blinkit_db;
USE blinkit_db;

CREATE TABLE if not exists customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    phone_number VARCHAR(10) NOT NULL UNIQUE,
    full_name VARCHAR(80) NOT NULL,
    email VARCHAR(120),
    address_line VARCHAR(200) NOT NULL,
    city VARCHAR(40) NOT NULL,
    pincode CHAR(6) NOT NULL,
    registered_on DATE
);

CREATE TABLE if not exists products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(120) NOT NULL,
    category VARCHAR(40) NOT NULL,
    brand VARCHAR(40),
    base_price DECIMAL(8,2) NOT NULL,
    unit VARCHAR(20),
    short_description VARCHAR(255),
    is_active BOOLEAN DEFAULT TRUE
);

CREATE TABLE if not exists dark_stores (
    store_id INT PRIMARY KEY AUTO_INCREMENT,
    store_name VARCHAR(100) NOT NULL,
    locality VARCHAR(120) NOT NULL,
    city VARCHAR(40) NOT NULL,
    pincode CHAR(6) NOT NULL,
    contact_number VARCHAR(10),
    status VARCHAR(20) DEFAULT 'Operational'
);

CREATE TABLE if not exists inventory (
    inventory_id INT PRIMARY KEY AUTO_INCREMENT,
    store_id INT NOT NULL,
    product_id INT NOT NULL,
    available_qty SMALLINT NOT NULL DEFAULT 0,
    last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (store_id) REFERENCES dark_stores(store_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id),
    UNIQUE(store_id, product_id)
);

CREATE TABLE if not exists orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    store_id INT NOT NULL,
    order_timestamp DATETIME NOT NULL,
    delivery_address VARCHAR(255) NOT NULL,
    payable_amount DECIMAL(10,2) NOT NULL,
    delivery_fee DECIMAL(6,2) DEFAULT 0.00,
    order_status VARCHAR(20) DEFAULT 'PLACED',
    delivered_at DATETIME,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (store_id) REFERENCES dark_stores(store_id)
);

CREATE TABLE if not exists order_items (
    order_item_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity SMALLINT NOT NULL,
    price_at_time DECIMAL(8,2) NOT NULL,
    subtotal DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

CREATE TABLE  if not exists delivery_partners (
    partner_id INT PRIMARY KEY AUTO_INCREMENT,
    partner_name VARCHAR(80) NOT NULL,
    phone_number VARCHAR(10) NOT NULL UNIQUE,
    vehicle_type VARCHAR(20),
    assigned_store INT,
    status VARCHAR(20) DEFAULT 'Available',
    joined_on DATE,
    FOREIGN KEY (assigned_store) REFERENCES dark_stores(store_id)
);

CREATE TABLE if not exists deliveries (
    delivery_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    partner_id INT NOT NULL,
    pickup_time DATETIME,
    drop_time DATETIME,
    rating TINYINT,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (partner_id) REFERENCES delivery_partners(partner_id)
);

CREATE TABLE if not exists payments (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    payment_method VARCHAR(20) NOT NULL,
    payment_status VARCHAR(20) DEFAULT 'PENDING',
    amount DECIMAL(10,2) NOT NULL,
    transaction_ref VARCHAR(80),
    paid_at DATETIME,
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);
