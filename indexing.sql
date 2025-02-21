ALTER TABLE customers 
ADD CONSTRAINT unique_customers UNIQUE (first_name, last_name);

ALTER TABLE products 
ADD CONSTRAINT unique_products UNIQUE (name);


