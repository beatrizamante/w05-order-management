UPDATE customers
SET active = FALSE
WHERE active = TRUE
AND id IN (
    SELECT customer_id
    FROM orders
    GROUB BY customer_id
    HAVING MAX(ordered_at) <= '2022-12-31'
);