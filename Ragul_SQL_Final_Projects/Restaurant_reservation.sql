CREATE DATABASE restaurant_reservation_db;
USE restaurant_reservation_db;

CREATE TABLE tables (
    id INT PRIMARY KEY AUTO_INCREMENT,
    table_number INT NOT NULL,
    capacity INT NOT NULL
);

CREATE TABLE guests (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE reservations (
    id INT PRIMARY KEY AUTO_INCREMENT,
    guest_id INT NOT NULL,
    table_id INT NOT NULL,
    date DATE NOT NULL,
    time_slot VARCHAR(50) NOT NULL,
    FOREIGN KEY (guest_id) REFERENCES guests(id) ON DELETE CASCADE,
    FOREIGN KEY (table_id) REFERENCES tables(id) ON DELETE CASCADE
);

INSERT INTO tables (table_number, capacity) VALUES
(1, 2),
(2, 4),
(3, 6);

INSERT INTO guests (name) VALUES
('Ragul'),
('Ranjith'),
('Arul');

INSERT INTO reservations (guest_id, table_id, date, time_slot) VALUES
(1, 1, '2025-08-12', '18:00-20:00'),
(2, 2, '2025-08-12', '19:00-21:00'),
(3, 3, '2025-08-13', '20:00-22:00');

SELECT date, COUNT(*) AS total_reservations
FROM reservations
GROUP BY date
ORDER BY date;

SELECT r.date, r.time_slot, g.name AS guest, t.table_number, t.capacity
FROM reservations r
JOIN guests g ON r.guest_id = g.id
JOIN tables t ON r.table_id = t.id
ORDER BY r.date, r.time_slot;
