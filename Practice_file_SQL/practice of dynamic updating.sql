use retail;
select * from product;
select * from `order`;
select * from order_item;
select * from rating;
select * from customer;
select  * from category;
select product_id,product_name,price 
from product 
where price =(
 select max(price) 
 from product);
 -- 
 
 select product_name,price 
 from product 
 where price>(
  select avg(price) from product);
  -- 
  select order_id,total_amount 
  from `order` 
  where total_amount>(
   select avg(total_amount) from `order`);
   
   --
select customer_name,wallet_balance 
from customer 
where wallet_balance>(select avg(wallet_balance) from customer);   
--

select distinct c.customer_id ,c.customer_name 
from customer c
join `order` o 
on c.customer_id =o. customer_id
where total_amount >(select avg(total_amount) from `order`);  
--

select customer_id,customer_name  
from customer 
where customer_id in(select customer_id from `order` group by customer_id having sum(total_amount)>50000);
   select customer_id,sum(total_amount) from `order` group by customer_id having sum(total_amount)>50000;
  -----------  List products that have been ordered at least 10 times
  select product_id,product_name from product where product_id in 
  (select product_id 
  from order_item 
  group by product_id 
  having count(order_id)>=2
  );
--------------    Find categories with total sales exceeding  100000
select  category_id,category_name 
from category 
where category_id 
in(
 select p.category_id  
 from product p 
 join order_item oi 
 on p.product_id=oi.product_id 
 group by p.category_id 
 having sum(oi.quantity*p.price)>10000) ;
 select p.category_id  
 from product p 
 join order_item oi 
 on p.product_id=oi.product_id 
 group by p.category_id 
 having sum(oi.quantity*p.price)>10000;
 --  find product price than all rated products prices
 select product_id,product_name,price 
 from  product 
 where price >all(
  select p.price 
  from product p 
  join rating r 
  on r.product_id=p.product_id 
  );
  select r.rating, p.price 
  from product p 
  join rating r 
  on r.product_id=p.product_id where r.rating is  not null;
  -- customers whose wallet balance  is higher than any customer who has placed  more than 2 orders;
  select customer_name,wallet_balance 
  from customer 
  where wallet_balance >
  any(
   select c.wallet_balance
   from customer c
   join `order` o 
   on o.customer_id=c.customer_id 
   group by o.customer_id 
   having count(order_id)>2);
   -- the products price higher than the average price in their category
   select product_name, price ,category_id 
   from product p 
   where price>(
   select avg(price) 
   from product 
   where category_id=p.category_id );
   
   
   select product_name,price ,category_id from product p where price= (select min(price) from product where p.category_id=category_id);
   
   
   use accommodation;
   -- 
   select property_id,property_name,price_per_night from property where price_per_night>(select avg(price_per_night) from property);
   
   --
   select c.customer_id,concat(c.first_name,' ',c.last_name) as full_name,b.total_amount 
   from customer c 
   join  booking b 
   on b.customer_id=c.customer_id 
   where total_amount>( select avg(total_amount) from booking);
   
   
   --
   
   select property_id,property_name,location 
   from property 
   where property_id in(
    select property_id 
    from booking  
    group by property_id 
    having count(booking_id)>=2) ;
    
    
    -- 
    
    select property_id ,location 
    from property 
    where property_id in (
     select property_id 
     from booking 
     group by property_id 
     having sum(total_amount)>200000);
     
     
     -- 
     select property_id,property_name,location,price_per_night 
     from property 
     where price_per_night >all(
      select p.price_per_night 
      from property p 
      join booking b on b.property_id=p.property_id where booking_id is not null);
     use retail; 
      select c.customer_name,o.total_amount from customer s INNER JOIN 