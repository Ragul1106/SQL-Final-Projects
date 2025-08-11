CREATE DATABASE sports_tournament_db;
USE sports_tournament_db;

CREATE TABLE teams (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE matches (
    id INT PRIMARY KEY AUTO_INCREMENT,
    team1_id INT NOT NULL,
    team2_id INT NOT NULL,
    match_date DATE NOT NULL,
    FOREIGN KEY (team1_id) REFERENCES teams(id) ON DELETE CASCADE,
    FOREIGN KEY (team2_id) REFERENCES teams(id) ON DELETE CASCADE
);

CREATE TABLE scores (
    match_id INT NOT NULL,
    team_id INT NOT NULL,
    score INT NOT NULL,
    FOREIGN KEY (match_id) REFERENCES matches(id) ON DELETE CASCADE,
    FOREIGN KEY (team_id) REFERENCES teams(id) ON DELETE CASCADE
);

INSERT INTO teams (name) VALUES
('Team Alpha'),
('Team Bravo'),
('Team Charlie');

INSERT INTO matches (team1_id, team2_id, match_date) VALUES
(1, 2, '2025-07-01'),
(2, 3, '2025-07-05'),
(1, 3, '2025-07-10');

INSERT INTO scores (match_id, team_id, score) VALUES
(1, 1, 3),
(1, 2, 1),
(2, 2, 2),
(2, 3, 2),
(3, 1, 1),
(3, 3, 4);

SELECT t.name AS team_name,
       SUM(CASE WHEN s.score > opp.score THEN 1 ELSE 0 END) AS wins,
       SUM(CASE WHEN s.score < opp.score THEN 1 ELSE 0 END) AS losses
FROM scores s
JOIN teams t ON s.team_id = t.id
JOIN scores opp ON s.match_id = opp.match_id AND s.team_id <> opp.team_id
GROUP BY t.id, t.name
ORDER BY wins DESC;

SELECT t.name AS team_name, SUM(s.score) AS total_score
FROM scores s
JOIN teams t ON s.team_id = t.id
GROUP BY t.id, t.name
ORDER BY total_score DESC;
