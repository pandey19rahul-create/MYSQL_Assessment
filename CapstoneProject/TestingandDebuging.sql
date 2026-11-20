/*Test Case: If you try to run*/
 INSERT INTO book (price) VALUES (-50);-- the database will reject it with an error, proving the validation works.
 
 
/* Exception Handling (Graceful Error Management)
To prevent system crashes during complex operations (like deleting a record that is linked to other tables), we use Condition Handlers.

Logic: Instead of showing a raw MySQL error code, we "catch" the error and display a user-friendly message.

SQL Implementation:

SQL
*/
DELIMITER //
CREATE PROCEDURE SecureDeleteBook(IN target_id INT)
BEGIN
    -- Handler for Foreign Key Violations (Error 1451)
    DECLARE EXIT HANDLER FOR 1451
    BEGIN
        SELECT 'Error: Cannot delete this book. It is currently linked to an active checkout record.' AS Debug_Message;
    END;

    DELETE FROM book WHERE id = target_id;
    SELECT 'Success: Book removed from inventory.' AS Debug_Message;
END 
DELIMITER //
/* The Specific Error Handler (For Duplicate Data)
Use this when you know exactly which error might happen (like Error 1062 for Duplicate entries).

SQL
*/
DELIMITER //
CREATE PROCEDURE AddNewBookSecure(IN b_id INT ,IN b_title VARCHAR(255))
BEGIN
DECLARE EXIT HANDLER FOR 1062 
BEGIN
    SELECT 'Error: This ID is already taken. Please use a unique ID.' AS Message;
END;
-- 2. Then write your actual SQL logic
    INSERT INTO book (id, title) VALUES (b_id, b_title);
END //

DELIMITER ; 
CALL AddNewBookSecure()
/*B. The Validation Handler (For Foreign Keys)
Use this in your "Delete" procedures to prevent breaking the links between tables.

SQL
*/
DELIMITER //
CREATE PROCEDURE SecureDeleteBook(IN target_id INT)
BEGIN
DECLARE EXIT HANDLER FOR 1451 
BEGIN
    SELECT 'Error: This record is linked to other tables and cannot be deleted.' AS Message;
END;
	-- Actual Delete Operation
    DELETE FROM book WHERE id = target_id;
END //

DELIMITER ;

/*Fix for Error 1062 (Duplicate Entry)
Use this to prevent the same ID from being used twice (Validation).
*/
DELIMITER //
CREATE PROCEDURE AddBookWithValidation(IN b_id INT, IN b_title VARCHAR(255))
BEGIN
    -- Handler for Duplicate Keys
    DECLARE EXIT HANDLER FOR 1062
    BEGIN
        SELECT 'Error: This ID is already taken. Please use a unique ID.' AS Message;
    END;

    -- Insertion Logic
    INSERT INTO book (id, title) VALUES (b_id, b_title);
END //

DELIMITER ;
/*
C. The "Global" Catch-All (For Unexpected Crashes)
Use SQLEXCEPTION as a safety net for any error you didn't specifically plan for.

SQL
*/

DELIMITER //

CREATE PROCEDURE GlobalSafeUpdate(IN b_id INT, IN new_price DECIMAL(10,2))
BEGIN
    -- Catches ANY SQL Exception
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SELECT 'An unexpected error occurred. Operation rolled back.' AS Message;
    END;

    UPDATE book SET price = new_price WHERE id = b_id;
END //

DELIMITER ;-- Debugging a search query to see if it uses the index we created in Step 3
/*The "Transaction Safety" Handler (Essential)
Standard exception handling only shows a message. A professional handler must also Rollback any partial changes so your data doesn't get corrupted if a query fails halfway.

SQL
*/
DELIMITER //

CREATE PROCEDURE ProcessSaleWithRollback(IN b_id INT, IN c_id INT)
BEGIN
    -- This handler ensures that if the second query fails, the first one is canceled
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SELECT 'Transaction Failed: System rolled back to prevent data corruption.' AS Status;
    END;

    START TRANSACTION;
        -- Step 1: Record the sale
        INSERT INTO checkout (id, c_id, ch_date) VALUES (b_id, c_id, NOW());
        
        -- Step 2: Deduct stock (If this fails, the INSERT above is undone)
        UPDATE book SET quantity = quantity - 1 WHERE id = b_id;
    COMMIT;
END //

DELIMITER ;
/*2. Handling "Data Not Found" (NOT FOUND)
Sometimes a query doesn't "error" out, but it finds nothing. Handling this prevents your API or application from getting empty results.

SQL
*/

/*3. Custom Error Signaling (User-Defined Exceptions)
Sometimes the data is "valid" for SQL but "invalid" for your business. For example, a price of ₹0.01 is technically a number, but you might want to block it.

SQL
*/
DELIMITER //

CREATE PROCEDURE SetMinPrice(IN b_id INT, IN new_price DECIMAL(10,2))
BEGIN
    -- Manually 'Signal' an error if business logic is violated
    IF new_price < 100 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Business Rule Error: Minimum book price must be 100.';
    ELSE
        UPDATE book SET price = new_price WHERE id = b_id;
    END IF;
END //

DELIMITER ;
EXPLAIN SELECT * FROM book WHERE title = 'Data Analytics with Python';