BEGIN;

    DELETE FROM order_products
    WHERE order_id IN (
        SELECT id FROM orders WHERE customer_id = 1
    );
        
    DELETE FROM orders
    WHERE customer_id = 1;

    DELETE FROM customers
    WHERE id = 1;   

    COMMIT;
    
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE NOTICE 'Error when deleting client.';

END;


