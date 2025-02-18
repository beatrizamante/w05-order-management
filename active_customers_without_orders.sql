SELECT 
    first_name || ' ' last_name AS customer_name
FROM
    customers
LEFT JOIN 
    orders ON orders.customer_id = customers.id
WHERE   
    customers.active = TRUE
    AND
    orders.id IS NULL;