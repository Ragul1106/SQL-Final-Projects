CREATE DATABASE project_management_db;

USE project_management_db;

CREATE TABLE projects (
    id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE tasks (
    id INT PRIMARY KEY,
    project_id INT,
    name VARCHAR(100) NOT NULL,
    status VARCHAR(50) CHECK (status IN ('Pending', 'In Progress', 'Completed')),
    FOREIGN KEY (project_id) REFERENCES projects(id)
);

CREATE TABLE task_assignments (
    task_id INT,
    user_id INT,
    PRIMARY KEY (task_id, user_id)
);

INSERT INTO projects VALUES
(1, 'Website Redesign'),
(2, 'Mobile App Development'),
(3, 'Marketing Campaign');

INSERT INTO tasks VALUES
(1, 1, 'Create wireframes', 'Completed'),
(2, 1, 'Develop frontend', 'In Progress'),
(3, 2, 'Set up backend API', 'Pending'),
(4, 2, 'UI design', 'In Progress'),
(5, 3, 'Ad content creation', 'Pending');

INSERT INTO task_assignments VALUES
(1, 101),
(2, 102),
(3, 103),
(4, 101),
(5, 104);

SELECT p.name AS project_name, t.name AS task_name, t.status, ta.user_id
FROM projects p
JOIN tasks t ON p.id = t.project_id
JOIN task_assignments ta ON t.id = ta.task_id;

SELECT t.status, COUNT(*) AS total_tasks
FROM tasks t
GROUP BY t.status;

SELECT ta.user_id, COUNT(*) AS assigned_tasks
FROM task_assignments ta
GROUP BY ta.user_id;
