-- Exercise 2

SELECT * FROM customer;
-- Task 1
SELECT c.username, SUM(b.total_amount) AS total_amount 
FROM booking b 
JOIN customer c ON c.customer_id=b.customer_id  
WHERE c.username='Ravi_kumar';
-- Task 2
SELECT c.username ,max(b.total_amount) AS Highest_spent,MIN(b.total_amount) AS Lowest_spent 
FROM booking b
JOIN customer c ON c.customer_id=b.customer_id WHERE c.username='Ravi_kumar';
-- Task 3
SELECT c.customer_id, c.first_name,c.last_name FROM customer c 
LEFT JOIN booking b ON 	c.customer_id=b.customer_id
WHERE booking_id IS NULL;
-- Task 4
SELECT status ,COUNT
(booking_id) AS Total_number_booking FROM booking GROUP BY status;