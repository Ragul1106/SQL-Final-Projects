CREATE DATABASE it_support_ticket_db;
USE it_support_ticket_db;

CREATE TABLE tickets (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    issue TEXT NOT NULL,
    status ENUM('Open', 'In Progress', 'Resolved', 'Closed') NOT NULL,
    created_at DATETIME NOT NULL,
    resolved_at DATETIME
);

CREATE TABLE support_staff (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE assignments (
    ticket_id INT NOT NULL,
    staff_id INT NOT NULL,
    FOREIGN KEY (ticket_id) REFERENCES tickets(id) ON DELETE CASCADE,
    FOREIGN KEY (staff_id) REFERENCES support_staff(id) ON DELETE CASCADE
);

INSERT INTO tickets (user_id, issue, status, created_at, resolved_at) VALUES
(1, 'Unable to login to account', 'Resolved', '2025-08-01 09:00:00', '2025-08-01 11:30:00'),
(2, 'System crash during report generation', 'In Progress', '2025-08-02 10:15:00', NULL),
(3, 'Email not syncing', 'Resolved', '2025-08-03 08:45:00', '2025-08-03 09:30:00');

INSERT INTO support_staff (name) VALUES
('Raugl Ramayadoss'),
('Heera Ragul');

INSERT INTO assignments (ticket_id, staff_id) VALUES
(1, 1),
(2, 2),
(3, 1);

SELECT AVG(TIMESTAMPDIFF(MINUTE, created_at, resolved_at)) AS avg_resolution_time_minutes
FROM tickets
WHERE resolved_at IS NOT NULL;

SELECT issue, COUNT(*) AS ticket_count
FROM tickets
GROUP BY issue
ORDER BY ticket_count DESC;
