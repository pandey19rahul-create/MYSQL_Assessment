USE retail;
insert into product values(39,'Wireless Mouse',1500,100,3,'Dell');
delete from product where product_id =101;
select * from product;
select * from property;
select * from category;
select * from customer;
select * from booking;
select * from order_item;
INSERT INTO product(product_name,stock_quantity,price,product_id )values('Wireless Keyborad',100,2000,40);
set sql_safe_updates=0;
update product 
set price =price*1.10
where category__id =(select category_id from category where category_name='Electronics')  ;
update product
set price = price/1.10
where(select category_id from category where category_name='Electronics') ;

USE accommodation;
update property p 
join (select property_id ,avg(rating) 
as average_rating 
from review  
group by property_id ) as r_stats on p.property_id=r_stats.property_id
set price_per_night=price_per_night*0.90
where r_stats.average_rating<3;
select property_id ,avg(rating) 
as average_rating 
from review  
group by property_id;



--
use retail;

delete  from product  where product_id not in (select distinct product_id from order_item)
and product_id not in (select distinct product_id from discount);
create index idx_product_id on product(product_id);
create index idx_product_brand on product(brand);