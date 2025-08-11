CREATE DATABASE salary_management_db;
USE salary_management_db;

-- Employees table
CREATE TABLE employees (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

-- Salaries table
CREATE TABLE salaries (
    id INT AUTO_INCREMENT PRIMARY KEY,
    emp_id INT NOT NULL,
    month DATE NOT NULL,
    base DECIMAL(12,2) NOT NULL CHECK (base >= 0),
    bonus DECIMAL(12,2) NOT NULL DEFAULT 0 CHECK (bonus >= 0),
    FOREIGN KEY (emp_id) REFERENCES employees(id)
);

-- Deductions table
CREATE TABLE deductions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    emp_id INT NOT NULL,
    month DATE NOT NULL,
    reason VARCHAR(255),
    amount DECIMAL(12,2) NOT NULL CHECK (amount >= 0),
    FOREIGN KEY (emp_id) REFERENCES employees(id)
);

-- Sample data
INSERT INTO employees (name) VALUES
('Ragul'),
('Ananya'),
('Vikram');

INSERT INTO salaries (emp_id, month, base, bonus) VALUES
(1, '2025-08-01', 50000, 5000),
(2, '2025-08-01', 45000, 0),
(3, '2025-08-01', 60000, 10000);

INSERT INTO deductions (emp_id, month, reason, amount) VALUES
(1, '2025-08-01', 'Late Coming', 2000),
(1, '2025-08-01', 'Tax', 3000),
(2, '2025-08-01', 'Tax', 2500),
(3, '2025-08-01', 'Tax', 4000);

-- Query: Monthly salary calculation with deductions
SELECT
    e.name,
    DATE_FORMAT(s.month, '%Y-%m') AS salary_month,
    s.base,
    s.bonus,
    COALESCE(SUM(d.amount), 0) AS total_deductions,
    (s.base + s.bonus - COALESCE(SUM(d.amount), 0)) AS net_salary
FROM employees e
JOIN salaries s ON e.id = s.emp_id
LEFT JOIN deductions d ON e.id = d.emp_id AND s.month = d.month
GROUP BY e.id, e.name, s.month, s.base, s.bonus;

-- Query: Employees with conditional bonus (>5000 if base > 55000)
SELECT
    e.name,
    s.base,
    s.bonus,
    CASE
        WHEN s.base > 55000 THEN 'Eligible for High Bonus'
        ELSE 'Normal Bonus'
    END AS bonus_status
FROM employees e
JOIN salaries s ON e.id = s.emp_id;
