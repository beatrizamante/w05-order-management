BEGIN;

CREATE TEMP TABLE temp_customer_mapping AS
WITH duplicated_customers AS (
    SELECT 
        id, first_name, last_name, active,
        FIRST_VALUE(id) OVER (
            PARTITION BY first_name, last_name 
            ORDER BY active DESC, id ASC  
        ) AS keep_customer_id  
    FROM customers
)
SELECT id AS old_customer_id, keep_customer_id 
FROM duplicated_customers 
WHERE id != keep_customer_id;

UPDATE orders o
SET customer_id = m.keep_customer_id
FROM temp_customer_mapping 
WHERE o.customer_id = m.old_customer_id;

DELETE FROM customers 
WHERE id IN (SELECT old_customer_id FROM temp_customer_mapping);

COMMIT;
