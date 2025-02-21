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

WITH deleted AS (
    DELETE FROM order_products
    WHERE product_id IN (SELECT old_product_id FROM temp_product_mapping)
    RETURNING order_id, product_id, quantity
)
INSERT INTO order_products (order_id, product_id, quantity)
SELECT 
    order_id,
    COALESCE(m.keep_product_id, product_id) AS product_id, 
    SUM(quantity) AS total_quantity
FROM deleted
LEFT JOIN temp_product_mapping m ON deleted.product_id = m.old_product_id
GROUP BY order_id, COALESCE(m.keep_product_id, product_id)
ON CONFLICT (order_id, product_id) DO UPDATE
SET quantity = order_products.quantity + EXCLUDED.quantity;

DELETE FROM products 
WHERE id IN (SELECT old_product_id FROM temp_product_mapping);

COMMIT;