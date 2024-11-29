-- great article: https://aws.amazon.com/blogs/database/understanding-autovacuum-in-amazon-rds-for-postgresql-environments/
CREATE TABLE mvcc_test(id int);
INSERT INTO mvcc_test VALUES(1);

-- Tuple inserted
SELECT ctid, xmin, xmax, * FROM mvcc_test;

-- Update is an insert and delete
UPDATE mvcc_test SET id = id;

-- A fully new tuple is created
SELECT ctid, xmin, xmax, * FROM mvcc_test;

-- You can see the dead tuple still in the table
SELECT
relname AS TableName
,n_live_tup AS LiveTuples
,n_dead_tup AS DeadTuples
,last_autovacuum AS Autovacuum
,last_autoanalyze AS Autoanalyze
FROM pg_stat_user_tables;

-- See last autovacuum updates
SELECT relname, last_autovacuum, last_autoanalyze FROM pg_stat_user_tables;

-- See autovacuum settings
select category, name, setting, unit, source, min_val, max_val, boot_val from pg_settings where category = 'Autovacuum' ;
