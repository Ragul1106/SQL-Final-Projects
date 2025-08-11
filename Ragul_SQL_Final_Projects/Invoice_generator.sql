CREATE DATABASE invoice_generator_db;
USE invoice_generator_db;

CREATE TABLE clients (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE invoices (
    id INT AUTO_INCREMENT PRIMARY KEY,
    client_id INT NOT NULL,
    date DATE NOT NULL,
    FOREIGN KEY (client_id) REFERENCES clients(id)
);

CREATE TABLE invoice_items (
    id INT AUTO_INCREMENT PRIMARY KEY,
    invoice_id INT NOT NULL,
    description VARCHAR(255) NOT NULL,
    quantity INT NOT NULL CHECK (quantity > 0),
    rate DECIMAL(10,2) NOT NULL CHECK (rate >= 0),
    FOREIGN KEY (invoice_id) REFERENCES invoices(id)
);

INSERT INTO clients (name) VALUES
('Acme Corp'),
('Beta Ltd');

INSERT INTO invoices (client_id, date) VALUES
(1, '2025-08-01'),
(2, '2025-08-03');

INSERT INTO invoice_items (invoice_id, description, quantity, rate) VALUES
(1, 'Website Design', 1, 1500.00),
(1, 'Hosting (1 year)', 1, 100.00),
(2, 'Consulting', 5, 200.00),
(2, 'Support', 10, 50.00);

-- Query: Invoice details with subtotal per item and total per invoice
SELECT
    c.name AS client_name,
    i.id AS invoice_id,
    i.date,
    ii.description,
    ii.quantity,
    ii.rate,
    (ii.quantity * ii.rate) AS subtotal
FROM invoices i
JOIN clients c ON i.client_id = c.id
JOIN invoice_items ii ON ii.invoice_id = i.id
ORDER BY i.id;

-- Query: Total amount per invoice
SELECT
    i.id AS invoice_id,
    c.name AS client_name,
    i.date,
    SUM(ii.quantity * ii.rate) AS total_amount
FROM invoices i
JOIN clients c ON i.client_id = c.id
JOIN invoice_items ii ON ii.invoice_id = i.id
GROUP BY i.id, c.name, i.date;
