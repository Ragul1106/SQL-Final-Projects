CREATE DATABASE shopping_cart_db;
USE shopping_cart_db;


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

CREATE TABLE carts (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE cart_items (
    cart_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL CHECK (quantity > 0),
    PRIMARY KEY (cart_id, product_id),
    FOREIGN KEY (cart_id) REFERENCES carts(id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE
);


INSERT INTO users (name, email) VALUES
('Ragul', 'ragul@example.com'),
('Ananya', 'ananya@example.com');

INSERT INTO products (name, description, price, stock, image_url)
VALUES
('iPhone 14 Pro', 'Apple smartphone with A16 Bionic chip', 1299.99, 50, 'https://example.com/iphone14pro.jpg'),
('MacBook Air M2', 'Apple laptop with M2 chip', 1499.99, 30, 'https://example.com/macbookairm2.jpg'),
('Galaxy S23', 'Samsung flagship smartphone', 1099.99, 40, 'https://example.com/galaxys23.jpg'),
('Nike Air Max', 'Comfortable running shoes', 129.99, 100, 'https://example.com/nikeairmax.jpg'),
('Adidas Ultraboost', 'High-performance running shoes', 149.99, 80, 'https://example.com/adidasultraboost.jpg'),
('Sony WH-1000XM5', 'Noise-cancelling wireless headphones', 399.99, 60, 'https://example.com/sonyheadphones.jpg'),
('Blender Pro', 'High-speed kitchen blender', 89.99, 70, 'https://example.com/blenderpro.jpg');
INSERT INTO carts (user_id) VALUES
(1), 
(2); 

INSERT INTO cart_items (cart_id, product_id, quantity) VALUES
(1, 1, 1), 
(1, 4, 2), 
(2, 3, 1), 
(2, 5, 1); 

SELECT ci.cart_id, p.name AS product_name, p.price, ci.quantity, (p.price * ci.quantity) AS total_price
FROM cart_items ci
JOIN products p ON ci.product_id = p.id
JOIN carts c ON ci.cart_id = c.id
JOIN users u ON c.user_id = u.id
WHERE u.name = 'Ragul';

SELECT u.name AS user_name, SUM(p.price * ci.quantity) AS total_cart_value
FROM cart_items ci
JOIN products p ON ci.product_id = p.id
JOIN carts c ON ci.cart_id = c.id
JOIN users u ON c.user_id = u.id
WHERE u.name = 'Ragul'
GROUP BY u.name;

INSERT INTO cart_items (cart_id, product_id, quantity)
VALUES (1, 6, 1); 

UPDATE cart_items
SET quantity = 3
WHERE cart_id = 1 AND product_id = 4; 

DELETE FROM cart_items
WHERE cart_id = 1 AND product_id = 1; 
