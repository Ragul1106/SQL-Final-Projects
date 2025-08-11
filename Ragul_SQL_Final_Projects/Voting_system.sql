CREATE DATABASE votingsystem_db;
USE votingsystem_db;

CREATE TABLE polls (
    id INT PRIMARY KEY AUTO_INCREMENT,
    question VARCHAR(255) NOT NULL
);


CREATE TABLE options (
    id INT PRIMARY KEY AUTO_INCREMENT,
    poll_id INT NOT NULL,
    option_text VARCHAR(255) NOT NULL,
    FOREIGN KEY (poll_id) REFERENCES polls(id) ON DELETE CASCADE
);

-- Create Votes Table
CREATE TABLE votes (
    user_id INT NOT NULL,
    option_id INT NOT NULL,
    voted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (user_id, option_id),
    FOREIGN KEY (option_id) REFERENCES options(id) ON DELETE CASCADE
);

-- Sample Data for Polls
INSERT INTO polls (question) VALUES
('What is your favorite programming language?'),
('Which is your preferred database?');

-- Sample Data for Options
INSERT INTO options (poll_id, option_text) VALUES
(1, 'Python'),
(1, 'JavaScript'),
(1, 'Java'),
(2, 'MySQL'),
(2, 'PostgreSQL'),
(2, 'MongoDB');

-- Sample Data for Votes
INSERT INTO votes (user_id, option_id) VALUES
(1, 1),
(2, 1),
(3, 2),
(4, 3),
(1, 4),
(2, 5),
(3, 6);

-- Query: Count votes by option
SELECT 
    o.option_text,
    COUNT(v.user_id) AS total_votes
FROM options o
LEFT JOIN votes v ON o.id = v.option_id
GROUP BY o.option_text
ORDER BY total_votes DESC;

