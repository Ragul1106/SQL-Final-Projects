CREATE DATABASE asset_management_db;
USE asset_management_db;

CREATE TABLE assets (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    category VARCHAR(100) NOT NULL
);

CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE assignments (
    asset_id INT,
    user_id INT,
    assigned_date DATE NOT NULL,
    returned_date DATE NULL,
    FOREIGN KEY (asset_id) REFERENCES assets(id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

INSERT INTO assets (name, category) VALUES
('Laptop Dell XPS 13', 'Electronics'),
('Projector Epson X200', 'Electronics'),
('Office Chair Model A', 'Furniture');

INSERT INTO users (name) VALUES
('Ragul'),
('Ranjith'),
('Arul');

INSERT INTO assignments (asset_id, user_id, assigned_date, returned_date) VALUES
(1, 1, '2025-07-01', '2025-07-15'),
(2, 2, '2025-07-05', NULL),
(3, 3, '2025-07-10', '2025-07-20');

SELECT a.id, a.name, a.category
FROM assets a
LEFT JOIN assignments asg
    ON a.id = asg.asset_id AND asg.returned_date IS NULL
WHERE asg.asset_id IS NULL;

SELECT u.name AS user_name, a.name AS asset_name, asg.assigned_date, asg.returned_date
FROM assignments asg
JOIN users u ON asg.user_id = u.id
JOIN assets a ON asg.asset_id = a.id
ORDER BY asg.assigned_date DESC;
