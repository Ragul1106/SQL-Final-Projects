CREATE DATABASE message_system_db;
USE message_system_db;

CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE conversations (
    id INT PRIMARY KEY AUTO_INCREMENT
);

CREATE TABLE messages (
    id INT PRIMARY KEY AUTO_INCREMENT,
    conversation_id INT NOT NULL,
    sender_id INT NOT NULL,
    message_text TEXT NOT NULL,
    sent_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (conversation_id) REFERENCES conversations(id) ON DELETE CASCADE,
    FOREIGN KEY (sender_id) REFERENCES users(id) ON DELETE CASCADE
);

INSERT INTO users (name) VALUES
('Heera'),
('Ragul'),
('Arul');

INSERT INTO conversations () VALUES
(), (); 


INSERT INTO messages (conversation_id, sender_id, message_text) VALUES
(1, 1, 'Hi Heera!'),
(1, 2, 'Hey Ragul, how are you?'),
(1, 1, 'I am good, thanks!'),
(2, 2, 'Hi Arul, project update?'),
(2, 3, 'Yes, almost done!');

-- Query: Get the most recent message in each conversation
SELECT m.*
FROM messages m
JOIN (
    SELECT conversation_id, MAX(sent_at) AS latest
    FROM messages
    GROUP BY conversation_id
) latest_messages
ON m.conversation_id = latest_messages.conversation_id
AND m.sent_at = latest_messages.latest;

-- Query: Get all messages for a conversation, ordered by time
SELECT u.name AS sender, m.message_text, m.sent_at
FROM messages m
JOIN users u ON m.sender_id = u.id
WHERE m.conversation_id = 1
ORDER BY m.sent_at ASC;
