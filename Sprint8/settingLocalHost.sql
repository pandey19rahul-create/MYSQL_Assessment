USE retail;
grant select ,insert,update on product  to 'rahul1'@'localhost';
grant select ,insert,update on Accounts to 'rahul1'@'localhost';
grant process on*.* to 'rahul1'@'localhost';
FLUSH PRIVILEGES;
select * from product where category_id=2 lock in share mode;

set transaction isolation level serializable;
start transaction;
select * from product 
where product_id=1 for update;
update product
set stock_quanity=stock_quantity-1
where product_id=1;
commit;
--
 
 
 CREATE DATABASE  DeadlockDemo;
 Use DeadlockDemo;
 
 CREATE TABLE Accounts(
 id INT PRIMARY KEY,
 name VARCHAR(50),
 balance int
 )ENGINE=InnoDB;
 INSERT INTO Accounts VALUES(1,"Rahul",1000),(2,"Sakshi",1000);
 SET autocommit=0;
 -- session A
 START TRANSACTION ;
 SELECT * FROM Accounts 
 WHERE id=1 FOR UPDATE;
 
 UPDATE Accounts
 SET balance=balance-100
 WHERE id=1 ;
 
 SELECT SLEEP(15);
 UPDATE Accounts
 SET balance=balance+100
 where id=2;
 
 ROLLBACK;