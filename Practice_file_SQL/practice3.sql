use retail;
select * from product;
desc product;
create table product_backup(product_id int not null primary key auto_increment,
                            product_name varchar(255) not null ,
                            price decimal(10,2) not null ,
                            stock_quantity int not null ,
                            category_id int  
                            );
						
desc product_backup;
alter table product_backup add constraint f_cust_id1  foreign key(category_id) references category(category_id) ;  
alter table product_backup add column brand varchar(255) ; 
alter table  product add column prod_desc text;
alter table product
drop product_release_dt;
alter table `order` modify column order_date date not null;
alter table product  add constraint chk_price check(price>0);
create role 'ramesh'@'localhost';
grant  select on product to 'ramesh'@'localhost';
grant insert,update on product to 'ramesh'@'localhost';
create user 'rahul1'@'localhost' identified by 'rahul@123';
select *  from mysql.user;
grant select on retail.product to 'rahul1'@'localhost';
revoke select on retail.product  from  'rahul1'@'localhost';
create role general_manager;
grant select ,update,insert,delete on retail.product to general_manager;
grant general_manager to 'rahul1'@'localhost';
select * from product;
select * from `order`;
select * from category;
select * from customer;
select * from order_item;
set autocommit=0;
start transaction;
update product set  stock_quantity=stock_quantity-2 where product_id=1;
update `order` set total_amount=total_amount+100 where order_id=1;
rollback ;
start transaction;

update product set stock_quantity =stock_quantity-5 where product_id =1;
savepoint update_stock;
update product set stock_quantity =stock_quantity-30 where product_id =6;
rollback to update_stock;
commit;

--
select * from product where category_id=2 
lock in share mode;
select * from information_schema.innodb_trx;
commit;

set transaction isolation level serializable;
start transaction; 
select * from product  where product_id =1 for update;
update product set stock_quantity= stock_quantity-1 where product_id=1;
commit;

