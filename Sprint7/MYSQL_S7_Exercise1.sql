use accommodation;
-- Task 1 and 2 
CREATE TABLE promotion (
    promotion_id INT AUTO_INCREMENT,
    promotion_title VARCHAR(100) NOT NULL,
    discount_percentage DECIMAL(5, 2) CHECK (discount_percentage BETWEEN 0 AND 100),
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    property_id INT, -- फॉरेन की के लिए कॉलम
    PRIMARY KEY (promotion_id),
    FOREIGN KEY (property_id) REFERENCES property(property_id)
);