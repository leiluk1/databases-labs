-- A part:
CREATE TABLE account (
    id INTEGER PRIMARY KEY,
    name VARCHAR(30),
    credit INTEGER,
    currency VARCHAR(4)
);

INSERT INTO account(id, name, credit, currency) VALUES 
(1, 'Leila Khaertdinova', 1000, 'RUB'),
(2, 'Kate Garden', 1000, 'RUB'),
(3, 'Kamil Gareev', 1000, 'RUB');

BEGIN;
SAVEPOINT S1;
UPDATE account SET credit = credit - 500 WHERE id = 1;
UPDATE account SET credit = credit + 500 WHERE id = 3;

SAVEPOINT S2;
UPDATE account SET credit = credit - 700 WHERE id = 2;
UPDATE account SET credit = credit + 700 WHERE id = 1;

SAVEPOINT S3;
UPDATE account SET credit = credit - 100 WHERE id = 2;
UPDATE account SET credit = credit + 100 WHERE id = 3;

SELECT * FROM account;

-- ROLLBACK TO S1;
-- ROLLBACK TO S2;

ROLLBACK TO S3;
COMMIT;



-- B part:
ALTER TABLE account 
ADD COLUMN bank_name VARCHAR(10);

UPDATE account SET bank_name = 'SberBank' 
WHERE id = 1 or id = 3;

UPDATE account SET bank_name = 'Tinkoff' 
WHERE id = 2;

INSERT INTO account(id, name, credit, currency) VALUES 
(4, 'Fees', 0, 'RUB');

CREATE OR REPLACE FUNCTION send_money(sender_id INTEGER, receiver_id INTEGER, fees_id INTEGER, amount INTEGER, fee INTEGER) 
RETURNS void AS $$

DECLARE
    sender TEXT;
    receiver TEXT;

BEGIN
    UPDATE account SET credit = credit - amount WHERE id = sender_id;
    UPDATE account SET credit = credit + amount WHERE id = receiver_id;
    SELECT bank_name INTO sender FROM account WHERE id = sender_id;
    SELECT bank_name INTO receiver FROM account WHERE id = receiver_id;
    IF (sender != receiver) THEN 
    UPDATE account SET credit = credit + fee WHERE id = fees_id;
    END IF;

END;
$$
LANGUAGE PLPGSQL;

BEGIN;
SAVEPOINT s1;
SELECT send_money(1, 3, 4, 500, 30);

SAVEPOINT s2;
SELECT send_money(2, 1, 4, 700, 30);

SAVEPOINT s3;
SELECT send_money(2, 3, 4, 100, 30);

SELECT * FROM account;

-- ROLLBACK TO s1;
-- ROLLBACK TO s2;

ROLLBACK TO s3;
COMMIT;
