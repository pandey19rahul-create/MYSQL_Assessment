-- Exercise 1
USE accommodation;
SHOW TABLES;
-- Task 1-Showing all the columns of booking table 
SELECT 
 booking_id, 
 customer_id, 
 property_id, 
 check_in_date, 
 check_out_date, 
 total_amount,
 `status`, 
 created_at, 
 updated_at 
FROM booking 
WHERE customer IS NOT NULL 
AND property_id IS NOT NULL;	
-- Task 2 Relationship between the booking ,customer and proeprty table
-- The booking table is connected to  customer table through the  foreign key   customer_id
-- The booking table is connected to property table through the  foreign key  property_id
