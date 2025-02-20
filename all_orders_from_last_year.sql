SELECT 
    orders.id,
    orders.ordered_at,
    customers.first_name || ' ' || customers.last_name as customer_name
FROM 
    orders
JOIN 
    customers ON customers.id = orders.customer_id
WHERE  
    orders.ordered_at BETWEEN make_date(EXTRACT(YEAR FROM CURRENT_DATE)::int - 1, 1, 1)
    AND make_date(EXTRACT(YEAR FROM CURRENT_DATE)::int - 1, 12, 31);