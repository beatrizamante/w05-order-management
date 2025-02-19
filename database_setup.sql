CREATE DATABASE postgres;
\c postgres

CREATE TABLE customers (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    active BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    customer_id INT NOT NULL,
    ordered_at TIMESTAMP NOT NULL
);

CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    price_cents INT NOT NULL
);

CREATE TABLE order_products (
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL DEFAULT 1,
    PRIMARY KEY (order_id, product_id),
);

ALTER TABLE orders
ADD CONSTRAINT fk_customer
FOREIGN KEY (customer_id) REFERENCES customers(id);

ALTER TABLE order_products
ADD CONSTRAINT fk_order
FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE;

ALTER TABLE order_products
ADD CONSTRAINT fk_products
FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE;

SELECT setval('customers_id_seq', (SELECT MAX(id) FROM customers));
SELECT setval('products_id_seq', (SELECT MAX(id) FROM products));
SELECT setval('orders_id_seq', (SELECT MAX(id) FROM orders));

COPY customers(id, first_name, last_name, active)
FROM '/path/customers.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ';', QUOTE '"');

COPY products(id, name, description, price_cents)
FROM '/path/products.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ';', QUOTE '"');

COPY orders(id, customer_id, ordered_at)
FROM '/path/orders.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ';', QUOTE '"');

COPY order_products(order_id, product_id, quantity)
FROM '/path/order_products.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ';', QUOTE '"');