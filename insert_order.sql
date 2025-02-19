BEGIN;

    INSERT INTO orders (customer_id, ordered_at)
    VALUES (1, NOW())
    RETURNING id INTO order_id

    INSERT INTO order_products (order_id, product_id, quantity)
    VALUES (order_id, 344, 1),
           (order_id, 365, 3);
        
    COMMIT;

EXCEPTION
    WHEN OTHERS THEN
    	ROLLBACK;
    	RAISE NOTICE 'Error when inserting product and order';

END;
