CREATE DATABASE multi_tenant_saas_db;
USE multi_tenant_saas_db;

CREATE TABLE tenants (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL
);

CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    tenant_id INT NOT NULL,
    FOREIGN KEY (tenant_id) REFERENCES tenants(id) ON DELETE CASCADE
);

CREATE TABLE data (
    id INT PRIMARY KEY AUTO_INCREMENT,
    tenant_id INT NOT NULL,
    content TEXT NOT NULL,
    FOREIGN KEY (tenant_id) REFERENCES tenants(id) ON DELETE CASCADE
);

INSERT INTO tenants (name) VALUES
('Tenant A'),
('Tenant B');

INSERT INTO users (name, tenant_id) VALUES
('Ragul', 1),
('Ranjith', 1),
('Arul', 2);

INSERT INTO data (tenant_id, content) VALUES
(1, 'Data for Tenant A - Record 1'),
(1, 'Data for Tenant A - Record 2'),
(2, 'Data for Tenant B - Record 1');

SELECT u.name, t.name AS tenant_name
FROM users u
JOIN tenants t ON u.tenant_id = t.id;

SELECT d.content
FROM data d
JOIN tenants t ON d.tenant_id = t.id
WHERE t.name = 'Tenant A';
