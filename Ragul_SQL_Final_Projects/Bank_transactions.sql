CREATE DATABASE bank_transactions_db;
USE bank_transactions_db;

CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE accounts (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    
    balance DECIMAL(15,2) NOT NULL DEFAULT 0,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE transactions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    account_id INT NOT NULL,
    type ENUM('Deposit', 'Withdrawal') NOT NULL,
    amount DECIMAL(15,2) NOT NULL CHECK (amount > 0),
    timestamp DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (account_id) REFERENCES accounts(id)
);

INSERT INTO users (name) VALUES
('Ragul'),
('Libi'),
('Ranjith');

INSERT INTO accounts (user_id, balance) VALUES
(1, 1000.00),
(3, 3000.00),
(2, 2000.00);

INSERT INTO transactions (account_id, type, amount, timestamp) VALUES
(1, 'Deposit', 500.00, '2025-08-01 09:00:00'),
(1, 'Withdrawal', 200.00, '2025-08-02 10:00:00'),
(3, 'Deposit', 500.00, '2025-08-01 09:00:00'),
(3, 'Withdrawal', 200.00, '2025-08-02 10:00:00'),
(2, 'Deposit', 1000.00, '2025-08-01 11:00:00'),
(2, 'Withdrawal', 500.00, '2025-08-03 15:00:00');

WITH running_balance AS (
    SELECT 
        t.id,
        t.account_id,
        t.type,
        t.amount,
        t.timestamp,
        SUM(CASE WHEN t.type = 'Deposit' THEN t.amount ELSE -t.amount END) 
            OVER (PARTITION BY t.account_id ORDER BY t.timestamp, t.id) AS balance_after
    FROM transactions t
)
SELECT
    a.id AS account_id,
    u.name AS user_name,
    rb.id AS transaction_id,
    rb.type,
    rb.amount,
    rb.timestamp,
    rb.balance_after
FROM running_balance rb
JOIN accounts a ON rb.account_id = a.id
JOIN users u ON a.user_id = u.id
ORDER BY rb.account_id, rb.timestamp;
