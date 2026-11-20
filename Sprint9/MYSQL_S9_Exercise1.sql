use accommodation;
-- Exercise 1
-- Task1
USE accommodation;
drop procedure if exists property_summary;
-- TASK 1
DELIMITER //
CREATE PROCEDURE property_summary (
	IN p_id INT,
    IN start_date DATE,
    IN end_date DATE
)
BEGIN
	IF p_id NOT IN (SELECT property_id FROM property)
	THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Invalid `product_id`';
	ELSEIF start_date IS NULL OR
		end_date IS NULL OR
		end_date < start_date
    THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Invalid `start_date` or `end_date`';
    ELSE
		SELECT p.property_name,
			COALESCE(SUM(b.total_amount), 0) AS total_revenue,
			COUNT(b.booking_id) AS booking_count
		FROM property p
		LEFT JOIN booking b
			ON p.property_id = b.property_id
	        AND
			b.check_in_date >= start_date 
            AND
			b.check_out_date <= end_date
		    WHERE p.property_id = p_id		
        GROUP BY b.property_id,p.property_name;
	END IF;
END //
DELIMITER ;

-- Gives summary of 'The Oberoi Udaivilas' property (ID 1)
-- for the year 2025
CALL property_summary(1, '2025-01-01', '2025-12-31');

DROP PROCEDURE IF EXISTS 
GetPropertyRevenue;
-- TASK 2
DELIMITER //
CREATE PROCEDURE customer_history(
	IN c_id INT
)
BEGIN
	IF c_id NOT IN (
		SELECT customer_id FROM booking
	)
    THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Invalid customer_id';
	ELSE
		SELECT b.booking_id,
			p.property_name,
            b.check_in_date,
            b.check_out_date,
            b.total_amount,
            b.status
		FROM booking b
        JOIN property p
			ON b.property_id = p.property_id
		WHERE b.customer_id = c_id;
	END IF;
END //
DELIMITER ;
-- Display booking history for customer 'Ravi Kumar' (ID 1)
CALL customer_history(1);

-- TASK 3
DELIMITER //
CREATE PROCEDURE top_rated_properties(
	IN p_loc VARCHAR(200), -- NULL to exclude filter
    IN p_type ENUM('Hotel', 'Homestay', 'Apartment', 'Villa') -- NULL to exclude filter
)
BEGIN
	IF p_loc IS NOT NULL AND
		p_loc NOT IN (
			SELECT DISTINCT location FROM property
		)
	THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Invalid location.';
	END IF;
        
	IF (
		SELECT COUNT(*) FROM (
        SELECT p.property_id
        FROM property p
		JOIN booking b
			ON p.property_id = b.property_id
		JOIN review r
			ON b.booking_id = r.booking_id
		WHERE
			CASE
				WHEN p_loc IS NULL THEN 1 = 1
				ELSE p.location = p_loc
			END AND
			CASE
				WHEN p_type IS NULL THEN 1 = 1
				ELSE p.property_type = p_type
			END
		GROUP BY p.property_id
		HAVING AVG(rating) > 4.0
		) top_rated_p
	) = 0
    THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'No matching properties exist.';
	END IF;
	
	SELECT p.property_id,
		p.property_name,
		p.location,
		p.property_type,
		AVG(r.rating) AS average_rating
	FROM property p
	JOIN booking b
		ON p.property_id = b.property_id
	JOIN review r
		ON b.booking_id = r.booking_id
	WHERE
		CASE
			WHEN p_loc IS NULL THEN 1 = 1
			ELSE p.location = p_loc
		END AND
		CASE
			WHEN p_type IS NULL THEN 1 = 1
			ELSE p.property_type = p_type
		END
	GROUP BY p.property_id
	HAVING AVG(rating) > 4.0;
END //
DELIMITER ;
-- Find top-rated properties in all locations for all property types
CALL top_rated_properties(NULL, NULL);