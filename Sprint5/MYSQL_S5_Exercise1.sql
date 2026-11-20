-- Task 1 
insert into customer(username,first_name,last_name,email,phone_number,password_hash,created_at,updated_at) 
values ('John_doe','John','Doe','john@example.com',9876543210,'pass@123',now(),now());
select * from customer;

-- Task 2
insert into property(property_name,location ,property_type,price_per_night,owner_id,created_at,updated_at)
values('Ocean View Apartment','Mumbai,India','Apartment',4500,9,now(),now()),
      ('Mountain Cabin' ,'Manali,India','Homestay',3500,5,now(),now());
-- Task 3
INSERT INTO booking (customer_id, property_id, check_in_date, check_out_date, total_amount, status, created_at, updated_at)
SELECT customer_id, property_id, check_in_date, check_out_date, 
       (total_amount * 0.90), 
       'Pending', 
       NOW(), 
       NOW()
FROM booking
WHERE customer_id = 3;