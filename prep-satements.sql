-- Creating and executing a prepared statement
PREPARE get_t (int) AS
    SELECT * FROM t where b = $1;

EXECUTE get_t(1);

