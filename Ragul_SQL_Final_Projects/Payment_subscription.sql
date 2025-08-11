CREATE DATABASE payment_subscription_tracker_db;
USE payment_subscription_tracker_db;

CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL
);

CREATE TABLE subscriptions (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    plan_name VARCHAR(255) NOT NULL,
    start_date DATE NOT NULL,
    renewal_cycle INT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

INSERT INTO users (name) VALUES
('Ragul'),
('Ranjith'),
('Arul');

INSERT INTO subscriptions (user_id, plan_name, start_date, renewal_cycle) VALUES
(1, 'Basic', '2025-07-01', 30),
(2, 'Premium', '2025-06-15', 30),
(3, 'Standard', '2025-08-01', 90);

SELECT id, user_id, plan_name, DATE_ADD(start_date, INTERVAL renewal_cycle DAY) AS next_renewal
FROM subscriptions;

SELECT id, user_id, plan_name
FROM subscriptions
WHERE DATE_ADD(start_date, INTERVAL renewal_cycle DAY) < CURDATE();
