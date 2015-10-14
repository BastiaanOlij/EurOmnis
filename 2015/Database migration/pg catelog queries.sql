-- Queries that retrieve required meta data from the postgres catelog tables to allow you to compare what you have with your schema classes.
select
t.schemaname
, t.tablename
, coalesce(d.description,'')
, t.tableowner
from pg_tables as t
join pg_class as c on c.relname = t.tablename and c.relkind='r'
left outer join pg_description as d on d.objoid = c.oid and d.objsubid=0
where t.schemaname = 'public'
order by upper(t.tablename);

-- get column details for a table
select c.relname as TableName
, a.attname as ColumnName
, t.typname as Datatype
, case when t.typname = 'varchar' then a.atttypmod-4 when t.typname='numeric' and a.atttypmod>0 then ((a.atttypmod - 4) >> 16) & 65535 end as Datalen
, case when t.typname='numeric' and a.atttypmod>0 then (a.atttypmod - 4) & 65535 else 0 end as Datalen2
, a.attnotnull as NoNull
, coalesce(ad.adsrc,'') as Default
, exists (select 1 from pg_index where indrelid = c.oid and attnum = any(pg_index.indkey) and indisprimary) as IsPrimary     -- If our column is part of our primary key, it is a primary index column...
, coalesce(d.description,'') as Description
from pg_class as c
join pg_tables as tb on tb.tablename=c.relname and tb.schemaname = 'public'
join pg_attribute as a on a.attrelid = c.oid
join pg_type as t on t.oid = a.atttypid
left outer join pg_attrdef as ad on ad.adrelid=c.oid and ad.adnum = a.attnum
left outer join pg_description as d on d.objoid = c.oid and d.objsubid=a.attnum
where c.relkind='r' and a.attnum>0
and c.relname = 'mytable' -- optional, specify the table for which you want to retrieve columns
order by c.relname, a.attnum

-- get a list of indexes 
select c.relname as TableName
, ic.relname as IndexName
, att.attname as IndexKeys
, idx.indisunique as UniqueKey
, false as IsFullText
, position(' ' || att.attnum::varchar(25) || ' ' in ' ' || array_to_string(idx.indkey,' ') || ' ') as orderkeys     -- Used position as poor mans alternative..
from pg_class as c
join pg_tables as tb on tb.tablename=c.relname and tb.schemaname = 'public'
join pg_index as idx on idx.indrelid=c.oid and idx.indisprimary = false
join pg_class as ic on ic.oid = idx.indexrelid
join pg_attribute as att on att.attrelid = c.oid and att.attnum = any(idx.indkey)
where c.relname = 'faddresses' -- optional, specify the table for which you want to retrieve columns
order by TableName, IndexName, orderkeys     -- , idx(idx.indkey,att.attnum::int) -- order doesn't work on 8.4:(

-- list of referential integrity
select
t1.conname,     -- 'ReferenceName'
t4.relname,     -- 'PrimaryTable'
t5.attname,     -- 'PrimaryColumn'
t2.relname,     -- 'ForeignTable'
t3.attname,     -- 'ForeignColumn'
t1.condeferrable     -- Deferrable
from pg_constraint as t1
join pg_class as t2 on t2.oid = t1.conrelid
join pg_attribute as t3 on t3.attrelid = t1.conrelid and t3.attnum = t1.conkey[1]     -- We assume all our foreign keys are single column, this is true with 2 exceptions which we'll soon get rid off and which won't impact this code
join pg_class as t4 on t4.oid = t1.confrelid
join pg_attribute as t5 on t5.attrelid = t1.confrelid and t5.attnum = t1.confkey[1]     -- We assume all our foreign keys are single column, this is true with 2 exceptions which we'll soon get rid off and which won't impact this code
and t1.contype='f'     -- Only foreign key constraints
where t2.relname = 'faddresses' -- optional, specify the table for which you want to retrieve columns

-- Get all triggers for a table
select c.relname, t.tgname, f.proname
, case when t.tgtype & cast(4 as int2) <> 0 then true else false end OnInsert
, case when t.tgtype & cast(8 as int2) <> 0 then true else false end OnDelete
, case when t.tgtype & cast(16 as int2) <> 0 then true else false end OnUpdate
, case when t.tgtype & cast(2 as int2) <> 0 then false else true end DoAfter
, case when t.tgtype & cast(1 as int2) <> 0 then true else false end EveryRow
from pg_trigger as t
join pg_class as c on c.oid = t.tgrelid
join pg_proc as f on f.oid = t.tgfoid
where t.tgconstraint = 0 -- PG 9.0 +
and c.relname = 'faddresses' -- optional, specify the table for which you want to retrieve columns
