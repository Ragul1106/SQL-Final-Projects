CREATE DATABASE online_exam_db;
USE online_exam_db;

CREATE TABLE courses (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(200) NOT NULL
);

CREATE TABLE students (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL
);

CREATE TABLE exams (
    id INT AUTO_INCREMENT PRIMARY KEY,
    course_id INT NOT NULL,
    date DATE NOT NULL,
    FOREIGN KEY (course_id) REFERENCES courses(id) ON DELETE CASCADE
);

CREATE TABLE questions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    exam_id INT NOT NULL,
    text TEXT NOT NULL,
    correct_option CHAR(1) NOT NULL,
    FOREIGN KEY (exam_id) REFERENCES exams(id) ON DELETE CASCADE
);

CREATE TABLE student_answers (
    student_id INT NOT NULL,
    question_id INT NOT NULL,
    selected_option CHAR(1) NOT NULL,
    PRIMARY KEY (student_id, question_id),
    FOREIGN KEY (student_id) REFERENCES students(id) ON DELETE CASCADE,
    FOREIGN KEY (question_id) REFERENCES questions(id) ON DELETE CASCADE
);

INSERT INTO courses (title) VALUES
('Introduction to Python'),
('Web Development');

INSERT INTO students (name, email) VALUES
('Ragul', 'ragul@example.com'),
('Ananya', 'ananya@example.com');

INSERT INTO exams (course_id, date) VALUES
(1, '2025-08-15'),
(2, '2025-08-20');

INSERT INTO questions (exam_id, text, correct_option) VALUES
(1, 'What is the output of print(2 + 2)?', 'B'), -- B: 4
(1, 'Which keyword is used to define a function?', 'A'), -- A: def
(2, 'Which tag is used for a hyperlink?', 'C'); -- C: <a>

INSERT INTO student_answers (student_id, question_id, selected_option) VALUES
(1, 1, 'B'),
(1, 2, 'A'),
(2, 1, 'C'),
(2, 3, 'C');

-- Query: Join exams with student answers and calculate score per student per exam
SELECT
    s.name AS student_name,
    e.id AS exam_id,
    COUNT(CASE WHEN q.correct_option = sa.selected_option THEN 1 END) AS correct_answers,
    COUNT(q.id) AS total_questions,
    ROUND(
      COUNT(CASE WHEN q.correct_option = sa.selected_option THEN 1 END) * 100.0 / COUNT(q.id), 2
    ) AS score_percentage
FROM student_answers sa
JOIN questions q ON sa.question_id = q.id
JOIN exams e ON q.exam_id = e.id
JOIN students s ON sa.student_id = s.id
GROUP BY s.id, e.id
ORDER BY s.name, e.date;
