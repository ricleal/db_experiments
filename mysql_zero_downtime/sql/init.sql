-- CREATE DATABASE IF NOT EXISTS experiment;

USE experiment;

CREATE TABLE IF NOT EXISTS Person (
    id varchar(36) NOT NULL,
    name varchar(255),
    email varchar(255),
    phone varchar(31),
    address varchar(255),
    city varchar(127),
    zip_code varchar(15),
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (ID)
);

-- GRANT ALL PRIVILEGES ON experiment.* TO 'user1'@'%'
-- FLUSH PRIVILEGES;
