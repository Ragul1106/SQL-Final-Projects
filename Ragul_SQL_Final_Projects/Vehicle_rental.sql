CREATE DATABASE vehicle_rental_db;
USE vehicle_rental_db;

CREATE TABLE vehicles (
    id INT PRIMARY KEY AUTO_INCREMENT,
    type VARCHAR(50) NOT NULL,
    plate_number VARCHAR(20) UNIQUE NOT NULL
);

CREATE TABLE customers (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE rentals (
    vehicle_id INT NOT NULL,
    customer_id INT NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    FOREIGN KEY (vehicle_id) REFERENCES vehicles(id) ON DELETE CASCADE,
    FOREIGN KEY (customer_id) REFERENCES customers(id) ON DELETE CASCADE
);

INSERT INTO vehicles (type, plate_number) VALUES
('Sedan', 'ABC123'),
('SUV', 'XYZ789'),
('Truck', 'LMN456');

INSERT INTO customers (name) VALUES
('Ragul'),
('Ranjith'),
('Arul');

INSERT INTO rentals (vehicle_id, customer_id, start_date, end_date) VALUES
(1, 1, '2025-08-01', '2025-08-05'),
(2, 2, '2025-08-03', '2025-08-06'),
(3, 3, '2025-08-10', '2025-08-12');

SELECT v.type, v.plate_number, r.start_date, r.end_date, c.name AS customer
FROM rentals r
JOIN vehicles v ON r.vehicle_id = v.id
JOIN customers c ON r.customer_id = c.id
ORDER BY r.start_date;

SELECT v.type, v.plate_number
FROM vehicles v
WHERE v.id NOT IN (
    SELECT vehicle_id
    FROM rentals
    WHERE '2025-08-04' BETWEEN start_date AND end_date
);
