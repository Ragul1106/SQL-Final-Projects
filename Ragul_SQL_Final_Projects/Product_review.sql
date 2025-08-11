CREATE DATABASE product_review_db;
USE product_review_db;

CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(200) NOT NULL
);

CREATE TABLE reviews (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    product_id INT NOT NULL,
    rating DECIMAL(2,1) NOT NULL CHECK (rating >= 1 AND rating <= 5),
    review TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE,
    UNIQUE (user_id, product_id)
);

INSERT INTO users (name) VALUES
('Ragul'),
('Ananya'),
('Kavin');

INSERT INTO products (name) VALUES
('iPhone 14 Pro'),
('Nike Air Max'),
('Galaxy S23');

INSERT INTO reviews (user_id, product_id, rating, review) VALUES
(1, 1, 5.0, 'Absolutely amazing phone!'),
(2, 1, 4.5, 'Great features but a bit expensive'),
(3, 2, 4.0, 'Very comfortable shoes'),
(1, 3, 4.8, 'Excellent performance and display');

SELECT p.id, p.name, AVG(r.rating) AS avg_rating
FROM products p
JOIN reviews r ON p.id = r.product_id
GROUP BY p.id, p.name;

SELECT p.id, p.name, AVG(r.rating) AS avg_rating
FROM products p
JOIN reviews r ON p.id = r.product_id
GROUP BY p.id, p.name
ORDER BY avg_rating DESC
LIMIT 5;
