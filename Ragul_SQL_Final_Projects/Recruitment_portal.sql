CREATE DATABASE recruitment_portal_db;
USE recruitment_portal_db;

CREATE TABLE jobs (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(100) NOT NULL,
    company VARCHAR(100) NOT NULL
);

CREATE TABLE candidates (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE applications (
    job_id INT,
    candidate_id INT,
    status VARCHAR(50),
    applied_at DATETIME,
    PRIMARY KEY (job_id, candidate_id),
    FOREIGN KEY (job_id) REFERENCES jobs(id) ON DELETE CASCADE,
    FOREIGN KEY (candidate_id) REFERENCES candidates(id) ON DELETE CASCADE
);

INSERT INTO jobs (title, company) VALUES
('Software Engineer', 'TechCorp'),
('Data Analyst', 'DataSolutions'),
('UI/UX Designer', 'CreativeStudio');

INSERT INTO candidates (name) VALUES
('Heera'),
('Libi'),
('Anu');

INSERT INTO applications (job_id, candidate_id, status, applied_at) VALUES
(1, 1, 'Pending', '2025-08-01 09:00:00'),
(1, 2, 'Interview Scheduled', '2025-08-02 10:00:00'),
(2, 3, 'Rejected', '2025-08-03 11:00:00');

SELECT 
    j.id AS job_id,
    j.title AS job_title,
    j.company,
    COUNT(a.candidate_id) AS total_applicants
FROM 
    jobs j
LEFT JOIN 
    applications a ON j.id = a.job_id
GROUP BY 
    j.id;

SELECT 
    c.id AS candidate_id,
    c.name AS candidate_name,
    a.status
FROM 
    candidates c
JOIN 
    applications a ON c.id = a.candidate_id
WHERE 
    a.status = 'Pending';
