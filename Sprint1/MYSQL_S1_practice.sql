-- Exercise 1
-- Task 1-Property_id is the column that is uniquely identified each property
-- task 2- Owner_id column  is present in both the table property and owner that connects or relate the table

-- Exercise 2
show databases;
use accommodation;
show tables;
select  property_name,location ,price_per_night from property;
-- Exercise 3
select * from property;
select property_name,price_per_night from property where location like '%Goa%'and price_per_night <3000;
-- Exercise 4
select  property_id ,substr(property_name,1,5) as short_code from property;
-- Exercise 5
select property_name, created_at from property where date(created_at)=curdate();
-- Exercise 6
select property_name,price_per_night,created_at from property where price_per_night >2000 and month(created_at)=month(curdate());
