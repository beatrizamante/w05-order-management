SELECT
    orders.id,
    COUNT(DISTINCT order_products.product_id) AS unique_product_count
FROM
    orders 
JOIN
    order_products ON order_products.order_id = orders.id
GROUP BY
    orders.id
ORDER BY
    unique_product_count DESC
LIMIT 1;
