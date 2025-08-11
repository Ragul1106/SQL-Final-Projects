CREATE DATABASE inventory_expiry_tracker_db;
USE inventory_expiry_tracker_db;

CREATE TABLE products (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL
);

CREATE TABLE batches (
    id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    expiry_date DATE NOT NULL,
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE
);

INSERT INTO products (name) VALUES
('Milk'),
('Bread'),
('Yogurt');

INSERT INTO batches (product_id, quantity, expiry_date) VALUES
(1, 50, '2025-08-05'),
(1, 30, '2025-08-15'),
(2, 100, '2025-08-02'),
(3, 25, '2025-08-20');

SELECT * 
FROM batches
WHERE expiry_date < CURDATE();

SELECT p.name, SUM(b.quantity) AS total_quantity
FROM products p
JOIN batches b ON p.id = b.product_id
WHERE b.expiry_date >= CURDATE()
GROUP BY p.id, p.name;
