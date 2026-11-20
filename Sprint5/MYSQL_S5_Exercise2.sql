-- Task 1
set SQL_SAFE_UPDATES=0;
update booking 
set status ='COMPLETED'
where check_out_date <curdate() and status='confirmed';
set SQL_SAFE_UPDATES=1;

-- Task 2
set SQL_SAFE_UPDATES=0;
update property 
set price_per_night=price_per_night*1.10
where property_id in(
select b.property_id
from booking b join review r on b.booking_id=r.booking_id
where r.rating=5);  
-- Task 3
update customer
set email='amit_patil_90@gmail.com',phone_number='9998887776',
updated_at=now()
where customer_id=(select customer_id from(select  customer_id from customer  where first_name ='Amit' and last_name='Patil') as temp);