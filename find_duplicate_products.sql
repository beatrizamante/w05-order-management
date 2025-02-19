SELECT 
    name,
    COUNT(*) AS duplicate_count,
    array_agg(id) AS duplicate_product_id
FROM
    products
GROUP BY
    name
HAVING 
    COUNT(*) > 1;