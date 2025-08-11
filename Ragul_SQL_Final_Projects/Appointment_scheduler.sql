CREATE DATABASE appointment_scheduler_db;

USE appointment_scheduler_db;

CREATE TABLE users (
    id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE services (
    id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE appointments (
    id INT PRIMARY KEY,
    user_id INT,
    service_id INT,
    appointment_time DATETIME NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (service_id) REFERENCES services(id)
);

INSERT INTO users VALUES
(1, 'Alice'),
(2, 'Bob'),
(3, 'Charlie');

INSERT INTO services VALUES
(1, 'Haircut'),
(2, 'Dental Checkup'),
(3, 'Massage Therapy');

INSERT INTO appointments VALUES
(1, 1, 1, '2025-08-10 10:00:00'),
(2, 2, 2, '2025-08-10 11:00:00'),
(3, 1, 3, '2025-08-11 09:30:00'),
(4, 3, 1, '2025-08-10 10:00:00');


SELECT a.id, u.name AS user_name, s.name AS service_name, a.appointment_time
FROM appointments a
JOIN users u ON a.user_id = u.id
JOIN services s ON a.service_id = s.id
WHERE DATE(a.appointment_time) = '2025-08-10';

SELECT appointment_time, COUNT(*) AS num_bookings
FROM appointments
GROUP BY appointment_time
HAVING COUNT(*) > 1;

SELECT a.id, u.name AS user_name, s.name AS service_name, a.appointment_time
FROM appointments a
JOIN users u ON a.user_id = u.id
JOIN services s ON a.service_id = s.id
WHERE s.name = 'Haircut';

SELECT s.name AS service_name, a.appointment_time
FROM appointments a
JOIN services s ON a.service_id = s.id
WHERE a.user_id = 1
AND a.appointment_time >= NOW()
ORDER BY a.appointment_time;
