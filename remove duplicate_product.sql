BEGIN;

CREATE TEMP TABLE temp_product_mapping AS
WITH duplicated_products AS (
    SELECT 
        id, name, price_cents,
        FIRST_VALUE(id) OVER (
            PARTITION BY name  
            ORDER BY price_cents DESC, id ASC 
        ) AS keep_product_id  
    FROM products
)
SELECT id AS old_product_id, keep_product_id 
FROM duplicated_products 
WHERE id != keep_product_id;

CREATE TEMP TABLE temp_merged_orders AS
SELECT 
    op.order_id, 
    m.keep_product_id AS product_id, 
    SUM(op.quantity) AS total_quantity  
FROM order_products op
JOIN temp_product_mapping m ON op.product_id = m.old_product_id
GROUP BY op.order_id, m.keep_product_id;

DELETE FROM order_products
WHERE (order_id, product_id) IN (
    SELECT order_id, product_id FROM temp_merged_orders
);

UPDATE order_products op
SET product_id = m.keep_product_id
FROM temp_product_mapping m
WHERE op.product_id = m.old_product_id;

INSERT INTO order_products (order_id, product_id, quantity)
SELECT order_id, product_id, total_quantity
FROM temp_merged_orders;

DELETE FROM products 
WHERE id IN (SELECT old_product_id FROM temp_product_mapping);

COMMIT;
