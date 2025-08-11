CREATE DATABASE attendance_tracker_db;

USE attendance_tracker_db;


CREATE TABLE students (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL
);


CREATE TABLE courses (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE attendance (
    student_id INT NOT NULL,
    course_id INT NOT NULL,
    date DATE NOT NULL,
    status ENUM('Present', 'Absent', 'Late') NOT NULL,
    PRIMARY KEY (student_id, course_id, date),
    FOREIGN KEY (student_id) REFERENCES students(id) ON DELETE CASCADE,
    FOREIGN KEY (course_id) REFERENCES courses(id) ON DELETE CASCADE
);


INSERT INTO students (name) VALUES
('Ragul'),
('Heera'),
('Libi');


INSERT INTO courses (name) VALUES
('Mathematics'),
('Science');


INSERT INTO attendance (student_id, course_id, date, status) VALUES
(1, 1, '2025-08-05', 'Present'),
(1, 1, '2025-08-06', 'Absent'),
(1, 2, '2025-08-05', 'Late'),
(2, 1, '2025-08-05', 'Present'),
(2, 1, '2025-08-06', 'Present'),
(2, 2, '2025-08-05', 'Present'),
(3, 1, '2025-08-05', 'Absent'),
(3, 2, '2025-08-05', 'Present');

-- Query 1: Attendance summary per student per course
SELECT s.name AS student,
       c.name AS course,
       SUM(CASE WHEN a.status = 'Present' THEN 1 ELSE 0 END) AS days_present,
       SUM(CASE WHEN a.status = 'Absent' THEN 1 ELSE 0 END) AS days_absent,
       SUM(CASE WHEN a.status = 'Late' THEN 1 ELSE 0 END) AS days_late
FROM attendance a
JOIN students s ON a.student_id = s.id
JOIN courses c ON a.course_id = c.id
GROUP BY s.id, c.id
ORDER BY s.name, c.name;

-- Query 2: Attendance for a specific date
SELECT s.name AS student, c.name AS course, a.status
FROM attendance a
JOIN students s ON a.student_id = s.id
JOIN courses c ON a.course_id = c.id
WHERE a.date = '2025-08-05'
ORDER BY c.name, s.name;
