CREATE DATABASE course_progress_tracker_db;
USE course_progress_tracker_db;

CREATE TABLE courses (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE lessons (
    id INT PRIMARY KEY AUTO_INCREMENT,
    course_id INT,
    title VARCHAR(100) NOT NULL,
    FOREIGN KEY (course_id) REFERENCES courses(id) ON DELETE CASCADE
);

CREATE TABLE students (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE progress (
    student_id INT,
    lesson_id INT,
    completed_at DATETIME,
    PRIMARY KEY (student_id, lesson_id),
    FOREIGN KEY (student_id) REFERENCES students(id) ON DELETE CASCADE,
    FOREIGN KEY (lesson_id) REFERENCES lessons(id) ON DELETE CASCADE
);

INSERT INTO courses (name) VALUES
('Python Basics'),
('Web Development');

INSERT INTO lessons (course_id, title) VALUES
(1, 'Introduction to Python'),
(1, 'Variables and Data Types'),
(1, 'Control Structures'),
(2, 'HTML Basics'),
(2, 'CSS Fundamentals');

INSERT INTO students (name) VALUES
('Ragul'),
('Ranjith');

INSERT INTO progress (student_id, lesson_id, completed_at) VALUES
(1, 1, '2025-08-01 10:00:00'),
(1, 2, '2025-08-02 11:00:00'),
(2, 4, '2025-08-01 09:00:00');

SELECT 
    s.id AS student_id,
    s.name AS student_name,
    c.id AS course_id,
    c.name AS course_name,
    COUNT(p.lesson_id) AS completed_lessons,
    COUNT(l.id) AS total_lessons,
    ROUND((COUNT(p.lesson_id) / COUNT(l.id)) * 100, 2) AS completion_percentage
FROM 
    students s
JOIN 
    progress p ON s.id = p.student_id
JOIN 
    lessons l ON p.lesson_id = l.id
JOIN 
    courses c ON l.course_id = c.id
GROUP BY 
    s.id, c.id;
