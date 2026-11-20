-- Task 1
select property_id,property_name,location 
from property where property_id in(select property_id from booking  group by property_id having count(booking_id)>=2 );

-- Task 2
select distinct location 
from (
 select p.location ,sum(b.total_amount) 
 as total_revenue 
 from property p 
 join booking b 
 on p.property_id=b.property_id 
 group by p.location) t 
where t.total_revenue>200000;
 
-- Task 3
select property_id,property_name,location,price_per_night 
from property 
where price_per_night>
all(
 select price_per_night 
 from property p 
 join booking b 
 on b.property_id=p.property_id 
 where booking_id is not null);
 -- Task 4 
 select c.customer_id,c.first_name,c.last_name 
 from customer c 
 join booking b
 on b.customer_id=c.customer_id
group by c.customer_id,c.first_name,c.last_name
 having sum(total_amount) >any(
  select sum(total_amount)
  from booking 
  group by customer_id having count(booking_id)>2)