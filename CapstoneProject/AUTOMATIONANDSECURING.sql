/*Step 4: Automating and Securing Data
1. Stored Procedures (Automation)
Purpose: To wrap complex or frequent queries into a single command. This is efficient for tasks like checking the stock of a specific book.

SQL
 Procedure: Get Book Stock by Title
 This procedure allows you to search for the quantity of a book simply by entering its title.
*/
DROP PROCEDURE IF EXISTS GetBookStock;
DELIMITER //
CREATE PROCEDURE GetBookStock(IN book_title VARCHAR(255))
BEGIN
    SELECT title, quantity 
    FROM book 
    WHERE title = book_title;
END //
DELIMITER ;
/*
 How to use:
 CALL GetBookStock('Python Mastery');
2. Triggers (Business Rule Enforcement)
Purpose: To automatically perform an action when data is inserted or updated. A common use case is preventing a sale if the stock is zero.

SQL
 Trigger: Prevent Sale if Stock is Zero
 This trigger automatically stops a 'Checkout' entry if the book is out of stock.
*/
DELIMITER //
CREATE TRIGGER check_stock_before_sale
BEFORE INSERT ON checkout
FOR EACH ROW
BEGIN
    DECLARE available_stock INT;
    
    SELECT quantity INTO available_stock 
    FROM book 
    WHERE id = NEW.id;
    
    IF available_stock <= 0 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Error: Book is out of stock!';
    END IF;
END //
DELIMITER ;
/*3. Transaction Management (Security & Integrity)
Purpose: To ensure that a series of operations either all succeed or all fail together (Atomic operations). This is critical for financial records or stock updates.

SQL
 Scenario: Processing a Sale (Deducting stock and recording the checkout)
*/
SET sql_safe_updates=0;
START TRANSACTION;

-- Step 1: Record the checkout
INSERT INTO checkout (id, c_id, ch_date, ch_type) 
VALUES (301, 1, '2026-03-29', 'Digital');
SAVEPOINT sp1;
-- Step 2: Update (Decrease) the book stock
UPDATE book 
SET quantity = quantity - 1 
WHERE id = '0060502935';
ROLLBACK to sp1;
-- Check for errors: If something goes wrong, use ROLLBACK;
-- If everything is correct:
COMMIT;

-- Note: Use SAVEPOINT if you want to roll back to a specific part of the transaction
/*
 Interesting transactions that can be run in the database
*/

/*
 Add a completely new Book with a new Author and Publisher (and their phone number), 
 none of which exist in the database
*/
START TRANSACTION;
  -- inserting author data into Source table first
  INSERT INTO Source (id, s_name) VALUES 
    (1000, "J. K. Rowling");
  -- inserting publisher data into Publisher table
  INSERT INTO Publisher (id, p_name, city, zip) VALUES 
    (1000, "Bloomsbury", "London", 83289);
  -- inserting publisher phone data into PublisherPhone table
  INSERT INTO PublisherPhone (pub_phone, pub_id) VALUES 
    ("(800)-289-2891", 1000);
  -- inserting book data into Book table
  INSERT INTO Book (id, title, pub_id, prod_year, price, category, quantity, b_format, filesize) VALUES 
    ("0-7475-3269-9", "Harry Potter and the Philosopher's Stone", 1000, 1997, 24.95, "Fiction", 20, "epub", 3188);
  -- inserting relationship between Source (author) and Product (book/media) table
  INSERT INTO SourceProduct (id, prod_id, s_id) VALUES 
    (1000, "0-7475-3269-9", 1000);
COMMIT;

/*
 A new customer just bought a book, so they need to be added to the database, 
 along with their phone number and Checkout information
*/
START TRANSACTION;
  -- inserting new customer data into Customer table
  INSERT INTO Customer (id, c_name, c_email) VALUES 
    (1000, "Pranay Methuku", "pranaymethuku@gmail.com");
  -- inserting customer phone data into CustomerPhone table
  INSERT INTO CustomerPhone (cust_phone, c_id) VALUES 
    ("(614)-192-2891", 1000),
    ("(614)-192-2910", 1000);
  -- inserting checkout data into Checkout table
  INSERT INTO Checkout (id, c_id, ch_type, ch_date) VALUES 
    (1901, 1000, "Coupon", "2018-12-02");
  -- inserting product data for each checkout into ProductCheckout table
  INSERT INTO ProductCheckout (id, prod_id, ch_id) VALUES 
    (1230, "0471358983", 1901),
    (1231, "0670031518", 1901),
    (1232, "0130998516", 1901);
  UPDATE Book SET quantity = quantity - 1 WHERE 
    id = "0471358983" OR 
    id = "0670031518" OR 
    id = "0130998516";
COMMIT;

/* 
  An existing customer wants to return their purchased books.
*/
START TRANSACTION;
  INSERT INTO Checkout (id, c_id, ch_type, ch_date) VALUES 
    (1902, 1000, "Refund", "2018-12-04");
  -- inserting product data for each checkout into ProductCheckout table
  INSERT INTO ProductCheckout (id, prod_id, ch_id) VALUES 
    (1234, "0471358983", 1902),
    (1235, "0670031518", 1902);
  UPDATE Book SET quantity = quantity + 1 WHERE 
    id = "0471358983" OR 
    id = "0670031518"; 
COMMIT;
/*
1. Storing and Retrieving JSON Data (MySQL)
Business Goal: To store complex book metadata (like Reviews or Technical Specs) that doesn't fit into a standard column.

A. Adding a JSON Column to Book Table
SQL
*/
-- Adding a JSON column to store book reviews and ratings dynamically

ALTER TABLE book ADD COLUMN metadata JSON;
/*B. Inserting JSON Data
SQL*/
-- Inserting a book record with JSON metadata

UPDATE book 
SET metadata = '{"rating": 4.5, "reviews": 120, "tags": ["bestseller", "tech"]}' 
WHERE id = '0060502935';
/*
C. Retrieving Specific JSON Values
SQL
*/
-- Extracting the 'rating' value from the JSON metadata column
SELECT title, metadata->'$.rating' AS book_rating 
FROM book 
WHERE metadata->'$.rating' > 4.0;
/*
Feature 1 (View): Create a View for "Out of Stock Books" to help the manager.

Feature 2 (User Validation): Using CHECK Constraints to ensure prices are never negative.

SQL
*/
-- Feature: Creating a View for Inventory Management
CREATE VIEW low_stock_books AS 
SELECT title, quantity FROM book WHERE quantity < 5;
/*
 Interesting Views that can be generated from the database
*/

-- For a particular book, see how much revenue the book has generated.
CREATE VIEW BookRevenue (ISBN, book_name, revenue) AS
SELECT b.id, b.title, b.price * COUNT(pc.id) 
FROM Book b, ProductCheckout pc
WHERE pc.prod_id = b.id
GROUP BY b.id;

-- For a particular author, see how much revenue they have generated to the bookstore.
CREATE VIEW AuthorRevenue (author_id, author_name, revenue) AS
SELECT s.id, s_name, b.price * COUNT(pc.ch_id) 
FROM Source s, SourceProduct sp, Book b, ProductCheckout pc
WHERE s.id = sp.s_id AND sp.prod_id = b.id AND b.id = pc.prod_id
GROUP BY s.id;
/*
Business Goal: To create a short-term report of "Top Selling Books" for a specific promotion. This table will automatically delete itself once the session ends.

SQL
*/
-- Creating a Temporary Table to store high-performing books for a marketing campaign
CREATE TEMPORARY TABLE top_performing_books AS
SELECT title, price, quantity 
FROM book 
WHERE quantity   > 50;

-- Querying the Temporary Table
SELECT * FROM top_performing_books WHERE price > 500;
/*
Business Goal: Imagine you want the database to automatically check every night which books are "Low Stock" and prepare a report. For this, we use an EVENT.

SQL Code from the image:
SQL*/
-- Requirement: Automating tasks with Event Scheduler
-- This event runs every day to clear out any temporary logs or old data.

SET GLOBAL event_scheduler = ON;

CREATE EVENT daily_stock_check
ON SCHEDULE EVERY 1 DAY
STARTS CURRENT_TIMESTAMP
DO
  INSERT INTO inventory_audit (audit_date, msg)
  SELECT CURRENT_DATE, CONCAT('Low stock alert for: ', title)
  FROM book
  WHERE quantity < 5;