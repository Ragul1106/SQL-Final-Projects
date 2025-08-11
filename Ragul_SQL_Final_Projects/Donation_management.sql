CREATE DATABASE donation_management_db;
USE donation_management_db;

CREATE TABLE donors (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE causes (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(150) NOT NULL
);

CREATE TABLE donations (
    id INT PRIMARY KEY AUTO_INCREMENT,
    donor_id INT,
    cause_id INT,
    amount DECIMAL(10,2) NOT NULL,
    donated_at DATE NOT NULL,
    FOREIGN KEY (donor_id) REFERENCES donors(id) ON DELETE CASCADE,
    FOREIGN KEY (cause_id) REFERENCES causes(id) ON DELETE CASCADE
);

INSERT INTO donors (name) VALUES
('Hari'),
('Abi'),
('Harsha'),
('Anu');

INSERT INTO causes (title) VALUES
('Education Fund'),
('Healthcare Support'),
('Animal Welfare'),
('Disaster Relief');

INSERT INTO donations (donor_id, cause_id, amount, donated_at) VALUES
(1, 1, 100.00, '2025-08-01'),
(2, 1, 150.00, '2025-08-02'),
(3, 2, 200.00, '2025-08-03'),
(4, 2, 300.00, '2025-08-04'),
(1, 3, 50.00,  '2025-08-05'),
(2, 4, 400.00, '2025-08-06'),
(3, 4, 250.00, '2025-08-07');

SELECT 
    c.title AS cause_title,
    SUM(d.amount) AS total_donations
FROM 
    causes c
JOIN 
    donations d ON c.id = d.cause_id
GROUP BY 
    c.id, c.title
ORDER BY 
    total_donations DESC;
