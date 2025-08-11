CREATE DATABASE complaint_management_db;
USE complaint_management_db;

CREATE TABLE departments (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL
);

CREATE TABLE complaints (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    department_id INT NOT NULL,
    status VARCHAR(50) NOT NULL,
    FOREIGN KEY (department_id) REFERENCES departments(id) ON DELETE CASCADE
);

CREATE TABLE responses (
    id INT PRIMARY KEY AUTO_INCREMENT,
    complaint_id INT NOT NULL,
    responder_id INT NOT NULL,
    message TEXT NOT NULL,
    FOREIGN KEY (complaint_id) REFERENCES complaints(id) ON DELETE CASCADE
);

INSERT INTO departments (name) VALUES
('Sanitation'),
('Road Maintenance'),
('Water Supply');

INSERT INTO complaints (title, department_id, status) VALUES
('Garbage not collected', 1, 'Open'),
('Pothole on Main Street', 2, 'In Progress'),
('Low water pressure in Sector 5', 3, 'Resolved');

INSERT INTO responses (complaint_id, responder_id, message) VALUES
(1, 101, 'Scheduled for pickup tomorrow'),
(2, 102, 'Repair team assigned'),
(3, 103, 'Issue fixed and verified');

SELECT department_id, COUNT(*) AS total_complaints
FROM complaints
GROUP BY department_id;

SELECT status, COUNT(*) AS count_per_status
FROM complaints
GROUP BY status;
