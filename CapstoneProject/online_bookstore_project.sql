create database online_bookstore;

use online_bookstore;

CREATE TABLE Customer (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20),
    address TEXT
);
select * from Customer;
INSERT INTO Customer (name, email, phone, address) VALUES
('John Smith', 'john.smith@example.com', '555-123-4567', '123 Main St, Anytown, USA'),
('Emily Johnson', 'emily.j@example.com', '555-234-5678', '456 Oak Ave, Somewhere, USA'),
('Michael Brown', 'michael.b@example.com', '555-345-6789', '789 Pine Rd, Nowhere, USA'),
('Sarah Davis', 'sarah.d@example.com', '555-456-7890', '321 Elm St, Anywhere, USA'),
('Robert Wilson', 'robert.w@example.com', '555-567-8901', '654 Maple Dr, Everywhere, USA'),
('Jennifer Miller', 'jennifer.m@example.com', '555-678-9012', '987 Cedar Ln, Somewhere, USA'),
('William Taylor', 'william.t@example.com', '555-789-0123', '135 Birch Blvd, Nowhere, USA'),
('Jessica Anderson', 'jessica.a@example.com', '555-890-1234', '246 Spruce Way, Anywhere, USA'),
('David Thomas', 'david.t@example.com', '555-901-2345', '369 Willow Ct, Everywhere, USA'),
('Lisa Jackson', 'lisa.j@example.com', '555-012-3456', '482 Aspen Pl, Anytown, USA'),
('James White', 'james.w@example.com', '555-123-7890', '159 Redwood St, Somewhere, USA'),
('Karen Harris', 'karen.h@example.com', '555-234-8901', '753 Sequoia Ave, Nowhere, USA'),
('Christopher Martin', 'chris.m@example.com', '555-345-9012', '864 Magnolia Rd, Anywhere, USA'),
('Nancy Thompson', 'nancy.t@example.com', '555-456-0123', '975 Dogwood Dr, Everywhere, USA'),
('Daniel Garcia', 'daniel.g@example.com', '555-567-1234', '381 Sycamore Ln, Anytown, USA'),
('Susan Martinez', 'susan.m@example.com', '555-678-2345', '492 Chestnut Blvd, Somewhere, USA'),
('Matthew Robinson', 'matthew.r@example.com', '555-789-3456', '513 Poplar Way, Nowhere, USA'),
('Betty Clark', 'betty.c@example.com', '555-890-4567', '624 Juniper Ct, Anywhere, USA'),
('Anthony Rodriguez', 'anthony.r@example.com', '555-901-5678', '735 Fir Pl, Everywhere, USA'),
('Dorothy Lewis', 'dorothy.l@example.com', '555-012-6789', '846 Hemlock St, Anytown, USA'),
('Kevin Lee', 'kevin.l@example.com', '555-123-8901', '957 Alder Ave, Somewhere, USA'),
('Donna Walker', 'donna.w@example.com', '555-234-9012', '168 Beech Rd, Nowhere, USA'),
('Steven Hall', 'steven.h@example.com', '555-345-0123', '279 Spruce Dr, Anywhere, USA'),
('Carol Young', 'carol.y@example.com', '555-456-1234', '380 Oak Ln, Everywhere, USA'),
('Edward Allen', 'edward.a@example.com', '555-567-2345', '491 Pine Blvd, Anytown, USA'),
('Margaret King', 'margaret.k@example.com', '555-678-3456', '502 Maple Way, Somewhere, USA'),
('Ronald Scott', 'ronald.s@example.com', '555-789-4567', '613 Cedar Ct, Nowhere, USA'),
('Sharon Green', 'sharon.g@example.com', '555-890-5678', '724 Birch Pl, Anywhere, USA'),
('Jason Baker', 'jason.b@example.com', '555-901-6789', '835 Willow St, Everywhere, USA'),
('Michelle Adams', 'michelle.a@example.com', '555-012-7890', '946 Aspen Ave, Anytown, USA');

CREATE TABLE Book (
    book_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    title VARCHAR(100) NOT NULL,
    author_name VARCHAR(100) NOT NULL,
    genre VARCHAR(50),
    price DECIMAL(10,2) NOT NULL,
    stock INT NOT NULL,
    published_date DATE,
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
);

select * from Book;

INSERT INTO Book (customer_id, title, author_name, genre, price, stock, published_date) VALUES
(1, 'The Silent Patient', 'Alex Michaelides', 'Thriller', 12.99, 50, '2019-02-05'),
(2, 'Where the Crawdads Sing', 'Delia Owens', 'Fiction', 14.99, 45, '2018-08-14'),
(3, 'Educated', 'Tara Westover', 'Memoir', 13.50, 30, '2018-02-20'),
(4, 'Becoming', 'Michelle Obama', 'Autobiography', 18.99, 60, '2018-11-13'),
(5, 'The Testaments', 'Margaret Atwood', 'Fiction', 15.99, 40, '2019-09-10'),
(6, 'Normal People', 'Sally Rooney', 'Fiction', 11.99, 35, '2018-08-28'),
(7, 'The Dutch House', 'Ann Patchett', 'Fiction', 13.99, 25, '2019-09-24'),
(8, 'City of Girls', 'Elizabeth Gilbert', 'Historical Fiction', 14.50, 30, '2019-06-04'),
(9, 'The Giver of Stars', 'Jojo Moyes', 'Historical Fiction', 12.99, 40, '2019-10-08'),
(10, 'The Institute', 'Stephen King', 'Horror', 16.99, 55, '2019-09-10'),
(11, 'The Water Dancer', 'Ta-Nehisi Coates', 'Fantasy', 17.50, 30, '2019-09-24'),
(12, 'Olive, Again', 'Elizabeth Strout', 'Fiction', 14.99, 25, '2019-10-15'),
(13, 'The Starless Sea', 'Erin Morgenstern', 'Fantasy', 15.99, 35, '2019-11-05'),
(14, 'The Silent Patient', 'Alex Michaelides', 'Thriller', 12.99, 20, '2019-02-05'),
(15, 'The Turn of the Key', 'Ruth Ware', 'Mystery', 13.99, 30, '2019-08-06'),
(16, 'Recursion', 'Blake Crouch', 'Science Fiction', 14.99, 40, '2019-06-11'),
(17, 'The Nickel Boys', 'Colson Whitehead', 'Historical Fiction', 15.50, 35, '2019-07-16'),
(18, 'The Testaments', 'Margaret Atwood', 'Fiction', 15.99, 25, '2019-09-10'),
(19, 'The Silent Patient', 'Alex Michaelides', 'Thriller', 12.99, 15, '2019-02-05'),
(20, 'The Institute', 'Stephen King', 'Horror', 16.99, 20, '2019-09-10'),
(21, 'The Water Dancer', 'Ta-Nehisi Coates', 'Fantasy', 17.50, 25, '2019-09-24'),
(22, 'Olive, Again', 'Elizabeth Strout', 'Fiction', 14.99, 30, '2019-10-15'),
(23, 'The Starless Sea', 'Erin Morgenstern', 'Fantasy', 15.99, 35, '2019-11-05'),
(24, 'The Silent Patient', 'Alex Michaelides', 'Thriller', 12.99, 40, '2019-02-05'),
(25, 'The Turn of the Key', 'Ruth Ware', 'Mystery', 13.99, 45, '2019-08-06'),
(26, 'Recursion', 'Blake Crouch', 'Science Fiction', 14.99, 50, '2019-06-11'),
(27, 'The Nickel Boys', 'Colson Whitehead', 'Historical Fiction', 15.50, 55, '2019-07-16'),
(28, 'The Testaments', 'Margaret Atwood', 'Fiction', 15.99, 60, '2019-09-10'),
(29, 'The Silent Patient', 'Alex Michaelides', 'Thriller', 12.99, 65, '2019-02-05'),
(30, 'The Institute', 'Stephen King', 'Horror', 16.99, 70, '2019-09-10');

CREATE TABLE Order_Table (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    order_date DATE NOT NULL,
    total_amount DECIMAL(10,2) NOT NULL,
    status VARCHAR(20) NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
);
select * from Order_Table;
INSERT INTO Order_Table (customer_id, order_date, total_amount, status) VALUES
(1, '2023-01-15', 38.97, 'Delivered'),
(2, '2023-01-18', 44.97, 'Shipped'),
(3, '2023-01-20', 27.00, 'Processing'),
(4, '2023-01-22', 56.97, 'Delivered'),
(5, '2023-01-25', 31.98, 'Shipped'),
(6, '2023-01-28', 41.97, 'Processing'),
(7, '2023-02-01', 27.98, 'Delivered'),
(8, '2023-02-05', 43.50, 'Shipped'),
(9, '2023-02-08', 25.98, 'Processing'),
(10, '2023-02-10', 50.97, 'Delivered'),
(11, '2023-02-15', 35.00, 'Shipped'),
(12, '2023-02-18', 44.99, 'Processing'),
(13, '2023-02-20', 31.98, 'Delivered'),
(14, '2023-02-22', 56.97, 'Shipped'),
(15, '2023-02-25', 27.99, 'Processing'),
(16, '2023-02-28', 41.97, 'Delivered'),
(17, '2023-03-01', 55.50, 'Shipped'),
(18, '2023-03-05', 31.98, 'Processing'),
(19, '2023-03-08', 25.98, 'Delivered'),
(20, '2023-03-10', 50.97, 'Shipped'),
(21, '2023-03-15', 35.00, 'Processing'),
(22, '2023-03-18', 44.99, 'Delivered'),
(23, '2023-03-20', 31.98, 'Shipped'),
(24, '2023-03-22', 56.97, 'Processing'),
(25, '2023-03-25', 27.99, 'Delivered'),
(26, '2023-03-28', 41.97, 'Shipped'),
(27, '2023-04-01', 55.50, 'Processing'),
(28, '2023-04-05', 31.98, 'Delivered'),
(29, '2023-04-08', 25.98, 'Shipped'),
(30, '2023-04-10', 50.97, 'Processing');

CREATE TABLE Order_Item (
    order_item_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    book_id INT NOT NULL,
    quantity INT NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES Order_Table(order_id),
    FOREIGN KEY (book_id) REFERENCES Book(book_id)
);
select * from Order_Item;
INSERT INTO Order_Item (order_id, book_id, quantity, price) VALUES
(1, 1, 3, 12.99),
(2, 2, 3, 14.99),
(3, 3, 2, 13.50),
(4, 4, 3, 18.99),
(5, 5, 2, 15.99),
(6, 6, 3, 11.99),
(7, 7, 2, 13.99),
(8, 8, 3, 14.50),
(9, 9, 2, 12.99),
(10, 10, 3, 16.99),
(11, 11, 2, 17.50),
(12, 12, 3, 14.99),
(13, 13, 2, 15.99),
(14, 14, 3, 12.99),
(15, 15, 2, 13.99),
(16, 16, 3, 14.99),
(17, 17, 3, 15.50),
(18, 18, 2, 15.99),
(19, 19, 2, 12.99),
(20, 20, 3, 16.99),
(21, 21, 2, 17.50),
(22, 22, 3, 14.99),
(23, 23, 2, 15.99),
(24, 24, 3, 12.99),
(25, 25, 2, 13.99),
(26, 26, 3, 14.99),
(27, 27, 3, 15.50),
(28, 28, 2, 15.99),
(29, 29, 2, 12.99),
(30, 30, 3, 16.99);

CREATE TABLE Review (
    review_id INT PRIMARY KEY AUTO_INCREMENT,
    rating INT NOT NULL,
    review_text TEXT,
    customer_id INT,
    book_id INT,
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id),
    FOREIGN KEY (book_id) REFERENCES Book(book_id)
);
select * from Review;
INSERT INTO Review (rating, review_text, customer_id, book_id) VALUES
(5, 'Absolutely loved this book! Could not put it down.', 1, 1),
(4, 'Great read, highly recommend it to others.', 2, 2),
(3, 'Good book but the ending was a bit predictable.', 3, 3),
(5, 'One of the best books I have read this year!', 4, 4),
(4, 'Well written and engaging story.', 5, 5),
(3, 'Enjoyable but not the authors best work.', 6, 6),
(5, 'Could not stop reading, finished in one sitting!', 7, 7),
(4, 'Interesting plot and well developed characters.', 8, 8),
(3, 'Decent read but not as good as I expected.', 9, 9),
(5, 'Amazing book, would read again!', 10, 10),
(4, 'Really enjoyed this one, would recommend.', 11, 11),
(3, 'Good but not great, expected more.', 12, 12),
(5, 'Fantastic book, exceeded my expectations!', 13, 13),
(4, 'Great story, well written characters.', 14, 14),
(3, 'Average read, nothing special.', 15, 15),
(5, 'Loved every page of this book!', 16, 16),
(4, 'Very good, would read more from this author.', 17, 17),
(3, 'Okay but not my favorite genre.', 18, 18),
(5, 'Brilliant writing and storytelling!', 19, 19),
(4, 'Enjoyable read with good pacing.', 20, 20),
(3, 'Not bad but not outstanding either.', 21, 21),
(5, 'Could not put it down, highly recommend!', 22, 22),
(4, 'Solid book with interesting characters.', 23, 23),
(3, 'Decent but not memorable.', 24, 24),
(5, 'One of my new favorite books!', 25, 25),
(4, 'Well crafted story with good twists.', 26, 26),
(3, 'Good but not amazing.', 27, 27),
(5, 'Absolutely fantastic, a must read!', 28, 28),
(4, 'Really good book, enjoyed it a lot.', 29, 29),
(3, 'It was okay, not what I expected.', 30, 30);

select title, price from book where price > (select avg(price) from book);

select * from book;
select title , author_name, price from book where book_id in(select book_id from order_item where order_id =(select order_id from order_table order by order_date desc limit 1));

select customer_id, email 
from customer 
where customer_id in(select distinct customer_id from order_table);

create view book_store_stock as Select c.customer, b.book_id, b.stock from customer c join book b on b.customer_id = c.customer_id group by customer;
select * from book;
select *from customer;
-- ======================================================
WITH customer_stats AS (
  SELECT c.customer_id, c.name, SUM(o.total_amount) AS total_spent
  FROM Customer c JOIN Order_Table o ON c.customer_id = o.customer_id
  GROUP BY c.customer_id, c.name
)
SELECT cs.*, 
  (SELECT genre FROM Book b JOIN Order_Item oi ON b.book_id = oi.book_id 
   WHERE oi.order_id IN (SELECT order_id FROM Order_Table WHERE customer_id = cs.customer_id) 
   GROUP BY genre ORDER BY COUNT(*) DESC LIMIT 1) AS favorite_genre
FROM customer_stats cs
ORDER BY total_spent DESC LIMIT 5;
-- ======================================================

-- Problem 1: Find the top 5 bestselling books

SELECT b.book_id, b.title, b.author_name, SUM(oi.quantity) AS total_sold
FROM Book b
JOIN Order_Item oi ON b.book_id = oi.book_id
JOIN Order_Table o ON oi.order_id = o.order_id
WHERE o.status = 'Delivered'
GROUP BY b.book_id, b.title, b.author_name
ORDER BY total_sold DESC
LIMIT 5;

-- Problem 2: Calculate monthly sales revenue

SELECT 
    DATE_FORMAT(order_date, '%Y-%m') AS month,
    COUNT(DISTINCT order_id) AS total_orders,
    SUM(total_amount) AS total_revenue
FROM Order_Table
WHERE status = 'Delivered'
GROUP BY DATE_FORMAT(order_date, '%Y-%m')
ORDER BY month;

-- Problem 3: Identify customers with the highest lifetime value

SELECT c.customer_id, c.name, c.email,
    COUNT(DISTINCT o.order_id) AS total_orders,
    SUM(o.total_amount) AS total_spent,
    AVG(o.total_amount) AS avg_order_value
FROM Customer c
JOIN Order_Table o ON c.customer_id = o.customer_id
WHERE o.status = 'Delivered'
GROUP BY c.customer_id, c.name, c.email
ORDER BY total_spent DESC
LIMIT 10;

-- Problem 4: Find books that need restocking (stock < 10)

SELECT book_id, title, author_name, genre, stock,
    (SELECT SUM(quantity) 
     FROM Order_Item oi 
     JOIN Order_Table o ON oi.order_id = o.order_id 
     WHERE oi.book_id = b.book_id AND o.status = 'Delivered'
     AND o.order_date >= DATE_SUB(CURRENT_DATE, INTERVAL 30 DAY)) AS sold_last_30_days
FROM Book b
WHERE stock < 10
ORDER BY stock ASC, sold_last_30_days DESC;

-- Problem 5: Generate a report of customer reviews and ratings

select * from review;
show tables;

SELECT b.book_id, b.title, b.author_name,
    COUNT(r.review_id) AS review_count,
    AVG(r.rating) AS avg_rating,
    MIN(r.rating) AS min_rating,
    MAX(r.rating) AS max_rating
FROM Book b
LEFT JOIN Review r ON b.book_id = r.book_id
GROUP BY b.book_id, b.title, b.author_name
HAVING review_count > 0
ORDER BY avg_rating DESC, review_count DESC;

select * from Order_Item;
select * from book;
select * from order_table;
-- insert into order_table (order_id, customer_id, order_date, total_amount, status) values (31, 31, '2024-04-12', 20.00, 'Shipped');
desc book;
desc Order_Item;
-- insert into order_item (order_item_id, quantity, price) values (" ", 4, 20.00);

DELIMITER //
CREATE PROCEDURE GetCustomerOrders(IN customer_id INT)
BEGIN
    SELECT o.order_id, o.order_date, o.total_amount, o.status, COUNT(oi.order_item_id) AS item_count
    FROM Order_Table o JOIN Order_Item oi ON o.order_id = oi.order_id
    WHERE o.customer_id = customer_id GROUP BY o.order_id;
END //
DELIMITER ;
call GetCustomerOrders(5);

DELIMITER  $$
CREATE TRIGGER trg_reduce_stock_after_update_2
AFTER UPDATE ON Order_Item
FOR EACH ROW
BEGIN
    UPDATE Book 
    SET stock = stock - NEW.quantity
    WHERE book_id = NEW.book_id;
END $$
DELIMITER ;
update order_item SET quantity = 5 where order_item_id = 3;

DELIMITER $$
CREATE TRIGGER trg_check_stock_before_update
BEFORE UPDATE ON Order_Item
FOR EACH ROW
BEGIN
    DECLARE current_stock INT;
    SELECT stock INTO current_stock
    FROM Book
    WHERE book_id = NEW.book_id;
    IF current_stock < NEW.quantity THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Not enough stock for this book.';
    END IF;
END $$

update order_item set quantity = 10 where book_id = 1;
 
 
select * from Book;
select * from order_item;
desc order_item;
update book SET stock = 50 where book_id = 1;

select o.order_id, o.status, oi.quantity, oi.price from order_table o join order_item oi ON o.order_id = oi.order_id where oi.quantity > 5;

select b.book_id, oi.order_id, oi.price from book b join order_item oi ON b.book_id = oi.book_id where oi.price >= 15;