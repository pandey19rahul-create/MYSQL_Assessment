create database accommodation;

use accommodation;
-- SQL script to create the Online Accommodation Booking Platform database schema

-- Create customer table
CREATE TABLE customer (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(100) NOT NULL,
    first_name Varchar(50) NOT NULL,
    last_name Varchar(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    phone_number VARCHAR(15),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Create owner table
CREATE TABLE owner (
    owner_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(100) NOT NULL,
    first_name Varchar(50) NOT NULL,
    last_name Varchar(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    phone_number VARCHAR(15),
    business_name VARCHAR(150),
    business_registration_number VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Create property table
CREATE TABLE property (
    property_id INT AUTO_INCREMENT PRIMARY KEY,
    owner_id INT NOT NULL,
    property_name VARCHAR(150) NOT NULL,
    location VARCHAR(200),
    property_type ENUM('Hotel', 'Homestay', 'Apartment', 'Villa') NOT NULL,
    price_per_night DECIMAL(10, 2) NOT NULL,
    availability_status Varchar(150),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (owner_id) REFERENCES owner(owner_id)
);


-- Create booking table
CREATE TABLE booking (
    booking_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    property_id INT NOT NULL,
    check_in_date DATE NOT NULL,
    check_out_date DATE NOT NULL,
    total_amount DECIMAL(10, 2) NOT NULL,
    status ENUM('PENDING', 'CONFIRMED', 'CANCELLED', 'NO-SHOW', 'COMPLETED') DEFAULT 'PENDING',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (property_id) REFERENCES property(property_id)
);


-- Create review table
CREATE TABLE review (
    review_id INT AUTO_INCREMENT PRIMARY KEY,
    booking_id INT NOT NULL,
    customer_id INT NOT NULL,
    property_id INT NOT NULL,
    rating INT CHECK (rating BETWEEN 1 AND 5),
    review_text TEXT DEFAULT NULL,
    owner_response TEXT DEFAULT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (booking_id) REFERENCES booking(booking_id),
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (property_id) REFERENCES property(property_id)
);

-- Create amenity table
CREATE TABLE amenity (
    amenity_id INT AUTO_INCREMENT PRIMARY KEY,
    amenity_name VARCHAR(50) NOT NULL
);

-- Create property_amenity table
CREATE TABLE property_amenity (
    property_id INT NOT NULL,
    amenity_id INT NOT NULL,
    PRIMARY KEY (property_id, amenity_id),
    FOREIGN KEY (property_id) REFERENCES property(property_id),
    FOREIGN KEY (amenity_id) REFERENCES amenity(amenity_id)
);


-- Insert data into customer table
INSERT INTO customer (customer_id, username, first_name, last_name, email, password_hash, phone_number) VALUES
(1, 'ravi_kumar', 'Ravi', 'Kumar', 'ravi.kumar@example.com', 'hashed_password_1', '9876543210'),
(2, 'sneha_sharma', 'Sneha', 'Sharma', 'sneha.sharma@example.com', 'hashed_password_2', '9123456789'),
(3, 'amit_verma', 'Amit', 'Verma', 'amit.verma@example.com', 'hashed_password_3', '9012345678'),
(4, 'priya_singh', 'Priya', 'Singh', 'priya.singh@example.com', 'hashed_password_4', '9112233445'),
(5, 'rahul_gupta', 'Rahul', 'Gupta', 'rahul.gupta@example.com', 'hashed_password_5', '9223344556'),
(6, 'shweta_gupta', 'Shweta', 'Gupta', 'shweta.gupta@example.com', 'hashed_password_6', '8153344006'),
(7, 'amit_patil', 'Amit', 'Patil', 'amit.patil@example.com', 'hashed_password_7', '7852564006'),
(8, 'sunil_sharma', 'Sunil', 'Sharma', 'sunil.sharma@example.com', 'hashed_password_8', '7000112233'),
(9, 'mohit_mehta', 'Mohit', 'Mehta', 'mohit.mehta@example.com', 'hashed_password_9', '9898765432'),
(10, 'nisha_patel', 'Nisha', 'Patel', 'nisha.patel@example.com', 'hashed_password_10', '9198765432'),
(11, 'geeta_rani', 'Geeta', 'Rani', 'geeta.rani@example.com', 'hashed_password_11', '9612345678'),
(12, 'vikram_yadav', 'Vikram', 'Yadav', 'vikram.yadav@example.com', 'hashed_password_12', '9256789123'),
(13, 'shubham_singh', 'Shubham', 'Singh', 'shubham.singh@example.com', 'hashed_password_13', '9501234567'),
(14, 'manish_tiwari', 'Manish', 'Tiwari', 'manish.tiwari@example.com', 'hashed_password_14', '9812349876'),
(15, 'neha_kapoor', 'Neha', 'Kapoor', 'neha.kapoor@example.com', 'hashed_password_15', '9402323232'),
(16, 'ayesha_khan', 'Ayesha', 'Khan', 'ayesha.khan@example.com', 'hashed_password_16', '9200112233'),
(17, 'ravi_jain', 'Ravi', 'Jain', 'ravi.jain@example.com', 'hashed_password_17', '9911223344'),
(18, 'prachi_mishra', 'Prachi', 'Mishra', 'prachi.mishra@example.com', 'hashed_password_18', '9301122334'),
(19, 'ankit_shukla', 'Ankit', 'Shukla', 'ankit.shukla@example.com', 'hashed_password_19', '9002345678'),
(20, 'kanika_pandey', 'Kanika', 'Pandey', 'kanika.pandey@example.com', 'hashed_password_20', '9703344556');


-- Insert data into owner table
INSERT INTO owner (owner_id, username, first_name, last_name, email, password_hash, phone_number, business_name, business_registration_number) VALUES
(1, 'rajesh_verma', 'Rajesh', 'Verma', 'rajesh.verma@business.com', 'hashedpassword1', '9876543210', 'Verma property', 'BRN12345'),
(2, 'priya_sharma', 'Priya', 'Sharma', 'priya.sharma@domain.com', 'hashedpassword2', '9876543211', 'Sharma Hospitality', 'BRN12346'),
(3, 'amit_kumar', 'Amit', 'Kumar', 'amit.kumar@company.com', 'hashedpassword3', '9876543212', 'Kumar Enterprises', 'BRN12347'),
(4, 'suman_reddy', 'Suman', 'Reddy', 'suman.reddy@company.com', 'hashedpassword4', '9876543213', 'Reddy Resorts', 'BRN12348'),
(5, 'neha_gupta', 'Neha', 'Gupta', 'neha.gupta@service.com', 'hashedpassword5', '9876543214', 'Gupta Hotels', 'BRN12349'),
(6, 'vijay_patel', 'Vijay', 'Patel', 'vijay.patel@hotels.com', 'hashedpassword6', '9876543215', 'Patel Enterprises', 'BRN12350'),
(7, 'arun_singh', 'Arun', 'Singh', 'arun.singh@corporation.com', 'hashedpassword7', '9876543216', 'Singh Group', 'BRN12351'),
(8, 'kiran_mishra', 'Kiran', 'Mishra', 'kiran.mishra@business.com', 'hashedpassword8', '9876543217', 'Mishra Hospitality', 'BRN12352'),
(9, 'raj_bansal', 'Raj', 'Bansal', 'raj.bansal@domain.com', 'hashedpassword9', '9876543218', 'Bansal Enterprises', 'BRN12353'),
(10, 'meena_chopra', 'Meena', 'Chopra', 'meena.chopra@service.com', 'hashedpassword10', '9876543219', 'Chopra Resorts', 'BRN12354');



-- Insert data into property table
INSERT INTO property (property_id, owner_id, property_name, location, price_per_night,availability_status) VALUES
(1, 1, 'The Oberoi Udaivilas', 'Udaipur, Rajasthan', 25000.00,'available'),
(2, 2, 'Taj Mahal Palace', 'Mumbai, Maharashtra', 30000.00, 'available'),
(3, 3, 'Leela Palace', 'Bangalore, Karnataka', 20000.00,'available'),
(4, 4, 'ITC Grand Chola', 'Chennai, Tamil Nadu', 18000.00,'available'),
(5, 5, 'Hyatt Regency', 'Kolkata, West Bengal', 15000.00,'available'),
(6, 6, 'Four Seasons', 'Kolkata, West Bengal', 12000.00,'available'),
(7, 6, 'The Ferns', 'Kolkata, West Bengal', 11000.00,'available'),
(8, 7, 'ITC Grand Bengal', 'Kolkata, West Bengal', 18000.00,'unavailable'),
(9, 4, 'ITC Windsor','Bangalore, Karnataka', 32000.00,'available');

-- Insert data into booking table
INSERT INTO booking (booking_id, customer_id, property_id, check_in_date, check_out_date, total_amount, status) VALUES
(1, 1, 1, '2024-12-01', '2024-12-05', 100000.00, 'CONFIRMED'),
(2, 2, 2, '2024-12-10', '2024-12-12', 60000.00, 'PENDING'),
(3, 3, 3, '2024-12-15', '2024-12-20', 100000.00, 'CONFIRMED'),
(4, 4, 4, '2024-12-25', '2024-12-28', 54000.00, 'CANCELLED'),
(5, 5, 5, '2024-12-30', '2025-01-02', 45000.00, 'NO-SHOW'),
(6, 1, 2, '2025-01-10', '2025-01-12', 60000.00, 'CONFIRMED'),
(7, 2, 3, '2025-01-15', '2025-01-18', 80000.00, 'CONFIRMED'),
(8, 4, 1, '2025-01-20', '2025-01-25', 125000.00, 'CONFIRMED'),
(9, 5, 7, '2025-02-01', '2025-02-03', 22000.00, 'PENDING'),
(10, 3, 5, '2025-02-10', '2025-02-14', 60000.00, 'CONFIRMED'),
(11, 1, 3, '2025-03-01', '2025-03-05', 100000.00, 'CONFIRMED'),
(12, 2, 4, '2025-03-10', '2025-03-12', 54000.00, 'PENDING'),
(13, 3, 1, '2025-03-15', '2025-03-20', 125000.00, 'CONFIRMED'),
(14, 4, 2, '2025-03-25', '2025-03-28', 90000.00, 'CANCELLED'),
(15, 5, 7, '2025-04-01', '2025-04-03', 22000.00, 'CONFIRMED'),
(16, 1, 5, '2025-04-10', '2025-04-14', 60000.00, 'NO-SHOW'),
(17, 3, 3, '2025-04-15', '2025-04-18', 80000.00, 'CONFIRMED'),
(18, 4, 1, '2025-04-20', '2025-04-25', 125000.00, 'CONFIRMED'),
(19, 2, 7, '2025-05-01', '2025-05-03', 33000.00, 'PENDING'),
(20, 5, 2, '2025-05-10', '2025-05-12', 60000.00, 'CONFIRMED'),
(21, 6, 3, '2025-05-15', '2025-05-18', 85000.00, 'CONFIRMED'),
(22, 7, 4, '2025-05-20', '2025-05-22', 70000.00, 'PENDING'),
(23, 8, 5, '2025-06-01', '2025-06-03', 45000.00, 'NO-SHOW'),
(24, 9, 2, '2025-06-05', '2025-06-08', 50000.00, 'CONFIRMED'),
(25, 6, 1, '2025-06-10', '2025-06-12', 120000.00, 'CANCELLED'),
(26, 7, 4, '2025-06-15', '2025-06-18', 60000.00, 'PENDING'),
(27, 8, 3, '2025-06-20', '2025-06-25', 70000.00, 'CONFIRMED'),
(28, 9, 2, '2025-06-25', '2025-06-28', 80000.00, 'CONFIRMED'),
(29, 11, 5, '2025-07-01', '2025-07-05', 110000.00, 'CONFIRMED'),
(30, 12, 4, '2025-07-05', '2025-07-08', 60000.00, 'NO-SHOW'),
(31, 6, 7, '2025-07-10', '2025-07-12', 35000.00, 'PENDING'),
(32, 7, 1, '2025-07-15', '2025-07-18', 75000.00, 'CONFIRMED'),
(33, 8, 3, '2025-07-20', '2025-07-23', 80000.00, 'CONFIRMED'),
(34, 9, 4, '2025-07-25', '2025-07-28', 90000.00, 'CANCELLED'),
(35, 11, 2, '2025-08-01', '2025-08-03', 50000.00, 'PENDING');


-- Insert data into review table
INSERT INTO review (booking_id, customer_id, property_id, rating, review_text, owner_response) VALUES
(1, 1, 1, 5, 'Excellent service and location. Highly recommend!', NULL),
(2, 2, 2, 4, 'Beautiful property with great amenity. Food could be better.', NULL),
(3, 3, 3, 5, 'Luxurious stay with spacious rooms. Will visit again.', NULL),
(4, 4, 4, 4, 'Elegant hotel with courteous staff. Slightly overpriced.', NULL),
(6, 1, 2, 5, 'Outstanding experience. The hospitality was top-notch!', 'Thank you for your kind words. We look forward to hosting you again!'),
(7, 2, 3, 4, 'Well-maintained property with good amenity.', 'Glad you enjoyed your stay! We will improve further.'),
(8, 4, 1, 5, 'A truly peaceful and rejuvenating stay.', 'Thank you for your feedback.'),
(9, 5, 7, 3, 'Average service, but the location was great.', NULL),
(10, 3, 5, 4, 'Pleasant stay but could improve room cleanliness.', 'Apologies for the inconvenience. We will work on it.'),
(11, 1, 3, 5, 'Exceptional service. Highly recommended for families!', 'We are delighted to hear this. Thank you!'),
(12, 2, 4, 4, 'The staff were very helpful and the ambiance was great.', NULL),
(13, 3, 1, 5, 'Amazing property with all modern facilities.', 'Thank you for your positive feedback.'),
(15, 5, 7, 3, 'Decent stay, but the food options were limited.', NULL),
(19, 2, 7, 4, 'Comfortable and cozy, but could improve on check-in process.', 'Thank you for bringing this to our attention.'),
(21, 6, 3, 5, 'Great experience! Highly recommend the property for a family getaway.', 'We appreciate your kind words and hope to welcome you back soon!'),
(23, 8, 5, 4, 'A lovely stay, the property was peaceful and clean, would stay again.', 'We’re glad you had a peaceful stay. Looking forward to welcoming you again!'),
(25, 6, 1, 5, 'A great experience with friendly staff and fantastic ambiance.', 'We are thrilled you enjoyed your stay. Thank you for your feedback!'),
(26, 7, 4, 4, 'Comfortable stay with great facilities, but the food options were limited.', 'Thanks for your review! We’ll look into expanding food options.'),
(27, 8, 3, 5, 'The property was beautiful and staff were exceptional. Highly recommend.', 'We are happy you enjoyed your stay. We hope to see you again soon!'),
(28, 9, 2, 4, 'Excellent property and location. Will visit again.', 'Thank you! We’re glad you loved your stay. Looking forward to your next visit.'),
(29, 11, 5, 5, 'Amazing property with great facilities. The staff was very helpful.', 'Thank you for your kind words. We hope to host you again!'),
(30, 12, 4, 4, 'Good stay but could improve the room cleanliness.', 'We apologize for the inconvenience. We will address this promptly.'),
(31, 6, 7, 4, 'Great location and overall a pleasant stay, will recommend to others.', 'Thank you for recommending us! We hope to have you back soon.'),
(32, 7, 1, 5, 'Fantastic hospitality and scenic views. Memorable experience!', 'We’re thrilled to hear that. Hope to welcome you again.'),
(33, 8, 3, 5, 'Best value for money. Clean and modern amenities.', 'Thanks for the appreciation. We’ll keep up the good work.'),
(35, 11, 2, 5, 'Excellent experience, would love to visit again soon.', 'We are delighted you had an excellent stay. Thank you for your review!');


-- Insert data into amenity table
INSERT INTO amenity (amenity_id, amenity_name) VALUES
(1, 'Wi-Fi'),
(2, 'Pool'),
(3, 'Gym'),
(4, 'Spa'),
(5, 'Restaurant'),
(6, 'Parking'),
(7, 'Conference Room'),
(8, 'Laundry Service'),
(9, 'Bar'),
(10, 'Pet-Friendly');

-- Insert data into property_amenity table
INSERT INTO property_amenity (property_id, amenity_id) VALUES
(1, 1), (1, 2), (1, 3), (1, 4), (1, 5),
(2, 1), (2, 2), (2, 3), (2, 4), (2, 5),
(3, 1), (3, 2), (3, 3), (3, 4), (3, 5),
(4, 1), (4, 2), (4, 3), (4, 4), (4, 5),
(5, 1), (5, 2), (5, 3), (5, 4), (5, 5),
(6, 1), (6, 2), (6, 6), -- Property 6 has Wi-Fi, Pool, Parking
(7, 1), (7, 7), (7, 6), -- Property 7 has Wi-Fi, Conference Room, Parking
(8, 1), (8, 3), (8, 10), -- Property 8 has Wi-Fi, Gym, Pet-Friendly
(3, 6), -- Adding Parking to Property 3
(4, 7), -- Adding Conference Room to Property 4
(5, 9), -- Adding Bar to Property 5
(6, 10); -- Adding Pet-Friendly to Property 6
select * from property;
select * from booking;
