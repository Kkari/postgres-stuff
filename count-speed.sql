-- Show table size
SELECT pg_size_pretty(pg_total_relation_size('items'));
SELECT pg_size_pretty(pg_total_size('items'));

-- Show shared buffer size
SHOW shared_buffers; -- default 128MB

-- Set shared buffer size
ALTER SYSTEM SET shared_buffers TO '16MB';
SELECT pg_reload_conf();

-- Start Server
-- pg_ctl -D /usr/local/var/postgres -l logfile start
-- -- Fill up data
-- create a million random numbers and strings
CREATE TABLE items AS
  SELECT
    (random()*1000000)::integer AS n,
    md5(random()::text) AS s
  FROM
    generate_series(1,1000000);

-- inform planner of big table size change
VACUUM ANALYZE;

-- Number of pages scanned
SELECT count(blkno) FROM pg_freespace('public.items');

-- Compact Data
VACUUM FULL;


