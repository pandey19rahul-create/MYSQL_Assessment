-- Exercise 8 
SELECT 
 p.property_name, 
 p.price_per_night, 
 b.booking_id,b.`status` 
FROM property p 
JOIN booking b 
ON p.property_id=b.property_id
ORDER BY price_per_night 
DESC;