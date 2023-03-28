-- C part:
CREATE TABLE Ledger (
    id SERIAL PRIMARY KEY,
    "from" INTEGER,
    "to" INTEGER,
    fee INTEGER,
    amount INTEGER,
    transaction_date_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE OR REPLACE FUNCTION send_money2(sender_id INTEGER, receiver_id INTEGER, fees_id INTEGER, amount INTEGER, fee INTEGER)
RETURNS void AS $$
DECLARE
    sender TEXT;
    receiver TEXT;
    total INT := 0;
BEGIN
    SELECT bank_name INTO sender FROM account WHERE id = sender_id;
    SELECT bank_name INTO receiver FROM account WHERE id = receiver_id;
    IF (sender != receiver) THEN
        total := fee;
    END IF;
    INSERT INTO Ledger ("from", "to", fee, amount) VALUES (sender_id, receiver_id, total, amount);
END;
$$

LANGUAGE PLPGSQL;

BEGIN;
SAVEPOINT S1;
SELECT send_money2(1, 3, 4, 500, 30);

SAVEPOINT S2;
SELECT send_money2(2, 1, 4, 700, 30);

SAVEPOINT S3;
SELECT send_money2(2, 3, 4, 100, 30);

SELECT * FROM account;
COMMIT;
