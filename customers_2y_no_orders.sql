SELECT 
    id, first_name || ' ' || last_name AS customer_name
FROM
    customers
LEFT JOIN
    orders ON orders.customer_id = customers.id
WHERE
    (ordered_at NOT BETWEEN CURRENT_DATE - INTERVAL '2 years' AND CURRENT_DATE);