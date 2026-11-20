use retail;
show tables;
select * from rating;
select * from order_item;
select * from product;
select product_id, product_name, price from product order by price desc limit 5;
select order_id, order_date,total_amount from  `order`  order by order_date asc limit 10;
select product_id ,product_name,price from  product  order by price desc limit 5;
select * from discount;
select p.product_id,p.product_name, d.discount_percentage 
from product p 
join discount d 
on d.product_id=p.product_id ;
select p.product_id,p.product_name,r.rating,r.review from product p 
join rating r
on p.product_id= r.product_id; 
 select p.product_name,oi.quantity,d.discount_percentage 
 from product p 
 join order_item oi 
 on oi.product_id=p.product_id
 join discount d 
 on p.product_id= d.product_id;
 select o.order_id ,p.product_name,r.rating,r.review
 from `order` o 
 join order_item oi 
 on o.order_id-oi.order_id 
 join product p 
 on oi.product_id=p.product_id 
 join rating r
 on p.product_id=r.product_id;
 select c.customer_name,p.product_name,oi.quantity,oi.price,o.order_date 
 from customer c 
 join `order` o 
 on c.customer_id=o.customer_id 
 join order_item oi 
 on o.order_id= oi.order_id 
 join product p 
 on oi.product_id=p.product_id;
 select * from customer;
--  showing all the id of product ,order ,customer an rating 
 select oi.product_id,o.order_id,o.customer_id,r.rating 
 from order_item oi 
 join `order` o 
 on o.order_id=oi.order_id 
 join rating r 
 on r.customer_id=o.customer_id;
 -- left outer join practice
 select p.product_name,o.order_date
 from product p 
 left join  order_item oi 
 on p.product_id=oi.product_id 
 left join `order` o on oi.order_id=o.order_id;
 -- (ii) practice of left outer join 
 select c.customer_name,o.order_id,o.total_amount 
 from customer c 
 left join `order` o 
 on c.customer_id=o.customer_id;
 select r.product_id ,r.rating ,c.customer_name
 from rating r
 right join customer c 
 on r.customer_id =c.customer_id ;
 select o.order_id,p.product_name 
 from `order` o 
 right join order_item oi 
 on o.order_id=oi.order_id
 right join product p on oi.product_id=p.product_id;
 select p.product_name,r.rating ,r.review 
 from  product p 
 left join rating r on p.product_id=r.product_id
 union 
 select p.product_name,r.rating ,r.review 
 from  product p 
 right join rating r on p.product_id=r.product_id;
 select * from supplier;
 select * from product_supplier;
 select s.supplier_id,s.supplier_name,p.product_name
 from supplier s
 left join product_supplier ps on s.supplier_id =ps.supplier_id
 left join product p on ps.product_id=p.product_id;
 
 
 -- PRACTICE OF JOINS 
 desc amenity;
 desc property_amenity;
 select * from review;
 -- practice of aggregated function 
-- fethcing only the order item
 select * from `order`;
 select sum(total_amount)  'total revenue'	from `order`;
 select count(order_id)	as 'total number of order' from `order`;
 select avg(price) as 'average price' from product;
 select max(total_amount )as 'highest order value' ,min(total_amount) as'minimum order value' from `order`;
-- fetching all the data from customer  and rating data
 select * from customer;

 select * from rating;
 select count(review) as 'number of review'from rating;
 select sum(total_amount) as 'december Revenue'from `order` where month(order_date)=12;
 select c.customer_name, sum(o.total_amount) 
 as 'total revenue' 
 from `order` o 
 join customer c 
 on c.customer_id=o.customer_id 
 where customer_name="Myra Kapoor";
-- fetching complete order_item data
 select * from order_item;
 --
 select product_id ,sum( quantity*price) 
 as 'total amount' 
 from order_item 
 group by product_id  
 having  sum(quantity*price)>10000 ;
--
select * from order_item;
select oi.product_id ,sum(oi.quantity*oi.price) as total_sales 
from order_item oi
join product p on p.product_id=oi.product_id 
where p.price>3000 group by product_id having total_sales>10000; 
 select customer_id,sum(total_amount )as total_spent
from `order`
where month(order_date)=10 
group by customer_id  having total_spent>10000; 
 select ca.category_id,ca.category_name,count(distinct o.customer_id) as Total_customer,sum(oi.quantity*oi.price)as total_revenue 
 from category ca 
 join product p on ca.category_id=p.category_id 
 join order_item oi on p.product_id=oi.product_id
 join `order` o on o.order_id=oi.order_id group by ca.category_id ;
 
 --
 select * from category;

 
 
 
 
 
 
 
 
 
 