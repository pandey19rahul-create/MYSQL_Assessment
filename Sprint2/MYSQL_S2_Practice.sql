-- Exercise 1
use accommodation;
show tables ;
select * from customer;

select * from booking;
-- Task 1-Showing all the columns of booking table 
select booking_id, customer_id, property_id, check_in_date, check_out_date, total_amount ,status,created_at,updated_at from booking;	
-- Task 2 Relationship between the booking ,customer and proeprty table
-- The booking table is connected to  customer table through the  foreign key   customer_id
-- The booking table is connected to property table through the  foreign key  property_id
