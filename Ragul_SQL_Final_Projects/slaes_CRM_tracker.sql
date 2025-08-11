CREATE DATABASE sales_CRM_tracker_db;
USE sales_CRM_tracker_db;
CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE leads (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    source VARCHAR(50) NOT NULL -- e.g., 'Website', 'Referral'
);

CREATE TABLE deals (
    id INT PRIMARY KEY AUTO_INCREMENT,
    lead_id INT NOT NULL,
    user_id INT NOT NULL,
    stage VARCHAR(50) NOT NULL, -- e.g., 'Prospecting', 'Negotiation', 'Closed Won', 'Closed Lost'
    amount DECIMAL(10,2) NOT NULL,
    created_at DATE NOT NULL,
    FOREIGN KEY (lead_id) REFERENCES leads(id),
    FOREIGN KEY (user_id) REFERENCES users(id)
);


INSERT INTO users (name) VALUES
('Ragul'), ('Ranjith'), ('Arul');

INSERT INTO leads (name, source) VALUES
('Acme Corp', 'Website'),
('Beta Ltd', 'Referral'),
('Delta Inc', 'Social Media');

INSERT INTO deals (lead_id, user_id, stage, amount, created_at) VALUES
(1, 1, 'Prospecting', 5000, '2025-07-01'),
(1, 1, 'Negotiation', 5000, '2025-07-05'),
(1, 1, 'Closed Won', 5000, '2025-07-10'),
(2, 2, 'Prospecting', 3000, '2025-07-02'),
(2, 2, 'Closed Lost', 3000, '2025-07-08'),
(3, 3, 'Prospecting', 7000, '2025-07-03');

WITH deal_progress AS (
    SELECT 
        d.lead_id,
        l.name AS lead_name,
        d.stage,
        d.amount,
        d.created_at,
        ROW_NUMBER() OVER (PARTITION BY d.lead_id ORDER BY d.created_at) AS stage_order
    FROM deals d
    JOIN leads l ON d.lead_id = l.id
)
SELECT * FROM deal_progress ORDER BY lead_id, stage_order;


SELECT u.name AS user_name, l.name AS lead_name, d.stage, d.amount, d.created_at
FROM deals d
JOIN users u ON d.user_id = u.id
JOIN leads l ON d.lead_id = l.id
WHERE d.stage = 'Closed Won'
  AND d.created_at BETWEEN '2025-07-01' AND '2025-07-31';
