USE retail;
select * from product_backup;
select * from product;
drop trigger if exists product_bck_after_dp;
delimiter //
CREATE TRIGGER product_bck_after_dp
after delete on product 
for each row
begin 
    insert into  product_backup(product_id,product_name,price,stock_quantity,category_id,brand)
    values (old.product_id,old.product_name,old.price, old.stock_quantity,old.category_id,old.brand);
end //
delimiter ;
select * from order_item;
alter table product_backup
add column deleted_at  timestamp 
default current_timestamp;
delete from product
where product_id=36;
set foreign_key_checks=0;
set foreign_key_checks=1;
insert into product(product_id,product_name,price,stock_quantity,category_id,brand) values(36, 'Wireless Mouse',1500,100,3,'Dell');
-- Price Change logging 
create table price_log
(log_id int primary key auto_increment,
 product_id int, 
 old_price decimal(10,2),
 new_price decimal(10,2),
 date_of_change timestamp default current_timestamp);

delimiter //
create trigger price_afterupdate
after update on product
for each row
begin 
   insert into price_log(product_id ,old_price,new_price)values(old.product_id,old.price,new.price);
end //
delimiter ;
update product
set  price=price*1.10
where product_id=1;
select * from price_log;