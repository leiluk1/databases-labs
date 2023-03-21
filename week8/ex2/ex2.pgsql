DROP FUNCTION IF EXISTS retrieve_customers;

CREATE OR REPLACE FUNCTION retrieve_customers(start_id INTEGER, end_id INTEGER)
RETURNS TABLE (customer_id INT, store_id INT, first_name VARCHAR(45), last_name VARCHAR(45), email VARCHAR(50), address_id INT) AS 
$$
BEGIN
    IF (start_id < 0) THEN
        RAISE 'start_id must be positive';
    END IF;
    IF (end_id < 0) THEN
        RAISE 'end_id must be positive';
    END IF;
    IF (start_id > 600 OR end_id > 600) THEN
        RAISE NOTICE 'start_id and end_id must be less than 600';
    END IF;
    IF (start_id >= end_id) THEN
        RAISE NOTICE 'start_id must be less than end_id';
    END IF;
    RETURN QUERY

    SELECT c.customer_id, c.store_id, c.first_name, c.last_name, c.email, c.address_id FROM customer c
    ORDER BY address_id 
    OFFSET start_id - 1 LIMIT end_id - start_id;
END;
$$ 
LANGUAGE PLPGSQL
IMMUTABLE;


SELECT * FROM retrieve_customers(10, 40);

