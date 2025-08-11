CREATE DATABASE movie_db;
USE movie_db;

CREATE TABLE genres (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL
);

CREATE TABLE movies (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(100) NOT NULL,
    release_year INT,
    genre_id INT,
    FOREIGN KEY (genre_id) REFERENCES genres(id) ON DELETE CASCADE
);

CREATE TABLE ratings (
    user_id INT,
    movie_id INT,
    score DECIMAL(3,1) CHECK (score >= 0 AND score <= 10),
    PRIMARY KEY (user_id, movie_id),
    FOREIGN KEY (movie_id) REFERENCES movies(id) ON DELETE CASCADE
);

INSERT INTO genres (name) VALUES
('Action'),
('Comedy'),
('Drama');

INSERT INTO movies (title, release_year, genre_id) VALUES
('Fast & Furious', 2001, 1),
('The Mask', 1994, 2),
('The Shawshank Redemption', 1994, 3);

INSERT INTO ratings (user_id, movie_id, score) VALUES
(1, 1, 8.5),
(2, 1, 7.8),
(1, 2, 8.0),
(3, 3, 9.5),
(2, 3, 9.0);

SELECT m.title, AVG(r.score) AS avg_rating
FROM movies m
JOIN ratings r ON m.id = r.movie_id
GROUP BY m.id, m.title;

SELECT m.title, g.name AS genre, AVG(r.score) AS avg_rating
FROM movies m
JOIN genres g ON m.genre_id = g.id
LEFT JOIN ratings r ON m.id = r.movie_id
GROUP BY m.id, m.title, g.name;
