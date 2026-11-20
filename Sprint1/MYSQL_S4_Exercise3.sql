-- Task 1

select p.property_id,p.property_name,p.location ,p.price_per_night
from property p 
where p.price_per_night>(select avg(p2.price_per_night)
from property p2 
where p2.location =p.location);

-- Task 2

select p.property_id,p.property_name ,p.location,p.price_per_night,o.first_name,o.last_name
from property p 
join owner o on p.owner_id=o.owner_id
where p.price_per_night=(select min(p2.price_per_night)
from property p2
where p2.location=p.location);
