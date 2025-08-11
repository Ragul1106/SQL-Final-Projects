CREATE DATABASE product_return_db;
USE product_return_db;

CREATE TABLE orders (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    product_id INT NOT NULL
);

CREATE TABLE returns (
    id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    reason VARCHAR(255),
    status VARCHAR(50) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE
);

INSERT INTO orders (user_id, product_id) VALUES
(1, 101),
(2, 102),
(3, 103);

INSERT INTO returns (order_id, reason, status) VALUES
(1, 'Defective item', 'Pending'),
(2, 'Wrong size', 'Approved');

SELECT o.id AS order_id, o.user_id, o.product_id, r.reason, r.status
FROM returns r
JOIN orders o ON r.order_id = o.id;

SELECT status, COUNT(*) AS total_returns
FROM returns
GROUP BY status;
