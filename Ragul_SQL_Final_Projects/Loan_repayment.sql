CREATE DATABASE loan_repayment_db;
USE loan_repayment_db;

CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE loans (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    principal DECIMAL(15,2) NOT NULL CHECK (principal > 0),
    interest_rate DECIMAL(5,2) NOT NULL CHECK (interest_rate >= 0),
    FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE payments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    loan_id INT NOT NULL,
    amount DECIMAL(15,2) NOT NULL CHECK (amount > 0),
    paid_on DATE NOT NULL,
    FOREIGN KEY (loan_id) REFERENCES loans(id)
);

INSERT INTO users (name) VALUES
('Ragul'),
('Ananya'),
('Ranjith')
;

INSERT INTO loans (user_id, principal, interest_rate) VALUES
(1, 10000.00, 7.5),
(2, 20000.00, 7.5),
(3, 5000.00, 6.0);

INSERT INTO payments (loan_id, amount, paid_on) VALUES
(1, 1000.00, '2025-08-01'),
(1, 1500.00, '2025-09-01'),
(3, 1500.00, '2025-09-01'),
(2, 500.00, '2025-08-05');

-- Query: Total paid, remaining principal per loan
SELECT
    u.name AS user_name,
    l.id AS loan_id,
    l.principal,
    l.interest_rate,
    COALESCE(SUM(p.amount), 0) AS total_paid,
    (l.principal - COALESCE(SUM(p.amount), 0)) AS balance_due
FROM loans l
JOIN users u ON l.user_id = u.id
LEFT JOIN payments p ON l.id = p.loan_id
GROUP BY l.id, u.name, l.principal, l.interest_rate;

-- Query: Payments due this month (assume monthly EMI due on 1st)
SELECT
    u.name AS user_name,
    l.id AS loan_id,
    l.principal,
    l.interest_rate,
    DATE_FORMAT(paid_on, '%Y-%m') AS payment_month
FROM loans l
JOIN users u ON l.user_id = u.id
LEFT JOIN payments p ON l.id = p.loan_id
WHERE paid_on >= DATE_FORMAT(CURDATE(), '%Y-%m-01')
  AND paid_on < DATE_ADD(DATE_FORMAT(CURDATE(), '%Y-%m-01'), INTERVAL 1 MONTH);
