-- Exercise 3
SELECT p.property_name, r.rating, r.review_text 
FROM property  p 
JOIN booking b
ON p.property_id=b.property_id 
JOIN review r
ON b.booking_id=r.booking_id;