CREATE DATABASE order_management_db;
USE order_management_db;

CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE
);

CREATE TABLE products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(200) NOT NULL,
    description TEXT,
    price DECIMAL(10, 2) NOT NULL CHECK (price >= 0),
    stock INT NOT NULL DEFAULT 0 CHECK (stock >= 0),
    image_url VARCHAR(255)
);

CREATE TABLE orders (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    status ENUM('Pending', 'Processing', 'Shipped', 'Delivered', 'Cancelled') NOT NULL DEFAULT 'Pending',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE order_items (
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL CHECK (quantity > 0),
    price DECIMAL(10, 2) NOT NULL CHECK (price >= 0),
    FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE
);

INSERT INTO users (name, email) VALUES
('Ragul', 'ragul@example.com'),
('Ananya', 'ananya@example.com');

INSERT INTO products (name, description, price, stock, image_url) VALUES
('iPhone 14 Pro', 'Apple smartphone with A16 Bionic chip', 1299.99, 50, 'https://example.com/iphone14pro.jpg'),
('Nike Air Max', 'Comfortable running shoes', 129.99, 100, 'https://example.com/nikeairmax.jpg'),
('Galaxy S23', 'Samsung flagship smartphone', 1099.99, 40, 'https://example.com/galaxys23.jpg');

START TRANSACTION;
INSERT INTO orders (user_id, status) VALUES (1, 'Pending');
INSERT INTO order_items (order_id, product_id, quantity, price) VALUES
(LAST_INSERT_ID(), 1, 1, 1299.99),
(LAST_INSERT_ID(), 2, 2, 129.99);
COMMIT;

START TRANSACTION;
INSERT INTO orders (user_id, status) VALUES (2, 'Processing');
INSERT INTO order_items (order_id, product_id, quantity, price) VALUES
(LAST_INSERT_ID(), 3, 1, 1099.99);
COMMIT;

SELECT o.id AS order_id, o.status, o.created_at, p.name AS product_name, oi.quantity, oi.price
FROM orders o
JOIN order_items oi ON o.id = oi.order_id
JOIN products p ON oi.product_id = p.id
JOIN users u ON o.user_id = u.id
WHERE u.name = 'Ragul'
ORDER BY o.created_at DESC;

SELECT u.name AS user_name, COUNT(o.id) AS total_orders, SUM(oi.quantity * oi.price) AS total_spent
FROM orders o
JOIN order_items oi ON o.id = oi.order_id
JOIN users u ON o.user_id = u.id
GROUP BY u.name;
