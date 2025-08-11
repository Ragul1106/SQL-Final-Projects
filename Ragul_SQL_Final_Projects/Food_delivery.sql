CREATE DATABASE food_delivery_db;
USE food_delivery_db;

CREATE TABLE orders (
    id INT PRIMARY KEY AUTO_INCREMENT,
    restaurant_id INT NOT NULL,
    user_id INT NOT NULL,
    placed_at DATETIME NOT NULL,
    delivered_at DATETIME
);

CREATE TABLE delivery_agents (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE deliveries (
    order_id INT NOT NULL,
    agent_id INT NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE,
    FOREIGN KEY (agent_id) REFERENCES delivery_agents(id) ON DELETE CASCADE
);

INSERT INTO orders (restaurant_id, user_id, placed_at, delivered_at) VALUES
(1, 101, '2025-08-01 12:00:00', '2025-08-01 12:45:00'),
(2, 102, '2025-08-01 13:10:00', '2025-08-01 13:55:00'),
(1, 103, '2025-08-02 18:30:00', '2025-08-02 19:15:00');

INSERT INTO delivery_agents (name) VALUES
('Libi'),
('Aruna');

INSERT INTO deliveries (order_id, agent_id) VALUES
(1, 1),
(2, 2),
(3, 1);

SELECT AVG(TIMESTAMPDIFF(MINUTE, placed_at, delivered_at)) AS avg_delivery_time_minutes
FROM orders
WHERE delivered_at IS NOT NULL;

SELECT da.name, COUNT(*) AS total_deliveries
FROM deliveries d
JOIN delivery_agents da ON d.agent_id = da.id
GROUP BY da.name
ORDER BY total_deliveries DESC;
