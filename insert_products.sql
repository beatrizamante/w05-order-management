BEGIN;

    INSERT INTO products (name, description, price_cents) 
    VALUES ('PayWall', 'Its a gacha', 265);

    COMMIT;

EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE NOTICE 'Error at inserting new customer.';

END;