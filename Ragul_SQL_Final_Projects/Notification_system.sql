CREATE DATABASE notification_system_db;
USE notification_system_db;

CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE notifications (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    message VARCHAR(255) NOT NULL,
    status ENUM('unread', 'read') DEFAULT 'unread',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

INSERT INTO users (name) VALUES
('Ragul'),
('Ranjith'),
('Harsha');

INSERT INTO notifications (user_id, message, status) VALUES
(1, 'Your order has been shipped', 'unread'),
(1, 'New discount available', 'unread'),
(2, 'Password changed successfully', 'read'),
(3, 'Meeting scheduled for tomorrow', 'unread'),
(2, 'Subscription expiring soon', 'unread');

SELECT 
    user_id,
    COUNT(*) AS unread_count
FROM 
    notifications
WHERE 
    status = 'unread'
GROUP BY 
    user_id;

UPDATE notifications
SET status = 'read'
WHERE user_id = 1 AND status = 'unread';
