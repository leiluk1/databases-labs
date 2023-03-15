EXPLAIN ANALYSE SELECT DISTINCT f.title
    FROM film f
    LEFT JOIN inventory i ON f.film_id = i.film_id
    JOIN film_category fc ON f.film_id = fc.film_id
    JOIN category c ON fc.category_id = c.category_id
    WHERE i.film_id IS NULL AND (rating = 'PG-13' OR rating = 'R') 
        AND (c.name = 'Horror' OR c.name = 'Sci-Fi');


EXPLAIN ANALYSE SELECT c.city, s.store_id, s.address_id, sum(p.amount)
    FROM store s
    JOIN address a ON s.address_id = a.address_id
    JOIN city c ON a.city_id = c.city_id
    JOIN staff ON s.store_id = staff.store_id
    JOIN payment p ON staff.staff_id = p.staff_id
    GROUP BY c.city, s.store_id
    ORDER BY sum(p.amount) DESC;



-- Results:
-- For the first query: 
-- The most expensive step is the join operation
-- involving the "film_category" and "category" tables. One possible solution is
-- to create an index on the "film_category" table that includes both the
-- "film_id" and "category_id" columns.

-- For the second query: 
-- The most expensive step is likely the group by
-- operation involving the "payment" table. The possible solution is to create
-- an index on the "payment" table that includes both the "staff_id" and
-- "amount" columns. 

