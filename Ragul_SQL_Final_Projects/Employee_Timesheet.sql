CREATE DATABASE employee_timesheet_db;
USE employee_timesheet_db;

CREATE TABLE employees (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    dept VARCHAR(100) NOT NULL
);

CREATE TABLE projects (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(200) NOT NULL
);

CREATE TABLE timesheets (
    id INT AUTO_INCREMENT PRIMARY KEY,
    emp_id INT NOT NULL,
    project_id INT NOT NULL,
    hours DECIMAL(5,2) NOT NULL CHECK (hours > 0),
    date DATE NOT NULL,
    FOREIGN KEY (emp_id) REFERENCES employees(id) ON DELETE CASCADE,
    FOREIGN KEY (project_id) REFERENCES projects(id) ON DELETE CASCADE
);

INSERT INTO employees (name, dept) VALUES
('Ragul', 'Development'),
('Ananya', 'Design'),
('Kavin', 'Testing');

INSERT INTO projects (name) VALUES
('E-Commerce Website'),
('Mobile App Development'),
('Inventory Management System');

INSERT INTO timesheets (emp_id, project_id, hours, date) VALUES
(1, 1, 8, '2025-08-05'),
(1, 2, 5, '2025-08-06'),
(2, 1, 6, '2025-08-05'),
(3, 3, 7, '2025-08-06'),
(1, 1, 4, '2025-08-07');

SELECT e.name AS employee, p.name AS project, t.hours, t.date
FROM timesheets t
JOIN employees e ON t.emp_id = e.id
JOIN projects p ON t.project_id = p.id;

SELECT e.name AS employee, p.name AS project, SUM(t.hours) AS total_hours
FROM timesheets t
JOIN employees e ON t.emp_id = e.id
JOIN projects p ON t.project_id = p.id
GROUP BY e.name, p.name;

SELECT e.name AS employee, SUM(t.hours) AS weekly_hours
FROM timesheets t
JOIN employees e ON t.emp_id = e.id
WHERE YEARWEEK(t.date, 1) = YEARWEEK(CURDATE(), 1)
GROUP BY e.name;

SELECT e.name AS employee, SUM(t.hours) AS monthly_hours
FROM timesheets t
JOIN employees e ON t.emp_id = e.id
WHERE YEAR(t.date) = YEAR(CURDATE()) AND MONTH(t.date) = MONTH(CURDATE())
GROUP BY e.name;
