
-- Exercise 4
SELECT 
 c.first_name, 
 c.last_name, 
 p.property_name, 
 r.rating 
FROM customer c 
JOIN review r 
ON c.customer_id=r.customer_id
JOIN property p
ON r.property_id=p.property_id;