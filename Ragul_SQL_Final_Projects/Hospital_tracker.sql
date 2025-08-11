CREATE DATABASE hospital_tracker_db;
USE hospital_tracker_db;

CREATE TABLE patients (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    dob DATE NOT NULL
);

CREATE TABLE doctors (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    specialization VARCHAR(100) NOT NULL
);

CREATE TABLE visits (
    id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    visit_time DATETIME NOT NULL,
    FOREIGN KEY (patient_id) REFERENCES patients(id),
    FOREIGN KEY (doctor_id) REFERENCES doctors(id)
);

INSERT INTO patients (name, dob) VALUES
('Ragul', '1985-03-12'),
('Ananya', '1990-07-22'),
('Kavin', '1978-11-05');

INSERT INTO doctors (name, specialization) VALUES
('Dr. Smith', 'Cardiology'),
('Dr. Johnson', 'Neurology'),
('Dr. Lee', 'General Medicine');

INSERT INTO visits (patient_id, doctor_id, visit_time) VALUES
(1, 1, '2025-08-10 09:00:00'),
(2, 2, '2025-08-10 10:00:00'),
(3, 3, '2025-08-11 11:00:00'),
(1, 3, '2025-08-12 14:00:00');

SELECT p.name AS patient_name, d.name AS doctor_name, d.specialization, v.visit_time
FROM visits v
JOIN patients p ON v.patient_id = p.id
JOIN doctors d ON v.doctor_id = d.id
WHERE d.name = 'Dr. Smith'
AND DATE(v.visit_time) = '2025-08-10';

DELIMITER //
CREATE TRIGGER trg_check_visit_overlap
BEFORE INSERT ON visits
FOR EACH ROW
BEGIN
    IF EXISTS (
        SELECT 1 FROM visits
        WHERE doctor_id = NEW.doctor_id
          AND visit_time = NEW.visit_time
    ) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Doctor has another visit at this time.';
    END IF;
END//
DELIMITER ;
