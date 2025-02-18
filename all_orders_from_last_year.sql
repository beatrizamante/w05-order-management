SELECT 
    orders.id,
    orders.ordered_at,
    customers.first_name || ' ' || customers.last_name as customer_name
FROM 
    orders
JOIN 
    customers ON customers.id = orders.customer_id
WHERE  
    orders.ordered_at BETWEEN DATE_TRUNC('year', CURRENT_DATE) - INTERVAL '1 year'
    AND DATE_TRUNC('year', CURRENT_DATE) - INTERVAL '1 day';