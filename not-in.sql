create table t(i integer);
insert into t values (1), (2);

-- All of these return NULL sadly
-- "not in" also has a terrible performance larger datases where hashed subplan can't be used
-- Readme: https://wiki.postgresql.org/wiki/Don't_Do_This#Don.27t_use_NOT_IN
select * from t where i not in (1, null);
select * from t where not(i in(1, null));
select * from t where not(i in(select * from unnest(array[null,1])));

SELECT *
FROM t
WHERE NOT EXISTS (
    SELECT 1
    FROM (VALUES (1), (NULL)) AS v(i)
    WHERE v.i = t.i
);
-- returns false safely
select not exists(select null)