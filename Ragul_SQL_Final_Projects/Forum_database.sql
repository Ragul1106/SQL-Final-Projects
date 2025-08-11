CREATE DATABASE forum_db;
USE forum_db;

CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE threads (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    user_id INT,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE posts (
    id INT PRIMARY KEY AUTO_INCREMENT,
    thread_id INT,
    user_id INT,
    content TEXT NOT NULL,
    parent_post_id INT NULL,
    posted_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (thread_id) REFERENCES threads(id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (parent_post_id) REFERENCES posts(id) ON DELETE CASCADE
);

INSERT INTO users (name) VALUES
('Ragul'),
('Heera'),
('Ranjith');

INSERT INTO threads (title, user_id) VALUES
('Welcome to the Forum', 1),
('SQL Tips and Tricks', 2);

INSERT INTO posts (thread_id, user_id, content, parent_post_id) VALUES
(1, 1, 'Hello everyone! Excited to be here.', NULL),
(1, 2, 'Welcome Ragul!', 1),
(2, 2, 'Share your favorite SQL tips.', NULL),
(2, 3, 'Use indexes wisely for faster queries.', 3);

SELECT t.title, COUNT(p.id) AS total_posts
FROM threads t
LEFT JOIN posts p ON t.id = p.thread_id
GROUP BY t.id, t.title;

SELECT p1.id AS post_id, p1.content AS post_content, p2.id AS reply_id, p2.content AS reply_content
FROM posts p1
LEFT JOIN posts p2 ON p1.id = p2.parent_post_id
ORDER BY p1.id, p2.id;
