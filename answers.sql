CREATE DATABASE bookstore_db;
USE bookstore_db;

-- Creating a book table
CREATE TABLE book (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255),
    language_id INT,
    publisher_id INT,
    published_date DATE,
    price DECIMAL(10,2),
    stock_quantity INT,
    FOREIGN KEY (language_id) REFERENCES book_language(language_id),
    FOREIGN KEY (publisher_id) REFERENCES publisher(publisher_id)
);

-- inserting data in the books table
INSERT INTO book (title, language_id, publisher_id, published_date, price, stock_quantity) VALUES
('Pride and Prejudice', 1, 3, '1813-01-28', 19.99, 50),
('Harry Potter 1', 1, 8, '1997-06-26', 29.99, 60),
('Norwegian Wood', 8, 2, '1987-09-04', 22.00, 25),
('Things Fall Apart', 6, 5, '1958-06-17', 18.50, 35),
('War and Peace', 10, 9, '1869-01-01', 27.00, 20),

-- creating book_author table
CREATE TABLE book_author (
    book_id INT,
    author_id INT,
    PRIMARY KEY (book_id, author_id),
    FOREIGN KEY (book_id) REFERENCES book(book_id),
    FOREIGN KEY (author_id) REFERENCES author(author_id)
);

-- inserting data in the book-author
INSERT INTO book_author (book_id, author_id) VALUES
(1, 2), (2, 4), (3, 6), (4, 7), (5, 5);

-- creating author table
CREATE TABLE author (
    author_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
);

-- inserting data in the author table
INSERT INTO author (first_name, last_name) VALUES
('John', 'Doe'),
('Jane', 'Austen'),
('J.K.', 'Rowling'),
('Stephen', 'King'),
('Chinua', 'Achebe');


-- creating book_language table
CREATE TABLE book_language (
    language_id INT AUTO_INCREMENT PRIMARY KEY,
    language_name VARCHAR(100)
);
-- inserting data for data-language
INSERT INTO book_language (language_name) VALUES
('English'), ('French'), ('Spanish'), ('German'), ('Swahili') ;

-- pulisher table
CREATE TABLE publisher (
    publisher_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100)
);

-- inserting data for the publisher
INSERT INTO publisher (name) VALUES
('Pearson', 'https://pearson.com'),
('Penguin Books', 'https://penguin.com'),
('Macmillan', 'https://macmillan.com'),
('Oxford Press', 'https://oup.com'),
('Cambridge Press', 'https://cambridge.org');


-- customer table
CREATE TABLE customer (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    email VARCHAR(150),
    phone VARCHAR(20)
);

-- inserting data in the customer-table
INSERT INTO customer (first_name, last_name, email, phone) VALUES
('Alice', 'Johnson', 'alice@gmail.com', '+254712345678'),
('Bob', 'Smith', 'bob@gmail.com', '+25472132435'),
('Carol', 'Williams', 'carol@gmail.com', '+25471547290'),
('David', 'Brown', 'david@gmail.com', '+25473578951'),
('Eve', 'Jones', 'eve@gmail.com', '+25474729842');

-- country 
CREATE TABLE country (
    country_id INT AUTO_INCREMENT PRIMARY KEY,
    country_name VARCHAR(100)
);

-- inserting data in the country table
INSERT INTO country (country_name) VALUES
('Kenya'), ('USA'), ('UK'), ('France'), ('Germany');



--address
CREATE TABLE address (
    address_id INT AUTO_INCREMENT PRIMARY KEY,
    street VARCHAR(255),
    city VARCHAR(100),
    state VARCHAR(100),
    postal_code VARCHAR(20),
    country_id INT,
    FOREIGN KEY (country_id) REFERENCES country(country_id)
);

-- insering data in the street table
INSERT INTO address (street, city, state, postal_code, country_id) VALUES
('123 Kenyatta Ave', 'Nairobi', 'Nairobi', '00100', 1),
('456 Elm St', 'New York', 'NY', '10001', 2),
('789 Oxford Rd', 'London', 'England', 'OX1 2JD', 3),
('12 Champs Elysees', 'Paris', 'Île-de-France', '75008', 4),
('90 Berlin Str', 'Berlin', 'Berlin', '10115', 5);

-- address_status
CREATE TABLE address_status (
    status_id INT AUTO_INCREMENT PRIMARY KEY,
    status_name VARCHAR(100)
);

-- inserting data in the address-status
INSERT INTO address_status (status_name) VALUES
('Current'), ('Old'), ('Temporary'), ('Billing'), ('Shipping');

-- customer_address
CREATE TABLE customer_address (
    customer_id INT,
    address_id INT,
    status_id INT,
    PRIMARY KEY (customer_id, address_id),
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (address_id) REFERENCES address(address_id),
    FOREIGN KEY (status_id) REFERENCES address_status(status_id)
);

-- inserting data in the customer address table
INSERT INTO customer_address (customer_id, address_id, status_id) VALUES
(1, 1, 1), (2, 2, 2), (3, 3, 1), (4, 4, 3), (5, 5, 1);

-- shipping-method
CREATE TABLE shipping_method (
    shipping_method_id INT AUTO_INCREMENT PRIMARY KEY,
    method_name VARCHAR(100),
    cost DECIMAL(10,2)
);

-- inserting data in the shipping method table
INSERT INTO shipping_method (method_name, cost) VALUES
('Standard', 5.00), ('Next Day', 15.00),
('International', 20.00), ('Local Pickup', 0.00),
('Same Day', 12.00);


-- order-status
CREATE TABLE order_status (
    status_id INT AUTO_INCREMENT PRIMARY KEY,
    status_name VARCHAR(100)
);

-- inserting data in the order status table
INSERT INTO order_status (status_name) VALUES
('Pending'), ('Shipped'), ('Delivered'), ('Cancelled'), ('Returned');

-- table of the orders created by customers
CREATE TABLE customer_order (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    order_date DATETIME,
    shipping_method_id INT,
    status_id INT,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (shipping_method_id) REFERENCES shipping_method(shipping_method_id),
    FOREIGN KEY (status_id) REFERENCES order_status(status_id)
);

-- inserting data in the customer order table
INSERT INTO customer_order (customer_id, order_date, shipping_method_id, status_id) VALUES
(1, NOW(), 1, 1), (2, NOW(), 2, 2), (3, NOW(), 3, 3), (4, NOW(), 4, 4),
(5, NOW(), 5, 1);

-- order-history
CREATE TABLE order_history (
    history_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    status_id INT,
    changed_on DATETIME,
    FOREIGN KEY (order_id) REFERENCES cust_order(order_id),
    FOREIGN KEY (status_id) REFERENCES order_status(status_id)
);


INSERT INTO order_history (order_id, status_id, changed_on) VALUES
(1, 1, NOW()), (2, 2, NOW()), (3, 3, NOW()), (4, 4, NOW()), (5, 1, NOW());


-- books that are part of each order
CREATE TABLE order_line (
    order_id INT,
    book_id INT,
    quantity INT,
    unit_price DECIMAL(10,2),
    PRIMARY KEY (order_id, book_id),
    FOREIGN KEY (order_id) REFERENCES cust_order(order_id),
    FOREIGN KEY (book_id) REFERENCES book(book_id)
);

INSERT INTO order_line (order_id, book_id, quantity, unit_price) VALUES
(1, 1, 2, 19.99), (2, 2, 1, 14.99), (3, 3, 3, 29.99), (4, 4, 1, 24.99),
(5, 5, 2, 22.00);

-- Managing database access 
CREATE USER 'admin_name1'@'%' IDENTIFIED BY 'name1123!';
GRANT ALL PRIVILEGES ON bookstore_db.* TO 'admin_name1'@'%' WITH GRANT OPTION;

CREATE USER 'admin_name2'@'%' IDENTIFIED BY 'name2123!';
GRANT ALL PRIVILEGES ON bookstore_db.* TO 'admin_name2'@'%' WITH GRANT OPTION;

CREATE USER 'admin_name3'@'%' IDENTIFIED BY 'name3123!';
GRANT ALL PRIVILEGES ON bookstore_db.* TO 'admin_name3'@'%' WITH GRANT OPTION;
FLUSH PRIVILEGES;


