-- Generic data generator with different columns
CREATE TABLE gt (
    id serial PRIMARY KEY, 
    uuid_id UUID,
    i integer,
    uniq_strings varchar(50), 
    enum_strings varchar(10),
    same_string varchar(10)
); 

CREATE INDEX gt_uuid_id_idx ON gt (uuid_id);
CREATE INDEX gt_i_idx ON gt (i);
CREATE INDEX gt_uniq_strings_idx ON gt (uniq_strings);
CREATE INDEX gt_enum_strings_idx ON gt (enum_strings);
CREATE INDEX gt_same_string  ON gt (same_string);


INSERT INTO gt (uuid_id, i, uniq_strings, enum_strings, same_string) 
SELECT 
    gen_random_uuid(),
    (random()*1000000)::integer,
    md5(random()::text),
    CASE floor(random() * 3) 
        WHEN 0 THEN 'RED'
        WHEN 1 THEN 'BLUE' 
        ELSE 'GREEN' 
    END,
    'constant'
FROM generate_series(1,100000);

 vacuum analyze test;

-- What is this thing?
CREATE TABLE z () inherits (test);

-- Create table and generate test data
CREATE TABLE test ( all_the_same int4, almost_unique int4 );
 
INSERT INTO test ( all_the_same, almost_unique ) SELECT 123, random() * 1000000 FROM generate_series(1,100000);


-- Delete entries at random
DELETE FROM your_table
WHERE ctid IN (SELECT ctid FROM your_table TABLESAMPLE SYSTEM (50));

DELETE FROM your_table
WHERE ctid IN (SELECT ctid FROM your_table ORDER BY random() LIMIT (SELECT count(*) / 2 FROM your_table));

DELETE FROM your_table WHERE random() < 0.5;



-- Heavy data insert script
DO $$
DECLARE
  batch_size int := 1000;
  start_id int := 1;
  end_id int;
  total_rows int := 10000000;
  current_row int;
  percent_complete numeric(5,2);
BEGIN
  WHILE start_id <= total_rows LOOP
    end_id := start_id + batch_size - 1;

    INSERT INTO gt (uuid_id, i, uniq_strings, enum_strings, same_string)
    SELECT
        gen_random_uuid(),
        (random()*1000000)::integer,
        md5(random()::text),
        CASE floor(random() * 3)
            WHEN 0 THEN 'RED'
            WHEN 1 THEN 'BLUE'
            ELSE 'GREEN'
            END,
        'constant'
    FROM generate_series(start_id, end_id);

    COMMIT;

    current_row := end_id;
    percent_complete := (current_row::numeric / total_rows::numeric) * 100;
    RAISE NOTICE 'Percent complete: %.2f%%', percent_complete;  -- Print progress

    start_id := end_id + 1;
  END LOOP;
END $$;