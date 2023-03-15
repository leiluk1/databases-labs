EXPLAIN ANALYZE SELECT * FROM customer;
EXPLAIN ANALYZE SELECT * FROM customer WHERE id = 101;
EXPLAIN ANALYZE SELECT * FROM customer WHERE name = 'Monica Weber';


CREATE INDEX idx_customer_id ON customer(id);
CREATE INDEX idx_customer_name ON customer USING hash (name);

EXPLAIN ANALYZE SELECT * FROM customer;
EXPLAIN ANALYZE SELECT * FROM customer WHERE id = 101;
EXPLAIN ANALYZE SELECT * FROM customer WHERE name = 'Monica Weber';

-- Results:
-- Let's compare query execution time before and after index creation:
-- 'SELECT * FROM customer' - before: 0.713 ms, after: 0.625 ms
-- 'SELECT * FROM customer WHERE id = 101' - before: 0.021 ms, after: 0.011 ms
-- 'SELECT * FROM customer WHERE name = 'Monica Weber'' - before: 0.716 ms, after: 0.017 ms

-- Conclusion: 
-- There is the difference in results before and after the index creation. 
-- As was obtained, index creation made queries noticebly faster.