CREATE TABLE IF NOT EXISTS non_els_cars (
    id INT AUTO_INCREMENT PRIMARY KEY,
    owner VARCHAR(50) NOT NULL,
    model VARCHAR(50) NOT NULL,
    plate VARCHAR(10) NOT NULL,
    livery INT DEFAULT 0,
    extras JSON DEFAULT NULL
);

INSERT INTO non_els_cars (owner, model, plate, livery, extras) VALUES
('admin', 'police', 'POLICE01', 0, '{"1": true, "2": false}');