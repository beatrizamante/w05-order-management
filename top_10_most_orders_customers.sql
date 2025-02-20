SELECT 
    id, first_name || ' ' || last_name AS customer_name,
    COUNT(orders.id) AS order_amount
FROM 
    customers
JOIN
    orders ON orders.customer_id = customers.id
GROUP BY
    customers.id
ORDER BY
    order_amount
LIMIT 10;
