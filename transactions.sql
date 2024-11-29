-- Sets the subsequent trasactiosn to serialisable.
SET SESSION CHARACTERISTICS AS TRANSACTION ISOLATION LEVEL SERIALIZABLE;

-- Sets the transaction isolation level to serialisable.
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE ;

-- Show the current transaction isolation level
SHOW TRANSACTION ISOLATION LEVEL;
SELECT current_setting('transaction_isolation');

-- Get the session ID
SELECT pg_backend_pid();

-- Get stats about the current session
SELECT * FROM pg_stat_activity WHERE pid = pg_backend_pid();

-- Gives back the current transaction ID in Postgres
SELECT txid_current();

-- Gives back the internal MVCC transaction markers on the student tuples.
SELECT xmin, xmax, * from student;

