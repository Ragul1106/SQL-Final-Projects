CREATE DATABASE inventory_tracking_db;
USE inventory_tracking_db;

CREATE TABLE products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(200) NOT NULL,
    stock INT NOT NULL DEFAULT 0 CHECK (stock >= 0)
);

CREATE TABLE suppliers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(150) NOT NULL
);

CREATE TABLE inventory_logs (
    id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT NOT NULL,
    supplier_id INT,
    action ENUM('IN', 'OUT') NOT NULL,
    qty INT NOT NULL CHECK (qty > 0),
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE,
    FOREIGN KEY (supplier_id) REFERENCES suppliers(id) ON DELETE SET NULL
);

DELIMITER //
CREATE TRIGGER trg_inventory_update
AFTER INSERT ON inventory_logs
FOR EACH ROW
BEGIN
    IF NEW.action = 'IN' THEN
        UPDATE products SET stock = stock + NEW.qty WHERE id = NEW.product_id;
    ELSEIF NEW.action = 'OUT' THEN
        UPDATE products SET stock = stock - NEW.qty WHERE id = NEW.product_id;
    END IF;
END//
DELIMITER ;

INSERT INTO products (name, stock) VALUES
('iPhone 14 Pro', 50),
('Nike Air Max', 100),
('Galaxy S23', 40);
INSERT INTO products (name, stock) VALUES
('Vivo v39 Pro', 9);

INSERT INTO suppliers (name) VALUES
('Apple Inc.'),
('Nike Ltd.'),
('Samsung Electronics');

INSERT INTO inventory_logs (product_id, supplier_id, action, qty) VALUES
(1, 1, 'OUT', 5),
(2, 2, 'IN', 20),
(3, 3, 'OUT', 10);

SELECT id, name, stock,
CASE 
    WHEN stock = 0 THEN 'Out of Stock'
    WHEN stock < 10 THEN 'Low Stock'
    ELSE 'In Stock'
END AS stock_status
FROM products;
