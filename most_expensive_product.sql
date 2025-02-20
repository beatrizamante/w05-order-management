SELECT 
    id, name, TO_CHAR(price_cents / 100, 'FM999,999,999,999.00') as price 
FROM 
    products 
ORDER BY 
    price_cents DESC 
LIMIT 1;