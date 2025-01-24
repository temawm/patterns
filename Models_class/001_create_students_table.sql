CREATE TABLE students (
    id INT AUTO_INCREMENT PRIMARY KEY,
    last_name VARCHAR(255) NOT NULL,
    first_name VARCHAR(255) NOT NULL,
    middle_name VARCHAR(255),
    phone VARCHAR(15),
    telegram VARCHAR(50),
    email VARCHAR(255),
    github VARCHAR(255),
);