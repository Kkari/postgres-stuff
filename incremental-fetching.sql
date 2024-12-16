-- Roughly how JDBC does fetching if the fetch size is calibrated. 

BEGIN;
DECLARE user_cursor CURSOR FOR select * from t;
FETCH 2 FROM user_cursor;
-- Process the fetched rows here
FETCH 2 FROM user_cursor;
-- Process more rows
CLOSE user_cursor;
COMMIT;