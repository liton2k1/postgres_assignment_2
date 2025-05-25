-- Active: 1747426910940@@localhost@5432@postgres_queries
SELECT * FROM users;
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    full_name VARCHAR(100)
);

INSERT INTO users (username, email, password, full_name)
VALUES 
('john_doe', 'john@example.com', 'John Doe'),
('jane_smith', 'jane@example.com', 'Jane Smith'),
('alice_lee', 'alice@example.com', 'Alice Lee');



