CREATE DATABASE freelance_project_management_db;
USE freelance_project_management_db;

CREATE TABLE freelancers (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    skill VARCHAR(100) NOT NULL
);

CREATE TABLE projects (
    id INT PRIMARY KEY AUTO_INCREMENT,
    client_name VARCHAR(100) NOT NULL,
    title VARCHAR(150) NOT NULL
);

CREATE TABLE proposals (
    freelancer_id INT NOT NULL,
    project_id INT NOT NULL,
    bid_amount DECIMAL(10,2) NOT NULL,
    status ENUM('Pending', 'Accepted', 'Rejected') NOT NULL,
    FOREIGN KEY (freelancer_id) REFERENCES freelancers(id) ON DELETE CASCADE,
    FOREIGN KEY (project_id) REFERENCES projects(id) ON DELETE CASCADE
);

INSERT INTO freelancers (name, skill) VALUES
('Ragul', 'Web Development'),
('Libi', 'Graphic Design'),
('Heera', 'Content Writing');

INSERT INTO projects (client_name, title) VALUES
('Acme Corp', 'Company Website Redesign'),
('Beta LLC', 'Logo Design'),
('Gamma Inc', 'Blog Content Creation');

INSERT INTO proposals (freelancer_id, project_id, bid_amount, status) VALUES
(1, 1, 1500.00, 'Accepted'),
(2, 2, 500.00, 'Pending'),
(3, 3, 300.00, 'Rejected'),
(1, 3, 250.00, 'Pending');

SELECT f.name, COUNT(p.project_id) AS total_projects
FROM proposals p
JOIN freelancers f ON p.freelancer_id = f.id
WHERE p.status = 'Accepted'
GROUP BY f.name
ORDER BY total_projects DESC;

SELECT pr.title, f.name, p.bid_amount, p.status
FROM proposals p
JOIN projects pr ON p.project_id = pr.id
JOIN freelancers f ON p.freelancer_id = f.id
ORDER BY pr.title;
