CREATE DATABASE health_records_db;
USE health_records_db;

CREATE TABLE patients (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE prescriptions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    date DATE NOT NULL,
    FOREIGN KEY (patient_id) REFERENCES patients(id)
);

CREATE TABLE medications (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE prescription_details (
    prescription_id INT NOT NULL,
    medication_id INT NOT NULL,
    dosage VARCHAR(100) NOT NULL,
    PRIMARY KEY (prescription_id, medication_id),
    FOREIGN KEY (prescription_id) REFERENCES prescriptions(id) ON DELETE CASCADE,
    FOREIGN KEY (medication_id) REFERENCES medications(id)
);

INSERT INTO patients (name) VALUES
('Ragul'),
('Ananya');

INSERT INTO prescriptions (patient_id, date) VALUES
(1, '2025-08-01'),
(1, '2025-08-10'),
(2, '2025-08-05');

INSERT INTO medications (name) VALUES
('Paracetamol'),
('Ibuprofen'),
('Amoxicillin');

INSERT INTO prescription_details (prescription_id, medication_id, dosage) VALUES
(1, 1, '500mg twice daily'),
(1, 2, '200mg once daily'),
(2, 3, '250mg three times daily'),
(3, 1, '500mg once daily');

SELECT p.name AS patient_name, pr.date, m.name AS medication_name, pd.dosage
FROM prescriptions pr
JOIN patients p ON pr.patient_id = p.id
JOIN prescription_details pd ON pr.id = pd.prescription_id
JOIN medications m ON pd.medication_id = m.id
WHERE p.name = 'Ragul' AND pr.date >= '2025-08-01'
ORDER BY pr.date;
