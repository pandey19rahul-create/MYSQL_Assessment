-- Exercise 5
SELECT 
 P.property_name, 
 P.location, 
 B.booking_id 
FROM property P
LEFT JOIN booking B 
ON P.property_id=B.property_id;




 









