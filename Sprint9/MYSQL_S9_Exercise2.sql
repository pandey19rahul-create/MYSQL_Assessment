-- Exercise 2
-- Task 1
DELIMITER //

CREATE TRIGGER Before_Booking_Insert
BEFORE INSERT ON Booking
FOR EACH ROW
BEGIN
    DECLARE v_status VARCHAR(15);
    
    SELECT availability_status INTO v_status 
    FROM property 
    WHERE property_id = NEW.property_id;


    IF v_status = 'unavailable' THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Error: This property is currently unavailable for booking.';
    END IF;
END //

DELIMITER ;
-- querry for test
-- if  property_id 1 is not available

INSERT INTO Booking (customer_id, property_id, check_in_date, check_out_date, total_amount) 
VALUES (1, 1, '2024-05-01', '2024-05-05', 5000);
DROP TRIGGER IF EXISTS 
Before_Booking_Insert;
DELIMITER //
-- Task 2
CREATE TRIGGER After_Booking_Insert
AFTER INSERT ON Booking
FOR EACH ROW
BEGIN
   
    UPDATE property 
    SET availability_status = 'unavailable' 
    WHERE property_id = NEW.property_id;
END //

DELIMITER ;


-- Task 3
CREATE TABLE property_price_logs (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    property_id INT,
    previous_price DECIMAL(10,2),
    updated_price DECIMAL(10,2),
    change_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DELIMITER //

CREATE TRIGGER Log_Price_Change
AFTER UPDATE ON property
FOR EACH ROW
BEGIN
    
    IF OLD.price_per_night <> NEW.price_per_night THEN
        INSERT INTO property_price_logs (property_id, previous_price, updated_price)
        VALUES (OLD.property_id, OLD.price_per_night, NEW.price_per_night);
    END IF;
END //

DELIMITER ;


UPDATE property SET price_per_night = 1500.00 WHERE property_id = 1;


SELECT * FROM property_price_logs;