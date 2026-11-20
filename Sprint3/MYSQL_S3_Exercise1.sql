-- Exercise 1
USE accommodation;
SELECT *  
FROM  booking;
-- Task  1
SELECT sum(total_amount) AS Total_revenue 
FROM booking;
-- Task 2
SELECT max(total_amount) AS Highest_revenue 
FROM booking;
-- Task 3
SELECT sum(total_amount) AS revenue_in_December 
from booking 
WHERE MONTH(check_in_date)=12;
-- Task 4
SELECT COUNT(status)AS Number_of_Confirmed_status_December 
from booking 
WHERE status='CONFIRMED' AND MONTH(check_in_date)=12
