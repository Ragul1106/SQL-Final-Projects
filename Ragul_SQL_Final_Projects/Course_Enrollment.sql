CREATE DATABASE course_enrollment_db;
USE course_enrollment_db;

CREATE TABLE courses (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    instructor VARCHAR(100) NOT NULL
);

CREATE TABLE students (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL
);

CREATE TABLE enrollments (
    course_id INT NOT NULL,
    student_id INT NOT NULL,
    enroll_date DATE NOT NULL,
    PRIMARY KEY (course_id, student_id),
    FOREIGN KEY (course_id) REFERENCES courses(id) ON DELETE CASCADE,
    FOREIGN KEY (student_id) REFERENCES students(id) ON DELETE CASCADE
);

INSERT INTO courses (title, instructor) VALUES
('Introduction to Python', 'Mr. Ragul'),
('Web Development', 'Ms. Heera'),
('Data Science Basics', 'Mr. Kavin');

INSERT INTO students (name, email) VALUES
('Ragul', 'ragul@example.com'),
('Heera', 'heera@example.com'),
('Kavin', 'kavin@example.com');

INSERT INTO enrollments (course_id, student_id, enroll_date) VALUES
(1, 1, '2025-08-01'),
(1, 2, '2025-08-02'),
(2, 1, '2025-08-03'),
(3, 3, '2025-08-04'),
(3, 1, '2025-08-05');

SELECT c.title AS course_title, s.name AS student_name, s.email, e.enroll_date
FROM enrollments e
JOIN courses c ON e.course_id = c.id
JOIN students s ON e.student_id = s.id
ORDER BY c.title, s.name;

SELECT c.title AS course_title, COUNT(e.student_id) AS enrolled_students
FROM courses c
LEFT JOIN enrollments e ON c.id = e.course_id
GROUP BY c.id, c.title
ORDER BY enrolled_students DESC;
