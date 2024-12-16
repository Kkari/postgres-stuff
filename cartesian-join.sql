create table post(
    id integer
);

create table author(
     id integer,
    post_id integer
);

create table tags(
                       id integer,
                       post_id integer
);

insert into post values (1),(2),(3);
insert into author values (1,1),(2,1),(3,1);
insert into tags values (1,1),(2,1),(3,1);

select *
from post
left outer join tags on post.id = tags.post_id;

select *
from post
         left outer join author on post.id = author.post_id;

-- This will have a horrible performance because tags and author builds a cartesian product
select post.id, tags.id, author.id
from post
         left outer join tags on post.id = tags.post_id
         left outer join author on post.id = author.post_id;