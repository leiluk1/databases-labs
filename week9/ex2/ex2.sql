CREATE TABLE IF NOT EXISTS account (
    username VARCHAR(30) PRIMARY KEY,
    fullname VARCHAR(30),
    balance INTEGER,
    group_id INTEGER 
);

INSERT INTO account (username, fullname, balance, group_id) VALUES
    ('jones', 'Alice Jones', 82, 1),
    ('bitdiddl', 'Ben Bitdiddle', 65, 1),
    ('mike', 'Michael Dole', 73, 2),
    ('alyssa', 'Alyssa P. Hacker', 79, 3),
    ('bbrown', 'Bob Brown', 100, 3);
