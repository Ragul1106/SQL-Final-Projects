CREATE DATABASE qr_code_entry_db;
USE qr_code_entry_db;

CREATE TABLE locations (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE entry_logs (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    location_id INT NOT NULL,
    entry_time DATETIME NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (location_id) REFERENCES locations(id) ON DELETE CASCADE
);

INSERT INTO locations (name) VALUES
('Main Office'),
('Warehouse'),
('Conference Hall');

INSERT INTO users (name) VALUES
('Ragul'),
('Vetri'),
('Hari');

INSERT INTO entry_logs (user_id, location_id, entry_time) VALUES
(1, 1, '2025-08-10 08:45:00'),
(2, 2, '2025-08-10 09:10:00'),
(3, 1, '2025-08-10 09:30:00'),
(1, 3, '2025-08-11 10:00:00');

SELECT l.name AS location, COUNT(*) AS total_entries
FROM entry_logs e
JOIN locations l ON e.location_id = l.id
GROUP BY l.name
ORDER BY total_entries DESC;

SELECT u.name, l.name AS location, e.entry_time
FROM entry_logs e
JOIN users u ON e.user_id = u.id
JOIN locations l ON e.location_id = l.id
WHERE DATE(e.entry_time) = '2025-08-10'
ORDER BY e.entry_time;
