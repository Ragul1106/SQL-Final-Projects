CREATE DATABASE job_scheduling_db;
USE job_scheduling_db;

CREATE TABLE jobs (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    frequency VARCHAR(50) NOT NULL
);

CREATE TABLE job_logs (
    id INT PRIMARY KEY AUTO_INCREMENT,
    job_id INT NOT NULL,
    run_time DATETIME NOT NULL,
    status VARCHAR(50) NOT NULL,
    FOREIGN KEY (job_id) REFERENCES jobs(id) ON DELETE CASCADE
);

INSERT INTO jobs (name, frequency) VALUES
('Data Backup', 'Daily'),
('Email Notifications', 'Hourly'),
('Report Generation', 'Weekly');

INSERT INTO job_logs (job_id, run_time, status) VALUES
(1, '2025-08-10 02:00:00', 'Success'),
(1, '2025-08-09 02:00:00', 'Success'),
(2, '2025-08-10 14:00:00', 'Failed'),
(3, '2025-08-07 09:00:00', 'Success');

SELECT j.name, MAX(l.run_time) AS last_run
FROM job_logs l
JOIN jobs j ON l.job_id = j.id
GROUP BY j.id, j.name;

SELECT j.name, l.status, COUNT(*) AS status_count
FROM job_logs l
JOIN jobs j ON l.job_id = j.id
GROUP BY j.name, l.status;
