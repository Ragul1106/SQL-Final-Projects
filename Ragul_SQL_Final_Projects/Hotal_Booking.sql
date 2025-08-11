CREATE DATABASE hotel_booking_db;
USE hotel_booking_db;

CREATE TABLE rooms (
    id INT PRIMARY KEY AUTO_INCREMENT,
    number VARCHAR(10) NOT NULL,
    type VARCHAR(50) NOT NULL
);

CREATE TABLE guests (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE bookings (
    id INT PRIMARY KEY AUTO_INCREMENT,
    room_id INT,
    guest_id INT,
    from_date DATE,
    to_date DATE,
    FOREIGN KEY (room_id) REFERENCES rooms(id) ON DELETE CASCADE,
    FOREIGN KEY (guest_id) REFERENCES guests(id) ON DELETE CASCADE
);

INSERT INTO rooms (number, type) VALUES
('101', 'Single'),
('102', 'Double'),
('201', 'Suite');

INSERT INTO guests (name) VALUES
('Hari'),
('Magizh'),
('Harsha');

INSERT INTO bookings (room_id, guest_id, from_date, to_date) VALUES
(1, 1, '2025-08-10', '2025-08-12'),
(2, 2, '2025-08-11', '2025-08-15'),
(3, 3, '2025-08-14', '2025-08-18');

SELECT r.id, r.number, r.type
FROM rooms r
WHERE r.id NOT IN (
    SELECT b.room_id
    FROM bookings b
    WHERE ('2025-08-11' BETWEEN b.from_date AND b.to_date)
       OR ('2025-08-13' BETWEEN b.from_date AND b.to_date)
       OR (b.from_date BETWEEN '2025-08-11' AND '2025-08-13')
);

SELECT r.number, g.name, b.from_date, b.to_date
FROM bookings b
JOIN rooms r ON b.room_id = r.id
JOIN guests g ON b.guest_id = g.id
WHERE ('2025-08-11' BETWEEN b.from_date AND b.to_date)
   OR ('2025-08-13' BETWEEN b.from_date AND b.to_date)
   OR (b.from_date BETWEEN '2025-08-11' AND '2025-08-13');
