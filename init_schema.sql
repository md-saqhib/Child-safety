-- Child Safety System - PostgreSQL Schema
-- Auto-created for Render PostgreSQL deployment

CREATE TABLE IF NOT EXISTS users (
    user_id SERIAL PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20),
    password VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS admin (
    id SERIAL PRIMARY KEY,
    username VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS child (
    child_id SERIAL PRIMARY KEY,
    user_id INT NOT NULL REFERENCES users(user_id),
    child_name VARCHAR(100) NOT NULL,
    age INT,
    gender VARCHAR(20),
    school_name VARCHAR(150),
    address TEXT
);

CREATE TABLE IF NOT EXISTS incidents (
    incident_id SERIAL PRIMARY KEY,
    child_id INT NOT NULL REFERENCES child(child_id),
    user_id INT NOT NULL REFERENCES users(user_id),
    title VARCHAR(200),
    description TEXT,
    location VARCHAR(200),
    incident_type VARCHAR(50),
    status VARCHAR(50) DEFAULT 'Pending',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS feedback (
    feedback_id SERIAL PRIMARY KEY,
    user_id INT NOT NULL REFERENCES users(user_id),
    message TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insert default admin account (username: admin, password: admin123)
INSERT INTO admin (username, password)
SELECT 'admin', 'admin123'
WHERE NOT EXISTS (SELECT 1 FROM admin WHERE username = 'admin');
