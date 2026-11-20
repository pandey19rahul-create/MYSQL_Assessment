USE accommodation;
select * from customer;
select * from property;
DELIMITER //
CREATE PROCEDURE GetAllProperties()
BEGIN  
   
   SELECT * from property ;
END  //
DELIMITER ;
CALL GetAllProperties();
USE retail;
set sql_safe_updates=0;
DELIMITER //
CREATE PROCEDURE apply_discount()
BEGIN 
  UPDATE product 
  set price =price* 0.9;
 END //
 DELIMITER ;
CALL  apply_discount();
 drop procedure if exists apply_discount;
  
DELIMITER //
CREATE PROCEDURE GetCustomerDetails(IN C_id INT)
BEGIN 
     select first_name,last_name,email 
     from customer
     where customer_id=C_id;
 END   //
 DELIMITER ; 
 call GetCustomerDetails(5);
 DELIMITER //
 CREATE PROCEDURE UpdatePropertyPrice(IN P_ID int ,IN N_price decimal(10,2))
 BEGIN
   UPDATE property
   SET price_per_night=N_Price
   where property_id=P_ID;
 END //
 DELIMITER ;
 CALL UpdatePropertyPrice(1,3800);
 drop procedure if exists UpdatePropertyPrice;
 select * from property_price_logs;
/* create temporary table for updating the value of price_per_night in property table */
 create temporary table temp_recovery as

 select property_id, previous_price, updated_price, change_timestamp 
 from property_price_logs
 where change_timestamp='2026-04-04 17:39:30';
select * from temp_recovery ;

 Update property p
 join temp_recovery I on p.property_id=I.property_id
 set p.price_per_night=I.previous_price ;
 -- create the the procedure for count of review  on properties;
 drop PROCEDURE CountByProperty;
 DELIMITER //
 CREATE PROCEDURE CountByProperty(IN P_ID INT)
 BEGIN

 
 SELECT p.property_name,count(r.review_id) as Total_review
 from review r 
 right join property p 
 on p.property_id= r.property_id
 where  p.property_id=P_ID
 group by p.property_id;
 
 END//
 DELIMITER ;
 CALL  CountByProperty(1);
 
 -- Create procedure from new amenity 
 DROP PROCEDURE AddNewAmenity;
 DELIMITER //
 CREATE PROCEDURE AddNewAmenity(IN A_name varchar(100))
 BEGIN 
 INSERT INTO amenity(amenity_name) values(A_name);
 END //
 DELIMITER ;
 CALL AddNewAmenity('satsang Room');
 SELECT * 
 FROM amenity;
 DELETE from amenity where amenity_id=13;
UPDATE amenity 
set amenity_id=11 where amenity_name ='satsang Room'; 
select * from property;
drop procedure GetPropertiesByCities;
-- procedure 6- create stored  procedure for shwoing proerty based on city 
DELIMITER //
CREATE  PROCEDURE GetPropertiesByCities(IN C_Name  varchar(200))
BEGIN 
SELECT * FROM property  
WHERE location like concat('%',trim(C_Name),'%');
END //
DELIMITER ;
CALL GetPropertiesByCities('Bangalore');
USE accommodation;
-- create a procedure fro properties based on he city(count with out)

DELIMITER //
CREATE PROCEDURE GetTotalPropertiesByCity(IN C_Name varchar(100) ,OUT Total_count INT)
BEGIN
SELECT COUNT(*) into Total_count   
FROM property 
where location like concat("%",trim(C_Name),"%");
END //
DELIMITER ; 
CALL GetTotalPropertiesByCity('KOLKATA',@COUNT);
select  @count;

-- procodure 11: create a procedure fetching the mobile number (select into )
DELIMITER //
CREATE PROCEDURE GetOwnerNameByID(IN O_ID int , OUT O_Name varchar(255))
BEGIN
 SELECT username into O_Name 
 from owner where owner_id=O_ID;
END //
DELIMITER ;
CALL GetOwnerNameByID(1,@name);
select @name;
-- procedure 12: create a procedure for highest value proeprty
DELIMITER //
CREATE PROCEDURE GetMaxPropertyPrice(OUT MAX_Price DECIMAL(10,2))
BEGIN
   SELECT max(price_per_night) into MAX_Price from property ;
   
END//
DELIMITER ; 
CALL GetMaxPropertyPrice(@PRICE);
SELECT @PRICE

-- PROCEDURE 13 - CREATE A DISCOUNT ON PRICE 
DELIMITER //
CREATE PROCEDURE GetDiscountedPrice(IN P_id int, OUT Final_price DECIMAL(10,2))
BEGIN
SELECT (price_per_night *0.9) into Final_price  
from property 
where property_id=P_ID;
END//
delimiter ;
CALL GetDiscountedPrice(1,@PRICE);
SELECT @PRICE;
SELECT * FROM property_price_logs;
select * from property;
-- prolcedure - 14
DELIMITER //
CREATE PROCEDURE Check_Availability(IN ID int, OUT status varchar(15))
BEGIN
 
END