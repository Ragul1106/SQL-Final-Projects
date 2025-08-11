CREATE DATABASE leave_management_system_db;
USE leave_management_system_db;

CREATE TABLE employees (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE leave_types (
    id INT PRIMARY KEY AUTO_INCREMENT,
    type_name VARCHAR(50) NOT NULL
);

CREATE TABLE leave_requests (
    id INT PRIMARY KEY AUTO_INCREMENT,
    emp_id INT NOT NULL,
    leave_type_id INT NOT NULL,
    from_date DATE NOT NULL,
    to_date DATE NOT NULL,
    status ENUM('Pending', 'Approved', 'Rejected') DEFAULT 'Pending',
    CONSTRAINT fk_leave_emp FOREIGN KEY (emp_id) REFERENCES employees(id),
    CONSTRAINT fk_leave_type FOREIGN KEY (leave_type_id) REFERENCES leave_types(id),
    CONSTRAINT chk_date CHECK (from_date <= to_date),
    CONSTRAINT uq_leave UNIQUE (emp_id, from_date, to_date)
);

INSERT INTO employees (name) VALUES
('John Doe'),
('Alice Smith'),
('Robert Brown');

INSERT INTO leave_types (type_name) VALUES
('Annual Leave'),
('Sick Leave'),
('Maternity Leave');

INSERT INTO leave_requests (emp_id, leave_type_id, from_date, to_date, status) VALUES
(1, 1, '2025-08-01', '2025-08-05', 'Approved'),
(2, 2, '2025-08-03', '2025-08-04', 'Pending'),
(3, 1, '2025-08-10', '2025-08-15', 'Approved'),
(1, 2, '2025-08-20', '2025-08-21', 'Rejected');

SELECT emp_id, leave_type_id, SUM(DATEDIFF(to_date, from_date) + 1) AS total_days
FROM leave_requests
WHERE status = 'Approved'
GROUP BY emp_id, leave_type_id;
