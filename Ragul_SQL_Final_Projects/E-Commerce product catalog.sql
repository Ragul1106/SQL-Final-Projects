CREATE DATABASE E_commerce_db;
USE E_commerce_db;

CREATE TABLE categories (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE brands (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(200) NOT NULL,
    description TEXT,
    price DECIMAL(10, 2) NOT NULL CHECK (price >= 0),
    stock INT NOT NULL DEFAULT 0 CHECK (stock >= 0),
    image_url VARCHAR(255),
    category_id INT NOT NULL,
    brand_id INT NOT NULL,
    FOREIGN KEY (category_id) REFERENCES categories(id) ON DELETE CASCADE,
    FOREIGN KEY (brand_id) REFERENCES brands(id) ON DELETE CASCADE
);

CREATE INDEX idx_products_category ON products(category_id);
CREATE INDEX idx_products_brand ON products(brand_id);
CREATE INDEX idx_products_price ON products(price);


INSERT INTO categories (name) VALUES
('Electronics'),
('Apparel'),
('Home & Kitchen');

INSERT INTO brands (name) VALUES
('Apple'),
('Nike'),
('Samsung'),
('Adidas'),
('Sony');

INSERT INTO products (name, description, price, stock, image_url, category_id, brand_id)
VALUES
('iPhone 14 Pro', 'Apple smartphone with A16 Bionic chip', 1299.99, 50, 'https://example.com/iphone14pro.jpg', 1, 1),
('MacBook Air M2', 'Apple laptop with M2 chip', 1499.99, 30, 'https://example.com/macbookairm2.jpg', 1, 1),
('Galaxy S23', 'Samsung flagship smartphone', 1099.99, 40, 'https://example.com/galaxys23.jpg', 1, 3),
('Nike Air Max', 'Comfortable running shoes', 129.99, 100, 'https://example.com/nikeairmax.jpg', 2, 2),
('Adidas Ultraboost', 'High-performance running shoes', 149.99, 80, 'https://example.com/adidasultraboost.jpg', 2, 4),
('Sony WH-1000XM5', 'Noise-cancelling wireless headphones', 399.99, 60, 'https://example.com/sonyheadphones.jpg', 1, 5),
('Blender Pro', 'High-speed kitchen blender', 89.99, 70, 'https://example.com/blenderpro.jpg', 3, 5);


-- Get all products in a specific category (e.g., Electronics)
SELECT p.* FROM products p
JOIN categories c ON p.category_id = c.id
WHERE c.name = 'Electronics';

-- Get all products by a specific brand (e.g., Nike)
SELECT p.* FROM products p
JOIN brands b ON p.brand_id = b.id
WHERE b.name = 'Nike';

-- Get products within a price range (e.g., $100 to $500)
SELECT * FROM products
WHERE price BETWEEN 100 AND 500;

-- Get all products with category & brand names
SELECT p.id, p.name, p.price, p.stock, c.name AS category, b.name AS brand
FROM products p
JOIN categories c ON p.category_id = c.id
JOIN brands b ON p.brand_id = b.id
ORDER BY p.price DESC;
