create database Retail_Inventory;
use Retail_Inventory;
create table Products(Product_id int auto_increment Primary Key ,
					  Product_Name varchar(100) NOT NULL,
                      Price decimal(65,2) default 0, 
                      Category varchar(100) NOT NULL, 
                      stock_quantity int, 
                      brand varchar(100),
                      prod_desc JSON );
insert into Products(Product_Name ,
					 Price , 
                     Category , 
                     stock_quantity, 
                     brand ,
                     prod_desc) 
values("Towel",40.25,"Cloth",3,"Jockey",
JSON_OBJECT("COLOR","Maroon","Material","100 % COTTON","Size","70m","Cloth_type","Bath Towel","Category","Softness")),
("Laptop","45000","Electronics",1,"LG",
JSON_OBJECT("COLOR","GREY","MATERIAL","Silicon","SIZE","35 inches","System","Microprossesor")),
('UltraBook Pro', 1200.00,'Electronics', 50,"Samsung", '{"color": "Silver", "RAM": "16GB", "Storage": "512GB SSD"}'),
('ErgoChair', 250.00,'Furniture',100,"Godrej Interio" ,'{"material": "Mesh", "color": "Black", "adjustable": true}'),
('Pulse Watch', 150.00,'Electronics', 200,"Kospet", '{"color": "Blue", "waterproof": "50m", "battery": "7 days"}'),
('Organic Coffee',20.00 ,'Grocery',500,"Lipten" ,'{"weight": "500g", "roast": "Medium", "origin": "Brazil"}');
SELECT * FROM Products;
delete from Products where Product_id=2;
CREATE table Sales(Product_id int, quantity int);
alter table Sales rename column quantity to quantity_sold;  
INSERT INTO Sales (product_id, quantity_sold) VALUES 
(1, 2), 
(2, 5), 
(1, 1), 
(4, 10);
select * from Sales;
select  S.Product_id ,P.Product_name ,sum(P.Price*S.quantity_sold) as "Total Revenue" 
from Products P 
join Sales S 
on P.Product_id =S.Product_id 
group by S.Product_id;
select Total_Revenue from (select  S.Product_id ,P.Product_name ,sum(P.Price*S.quantity_sold) as "Total_Revenue" 
from Products P 
join Sales S 
on P.Product_id =S.Product_id 
group by S.Product_id) as RevenueTable 
DELIMITER //
CREATE TRIGGER reduce_stock_count 
AFTER INSERT ON Sales
FOR EACH ROW
BEGIN
UPDATE Products 
SET stock_quantity=stock_quantity-NEW.quantity_sold
WHERE Product_id=NEW.Product_id; 
END //
DELIMITER ;
DROP TRIGGER reduce_stock_count;
select * from Products;
insert into Sales value(5,10);
set sql_safe_updates=0;
DELETE FROM Sales where Product_id=5;
select * from Sales;

select Product_id,Product_Name ,JSON_EXTRACT(prod_desc,"$.COLOR") as color from Products where JSON_EXTRACT(prod_desc,"$.COLOR")="Red";
insert into Products(Product_Name ,
					 Price , 
                     Category , 
                     stock_quantity, 
                     brand ,
                     prod_desc) 
values("T-Shirt",200,"Cloth",20,"Gucchi",
JSON_OBJECT("COLOR","Red","Material","100 % COTTON","Size","10m","Cloth_type","Daily wear","Category","Softness"));
