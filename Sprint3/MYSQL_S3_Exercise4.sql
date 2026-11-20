-- Exercise 4
-- Task 1
-- Mistake - Actually the filter is happening after the categorization done so we use having instead of where
-- correct code
SELECT customer_id,SUM(total_amount) AS total_spent 
FROM booking 
GROUP BY  customer_id 
HAVING total_spent>20000;
-- task 2
-- Mistake- Wrong joining condition after the join is used ,joining must be on common column not on different column 
 SELECT p.property_name,aAVG(r.rating) AS average_rating 
 FROM property p 
 JOIN booking b ON p.property_id =b.property_id 
 JOIN review r ON r.booking_id=b.booking_id  
 GROUP BY p.property_name;