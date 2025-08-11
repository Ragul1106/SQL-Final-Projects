CREATE DATABASE course_feedback_db;
USE course_feedback_db;

CREATE TABLE courses (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL
);

CREATE TABLE feedback (
    id INT PRIMARY KEY AUTO_INCREMENT,
    course_id INT NOT NULL,
    user_id INT NOT NULL,
    rating DECIMAL(3,2) NOT NULL,
    comments TEXT,
    FOREIGN KEY (course_id) REFERENCES courses(id) ON DELETE CASCADE
);

INSERT INTO courses (title) VALUES
('Data Structures'),
('Database Management'),
('Machine Learning');

INSERT INTO feedback (course_id, user_id, rating, comments) VALUES
(1, 101, 4.5, 'Very informative and well-structured.'),
(1, 102, 4.0, 'Good examples but could be faster-paced.'),
(2, 103, 3.5, 'Needed more practical exercises.');

SELECT c.title, AVG(f.rating) AS avg_rating
FROM feedback f
JOIN courses c ON f.course_id = c.id
GROUP BY c.id, c.title;

SELECT c.title, f.comments
FROM feedback f
JOIN courses c ON f.course_id = c.id;
