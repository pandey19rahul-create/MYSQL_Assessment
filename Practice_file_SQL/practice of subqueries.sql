use retail;	
select * from product;
select * from `order`;
select * from customer;
select max(price) as highest_price from product;
select product_name ,
price from product where price =(select max(price) as highest_price from product);
select product_name,price from product where price>(select avg(price) from product);
select order_id,total_amount from `order` where total_amount>(select avg(total_amount) from `order`);
select customer_id,customer_name,wallet_balance from customer where wallet_balance >(select avg(wallet_balance) from customer);
select avg(total_amount) from `order`; 
select c.customer_id,c.customer_name ,o.total_amount
from customer c 
JOIN `order` o on c.customer_id =o.customer_id  
where total_amount >(select avg(total_amount) from `order`);
select customer_id 
from `order`
group by customer_id 
having sum(total_amount)>50000;
SELECT customer_id ,customer_name 
from customer where customer_id in (select customer_id 
from `order`
group by customer_id 
having sum(total_amount)>50000);
select * from order_item;
select product_id,count(order_id) as order_times from order_item group by product_id having order_times>=2;

select product_id,product_name from product where product_id in(select product_id  from order_item group by product_id having count(order_id)>=10);
select * from product;
select * from `order`;
select * from rating;
select p.category_id 
from product p 
join order_item oi on p.product_id=oi.product_id 
group by category_id 
having sum(oi.quantity*p.price) >100000;
select category_id,category_name from category where category_id in (select p.category_id 
from product p 
join order_item oi on p.product_id=oi.product_id 
group by category_id 
having sum(oi.quantity*p.price) >100000);
select product_id,product_name  from My_Products where price > all(select the price from competitor_Prices);
select product_id,product_name  from My_Products where price< all(select the price from competitor_Prices);
select product_id,product_name  from My_Products where price<> all(select the price from competitor_Prices);
 select `name`
 from Employees 
 where salary > all(select e.salary from Employees e join Department d on d.Dept_id=e.Dept_id where d.Dept_id='Marketing');

 select task 
from Office_Task 
where Days_Taken <all(select Days_Taken from Office_Task where Task_Name in("Database Setup","UI Design");
select task 
from Office_Task 
where Days_Taken <
all(select Days_Taken from Office_Task where Days_take<5);




