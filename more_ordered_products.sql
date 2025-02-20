SELECT 
    name AS product_name,
    SUM(products.id) AS quantity_ordered
FROM 
    products
JOIN    
    order_products ON order_products.product_id = products.id
GROUP BY
    products.id
ORDER BY 
    quantity_ordered DESC
LIMIT 10;    
