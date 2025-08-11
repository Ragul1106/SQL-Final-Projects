CREATE DATABASE library_management_db;
USE library_management_db;

CREATE TABLE books (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    author VARCHAR(100) NOT NULL
);

CREATE TABLE members (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE borrows (
    id INT AUTO_INCREMENT PRIMARY KEY,
    member_id INT NOT NULL,
    book_id INT NOT NULL,
    borrow_date DATE NOT NULL,
    return_date DATE,
    FOREIGN KEY (member_id) REFERENCES members(id) ON DELETE CASCADE,
    FOREIGN KEY (book_id) REFERENCES books(id) ON DELETE CASCADE
);

INSERT INTO books (title, author) VALUES
('The Great Gatsby', 'F. Scott Fitzgerald'),
('1984', 'George Orwell'),
('To Kill a Mockingbird', 'Harper Lee');

INSERT INTO members (name) VALUES
('Ragul'),
('Ananya'),
('Kavin');

INSERT INTO borrows (member_id, book_id, borrow_date, return_date) VALUES
(1, 1, '2025-07-01', '2025-07-10'),
(2, 2, '2025-07-05', NULL),
(3, 3, '2025-07-10', '2025-07-15'),
(1, 3, '2025-07-20', NULL);

-- Query: List all borrowed books with member info and borrow/return dates
SELECT m.name AS member_name, b.title AS book_title, b.author,
       br.borrow_date, br.return_date
FROM borrows br
JOIN members m ON br.member_id = m.id
JOIN books b ON br.book_id = b.id;

-- Query: Calculate fine assuming $1 per day late after 14 days borrowing period
SELECT m.name AS member_name, b.title AS book_title, br.borrow_date, br.return_date,
    CASE
        WHEN br.return_date IS NULL THEN 'Not Returned'
        WHEN DATEDIFF(br.return_date, br.borrow_date) > 14 THEN
            DATEDIFF(br.return_date, br.borrow_date) - 14
        ELSE 0
    END AS late_days,
    CASE
        WHEN br.return_date IS NULL THEN 0
        WHEN DATEDIFF(br.return_date, br.borrow_date) > 14 THEN
            (DATEDIFF(br.return_date, br.borrow_date) - 14) * 1
        ELSE 0
    END AS fine_amount
FROM borrows br
JOIN members m ON br.member_id = m.id
JOIN books b ON br.book_id = b.id;
