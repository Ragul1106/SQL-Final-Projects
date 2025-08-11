CREATE DATABASE expense_tracker_db;
USE expense_tracker_db;

CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE categories (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE expenses (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    category_id INT NOT NULL,
    amount DECIMAL(10,2) NOT NULL CHECK (amount >= 0),
    date DATE NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (category_id) REFERENCES categories(id)
);

INSERT INTO users (name) VALUES
('Ragul'),
('Arul'),
('Heera');

INSERT INTO categories (name) VALUES
('Food'),
('Transport'),
('Entertainment'),
('Utilities');

INSERT INTO expenses (user_id, category_id, amount, date) VALUES
(1, 1, 15.75, '2025-08-01'),
(3, 2, 7.50, '2025-08-01'),
(2, 3, 20.00, '2025-08-02'),
(3, 1, 12.00, '2025-08-01'),
(2, 4, 50.00, '2025-08-03');

-- Query: Total expenses by category for a user
SELECT c.name AS category, SUM(e.amount) AS total_spent
FROM expenses e
JOIN categories c ON e.category_id = c.id
WHERE e.user_id = 2
GROUP BY c.id, c.name;

-- Query: Monthly expenses by user
SELECT u.name AS user_name, DATE_FORMAT(e.date, '%Y-%m') AS month, SUM(e.amount) AS total_spent
FROM expenses e
JOIN users u ON e.user_id = u.id
GROUP BY u.id, month
ORDER BY month;

-- Query: Expenses filtered by amount range
SELECT u.name AS user_name, c.name AS category, e.amount, e.date
FROM expenses e
JOIN users u ON e.user_id = u.id
JOIN categories c ON e.category_id = c.id
WHERE e.amount BETWEEN 10 AND 30
ORDER BY e.amount DESC;
