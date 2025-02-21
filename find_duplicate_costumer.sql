SELECT 
    first_name,
    last_name,
    COUNT(*) AS duplicate_count,
    array_agg(id) AS duplicate_customer_id
FROM
    customers
GROUP BY
    first_name, last_name
HAVING 
    COUNT(*) > 1;