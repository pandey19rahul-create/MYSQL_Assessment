-- Exercise 3 
-- Task 1
SELECT 
 o.username, 
 p.property_name ,
 COUNT(b.booking_id) AS Number_of_booking,
 AVG(b.total_amount)AS average_revenue 
FROM property p 
JOIN `owner` o ON p.owner_id=o.owner_id
JOIN booking b ON b.property_id=p.property_id
GROUP BY 
 p. property_id, 
 o.username
HAVING COUNT(booking_id)>=3;

