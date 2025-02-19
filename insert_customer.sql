BEGIN;

    INSERT INTO customers (first_name, last_name, active) 
    VALUES ('First Name', 'Last Name', TRUE);
    
    COMMIT;

EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE NOTICE 'Erro ao inserir o cliente.';

END;
