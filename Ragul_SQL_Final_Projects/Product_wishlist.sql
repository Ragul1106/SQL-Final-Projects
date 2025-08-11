CREATE DATABASE product_wishlist_db;
USE product_wishlist_db;

CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL
);


CREATE TABLE products (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE wishlist (
    user_id INT,
    product_id INT,
    PRIMARY KEY (user_id, product_id),
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE
);


INSERT INTO users (name) VALUES
('Heera'),
('Ranjith'),
('Harsha'),
('Libi');


INSERT INTO products (name) VALUES
('Laptop'),
('Smartphone'),
('Headphones'),
('Smartwatch');


INSERT INTO wishlist (user_id, product_id) VALUES
(1, 1), 
(1, 2), 
(2, 1), 
(2, 3), 
(3, 2), 
(3, 4), 
(4, 1), 
(4, 2); 

-- Query: Find most popular products in wishlists
SELECT 
    p.name AS product_name,
    COUNT(w.user_id) AS wishlist_count
FROM 
    products p
JOIN 
    wishlist w ON p.id = w.product_id
GROUP BY 
    p.id, p.name
ORDER BY 
    wishlist_count DESC;
