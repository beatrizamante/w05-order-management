SELECT  
    orders.id as order_id,
    SUM(products.price_cents * order_products.quantity) / 100 as total_price
FROM 
    orders
JOIN 
    order_products ON order_products.order_id = orders.id
JOIN 
    products ON products.id = order_products.product_id
GROUP BY
    orders.id
ORDER BY
    total_price
LIMIT 10;