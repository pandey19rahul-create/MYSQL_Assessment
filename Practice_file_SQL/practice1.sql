select * from product;
select * from order_item;
 select ca.category_id,ca.category_name,count( oi.product_id) total_product_sold 
 from order_item oi           
 join product p on  oi.product_id=p.product_id                    
 join category ca on  p.category_id=ca.category_id
 group by ca.category_id ;
 select * from property;
 select * from customer;
 select * from booking;
 select * from `owner`;
 select * from review;
 use accommodation;