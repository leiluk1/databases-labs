ALTER TABLE address
ADD COLUMN IF NOT EXISTS longitude FLOAT,
ADD COLUMN IF NOT EXISTS latitude FLOAT;

DROP FUNCTION IF EXISTS retrieve_addresses;

CREATE OR REPLACE FUNCTION retrieve_addresses()
RETURNS TABLE(address_id INTEGER, address VARCHAR(50)) AS
$$
    SELECT address_id, address FROM address 
    WHERE address LIKE '%11%' AND city_id BETWEEN 400 AND 600;
$$
LANGUAGE sql
IMMUTABLE;

SELECT address_id, address, latitude, longitude FROM address 
WHERE address_id IN (
    SELECT address_id FROM retrieve_addresses()
);

