/*
 
*/
select * from Customer;
select count(id) as totalcustomer from Customer;
select * from `Source`;
select count(id) as totalsourceperson from `source`;

select * from Publisher;
select count(id) from publisher;
select * from Book ;
select count(id) as totalbook from Book;
select * from warehouseproduct  ;
select * from media where pub_id=15;
select * from customerphone;
select * from productcheckout;
select * from publisherphone;
select * from sourceproduct;
select * from warehouse;
select * from checkout;

/*                    1.Count Books by Publisher
Bussiness Goal : To find out how many titles each publisher has contributed to the library.*/
-- Query 1:Retrieve the total count of books associated with each publisher
select pub_id,count(id)as total_books
from book 
group by pub_id 
order by total_books desc limit 5;

/*                     2.Customer Contact List(Joins)    
 Business Goal:To create a directory of customers along with their registered phone numbers for the marketing team */ 
-- Query2: Fetch customer names and their corresponding contact numbers using a join 
SELECT substr(c_name,1,instr(c_name," ")-1)as f_name,substr(c_name,instr(c_name," ")+1) as L_name,cp.cust_phone
FROM customer c
JOIN customerphone cp 
ON c.id=cp.c_id;
/*                     3.Invenotry Avilablity by location     
  Business Goal : To check which books are potentially linked to specific warehouse locations(publisher based storage).
  Query 3:Display warehouse city along with book titles and avilable quantities */
  
  SELECT w.city,b.title,b.quantity 
  FROM warehouse w
  JOIN book b 
  ON w.id=b.pub_id;
  /*                   4.High Value Product Analysis 
   Business Goal :To identify the top 5 most expensive books in the inventory for premium sales tracking 
   Query 4 :List the top 5 highest priced books in descending order */
   
   SELECT title ,price,category 
   FROM book 
   ORDER BY price DESC
   LIMIT 5;
   
   /*               5.Category-wise Pricing Strategy
   Business Goal :To calcluate the average price of books in each category top understand market segments.
   Query 5: Calculate the average price of books for evry category                                             */ 
   
   
   SELECT category,AVG(price) average_price 
   FROM book 
   GROUP BY category 
   order by average_price desc
   limit 5;
   
   /*                 6. Media Asset Audit 
   Business Goal: To monitor digital media files (EPUB/PDF) that are large in size for server optimization.
   Query 6 : Filter media records when the file size exceeds a specific threshold (e.g.5MB)     */
 
 SELECT title ,m_link,filesize
 FROM media 
 WHERE filesize>'5000' order by filesize desc  limit 5;
   
 /*  
   
   1. Customer Purchase Audit (Customer + Checkout + Product)
The Goal: To see exactly which books each customer bought. This connects the customer details to their actual purchases.
-- Join 3 Tables: Customer, Checkout, and Book (Product)

*/
SELECT 
    SUBSTRING_INDEX(c.c_name, ' ', 1) AS first_name,
    b.title AS book_purchased,
    ch.ch_date AS transaction_date,
    ch.ch_type AS payment_method
FROM Customer c
JOIN Checkout ch ON c.id = ch.c_id
JOIN ProductCheckout pc ON ch.id = pc.ch_id  
JOIN Book b ON pc.prod_id = b.id;
/*
2. Physical Inventory Location (Book + Publisher + Warehouse)
The Goal: To find where a specific book is stored based on its publisher's location. This helps the logistics team find the stock.

SQL
Join 3 Tables: Book, Publisher, and Warehouse            */
SELECT 
    b.title,
    p.p_name AS publisher,
    w.city AS warehouse_location,
    w.zip AS warehouse_zip
FROM book b
JOIN publisher p ON b.pub_id = p.id

JOIN warehouseproduct wp ON b.id = wp.prod_id
JOIN warehouse w ON wp.w_id = w.id;
/*
Purpose: To filter data based on dynamic values (like averages) or relationships in other tables.

SQL
 A. Find books with a price higher than the average price of all books*/
SELECT title, price 
FROM book 
WHERE price > (SELECT AVG(price) FROM book);

/*
2. Indexes (Performance Optimization)
Purpose: To speed up data retrieval and join operations by creating a lookup path for the database engine.

SQL
 A. Create an index on the Foreign Key (c_id) in the Checkout table to speed up Customer joins
*/
CREATE INDEX idx_checkout_customer ON checkout(c_id);

-- B. Create an index on the Foreign Key (p_id) in the Book table for faster Publisher reports
CREATE INDEX idx_book_publisher ON book(pub_id);

-- C. Create an index on the 'title' column to optimize search performance for book titles
CREATE INDEX idx_book_title ON book(title);





-- C. Complex Join: Linking Customer, Checkout, and Book details
SELECT 
    SUBSTRING_INDEX(c.cust_name, ' ', 1) AS first_name,
    b.title AS book_purchased,
    ch.ch_date AS transaction_date
FROM customer c
JOIN checkout ch ON c.id = ch.c_id
JOIN book b ON ch.id = b.id;
/*
4. Query Performance Testing (EXPLAIN)
Purpose: To verify if the indexes are actually being used by the database.

SQL
 Analyze the execution plan to verify index usage during a join
EXPLAIN
*/ 
SELECT b.title, p.p_name 
FROM book b 
JOIN publisher p ON b.pub_id = p.id;
/* Note for your Documentation:Subqueries were used to handle conditional filtering without hardcoding values.
Indexes were implemented to reduce the "Row Scan" count, significantly improving query execution time for the 101+ records.
*/