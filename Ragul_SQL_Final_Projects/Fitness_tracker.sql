CREATE DATABASE fitness_tracker_db;
USE fitness_tracker_db;

CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE workouts (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    type VARCHAR(50) NOT NULL
);

CREATE TABLE workout_logs (
    user_id INT NOT NULL,
    workout_id INT NOT NULL,
    duration INT NOT NULL,
    log_date DATE NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (workout_id) REFERENCES workouts(id) ON DELETE CASCADE
);

INSERT INTO users (name) VALUES
('Ragul'),
('Hari'),
('Vetri');

INSERT INTO workouts (name, type) VALUES
('Morning Run', 'Cardio'),
('Weight Lifting', 'Strength'),
('Yoga Session', 'Flexibility');

INSERT INTO workout_logs (user_id, workout_id, duration, log_date) VALUES
(1, 1, 30, '2025-08-04'),
(2, 2, 45, '2025-08-05'),
(3, 3, 60, '2025-08-06'),
(1, 2, 40, '2025-08-07'),
(1, 1, 35, '2025-08-08');

SELECT u.name, w.name AS workout, SUM(wl.duration) AS total_minutes
FROM workout_logs wl
JOIN users u ON wl.user_id = u.id
JOIN workouts w ON wl.workout_id = w.id
WHERE wl.log_date BETWEEN '2025-08-04' AND '2025-08-10'
GROUP BY u.name, w.name
ORDER BY u.name;

SELECT u.name, SUM(wl.duration) AS weekly_total
FROM workout_logs wl
JOIN users u ON wl.user_id = u.id
WHERE wl.log_date BETWEEN '2025-08-04' AND '2025-08-10'
GROUP BY u.name
ORDER BY weekly_total DESC;
