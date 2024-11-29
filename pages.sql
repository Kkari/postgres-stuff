-- Load extension
-- free space in pages
CREATE EXTENSION pg_freespacemap; 

-- tuple statistics
CREATE EXTENSION pgstattuple;

-- Visibility map
CREATE EXTENSION pg_visibility;


-- Look up the ratio of space available on each page that stores data for the gt table
SELECT *, round(100 * avail/8192, 2) as "freespace ratio" FROM pg_freespace('gt');
select relname, pg_size_pretty(pg_relation_size(oid)), pg_prewarm(oid) from pg_class where relname like 'records%';

-- Look up the DB files related to the gt table
SELECT pg_relation_filepath('gt');

-- These are the same attributes, but because of null padding due to CPU word aligment, they will have a different column size 
SELECT pg_column_size(ROW('a'::char, 2::int2, 'b'::char, 4::int4, 'c'::char, 8::int8))
SELECT pg_column_size(ROW(8::int8,  2::int2, 4::int4, 'a'::char, 'b'::char, 'c'::char))


-- The ctid gives back the page and slot pointer.
-- It changes after VACUM FULL because that applies compacting.
-- By rewriting the table.
SELECT ctid, * from gt;

-- PG Statistics, pg_stats is more readable
SELECT * FROM pg_statistic WHERE starelid = 'gt'::regclass;
SELECT * FROM pg_stats WHERE tablename = 'gt'; 


-- tuple header 23 bytes
-- page header 24 bytes
SELECT ctid, * from gt WHERE ctid::text LIKE '(3,%';

SELECT * FROM pgstattuple_approx('gt');
SELECT * FROM pgstatindex('gt_pkey');
SELECT pg_size_pretty(pg_relation_size('gt_pkey'));