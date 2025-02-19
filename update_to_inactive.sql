UPDATE customers
SET active = FALSE
WHERE active = TRUE
AND id NOT IN (
    SELECT DISTINCT customer_id
    FROM orders
    WHERE ordered_at <= '2022-12-31'
);