CREATE DATABASE survey_collection_db;
USE survey_collection_db;

CREATE TABLE surveys (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL
);

CREATE TABLE questions (
    id INT PRIMARY KEY AUTO_INCREMENT,
    survey_id INT NOT NULL,
    question_text TEXT NOT NULL,
    FOREIGN KEY (survey_id) REFERENCES surveys(id) ON DELETE CASCADE
);

CREATE TABLE responses (
    user_id INT NOT NULL,
    question_id INT NOT NULL,
    answer_text TEXT NOT NULL,
    FOREIGN KEY (question_id) REFERENCES questions(id) ON DELETE CASCADE
);

INSERT INTO surveys (title) VALUES
('Customer Satisfaction Survey'),
('Product Feedback Survey');

INSERT INTO questions (survey_id, question_text) VALUES
(1, 'How satisfied are you with our service?'),
(1, 'Would you recommend us to others?'),
(2, 'How would you rate the product quality?'),
(2, 'Any suggestions for improvement?');

INSERT INTO responses (user_id, question_id, answer_text) VALUES
(1, 1, 'Very Satisfied'),
(1, 2, 'Yes'),
(2, 1, 'Satisfied'),
(2, 2, 'Maybe'),
(3, 3, 'Excellent'),
(3, 4, 'More colors needed');

SELECT q.question_text, answer_text, COUNT(*) AS response_count
FROM responses r
JOIN questions q ON r.question_id = q.id
GROUP BY q.id, answer_text
ORDER BY q.id, response_count DESC;

SELECT s.title, COUNT(DISTINCT r.user_id) AS total_respondents
FROM surveys s
JOIN questions q ON s.id = q.survey_id
JOIN responses r ON q.id = r.question_id
GROUP BY s.id, s.title;
