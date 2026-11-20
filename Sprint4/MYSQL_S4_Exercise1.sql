use accommodation;
--  Task 1
select property_id,property_name ,price_per_night 
from property 
where  price_per_night >(select avg(price_per_night) from property);
-- Task 2
select distinct c.customer_id,concat(first_name,' ',last_name) AS FULL_NAME,sum(total_amount) as total_spent
from customer c 
join booking b  
on c.customer_id =b.customer_id group by customer_id  ,c.first_name,c.last_name
having  sum(b.total_amount) >(select avg(total_amount) from booking );