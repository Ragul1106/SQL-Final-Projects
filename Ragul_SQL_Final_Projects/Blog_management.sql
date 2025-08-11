CREATE DATABASE blog_management_db;
USE blog_management_db;


CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL
);


CREATE TABLE posts (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    title VARCHAR(200) NOT NULL,
    content TEXT NOT NULL,
    published_date DATE NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE comments (
    id INT PRIMARY KEY AUTO_INCREMENT,
    post_id INT NOT NULL,
    user_id INT NOT NULL,
    comment_text TEXT NOT NULL,
    commented_at DATETIME NOT NULL,
    FOREIGN KEY (post_id) REFERENCES posts(id),
    FOREIGN KEY (user_id) REFERENCES users(id)
);


INSERT INTO users (name) VALUES
('Heera'),
('Libi'),
('Vetri');


INSERT INTO posts (user_id, title, content, published_date) VALUES
(1, 'Introduction to SQL', 'This is a beginner guide to SQL.', '2025-08-01'),
(2, 'Advanced SQL Joins', 'Exploring INNER, LEFT, RIGHT joins.', '2025-08-05'),
(3, 'Database Optimization', 'Tips to speed up your queries.', '2025-08-07');


INSERT INTO comments (post_id, user_id, comment_text, commented_at) VALUES
(1, 2, 'Great article!', '2025-08-02 10:15:00'),
(1, 3, 'Thanks for sharing.', '2025-08-02 11:30:00'),
(2, 1, 'Very informative.', '2025-08-06 09:45:00'),
(3, 2, 'Helpful tips.', '2025-08-08 14:20:00');

SELECT 
    p.title AS post_title,
    u.name AS commenter_name,
    c.comment_text,
    c.commented_at
FROM comments c
JOIN posts p ON c.post_id = p.id
JOIN users u ON c.user_id = u.id
ORDER BY c.commented_at;

SELECT 
    p.title, 
    p.content, 
    p.published_date
FROM posts p
JOIN users u ON p.user_id = u.id
WHERE u.name = 'Heera';

SELECT 
    title, 
    published_date
FROM posts
WHERE published_date >= CURDATE() - INTERVAL 7 DAY;
