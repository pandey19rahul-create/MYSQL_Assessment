-- Exercise 7 
SELECT b.booking_id, b.check_in_date, b.check_out_date, p.property_name 
FROM property p
RIGHT JOIN booking b ON b.property_id=p.property_id;