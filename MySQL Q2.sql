-- A ski resort company is planning to construct a new ski 
-- slope using a pre-existing network of mountain huts and trails 
-- between them. A new slope has to begin at one of the mountain huts, 
-- have a middle station at another hut connected with the first 
-- one by a direct trail, and end at the third mountain hut which 
-- is also connected by a direct trail to the second hut. 
-- The altitude of the three huts chosen for constructing 
-- the ski slope has to be strictly decreasing.


drop table if exists mountain_huts;
create table mountain_huts 
(
	id 			integer not null unique,
	name 		varchar(40) not null unique,
	altitude 	integer not null
);
insert into mountain_huts values (1, 'Dakonat', 1900);
insert into mountain_huts values (2, 'Natisa', 2100);
insert into mountain_huts values (3, 'Gajantut', 1600);
insert into mountain_huts values (4, 'Rifat', 782);
insert into mountain_huts values (5, 'Tupur', 1370);

drop table if exists trails;
create table trails 
(
	hut1 		integer not null,
	hut2 		integer not null
);
insert into trails values (1, 3);
insert into trails values (3, 2);
insert into trails values (3, 5);
insert into trails values (4, 5);
insert into trails values (1, 5);

select * from mountain_huts;
select * from trails;


-- STEP 1

select t1.*,h1.*
from mountain_huts h1
join trails t1 on t1.hut1 = h1.id


-- STEP 2

with cte_trails1 as
		(select t1.*,h1.*
		from mountain_huts h1
		join trails t1 on t1.hut1 = h1.id)
select *
from cte_trails1 t2
join mountain_huts h2 on h2.id = t2.hut2


-- STEP 3

with cte_trails1 as
		(select t1.hut1 as start_hut, h1.name as start_hut_name,
		 h1.altitude as start_hut_altitude, t1.hut2 as end_hut
		from mountain_huts h1
		join trails t1 on t1.hut1 = h1.id)
select 
from cte_trails1 t2
join mountain_huts h2 on h2.id = t2.hut2


-- STEP 4

with cte_trails1 as
		(select t1.hut1 as start_hut, h1.name as start_hut_name,
		 h1.altitude as start_hut_altitude, t1.hut2 as end_hut
		from mountain_huts h1
		join trails t1 on t1.hut1 = h1.id)
select t2.*,h2.name as end_hut_name, h2.altitude as end_hut_altitude
from cte_trails1 t2
join mountain_huts h2 on h2.id = t2.end_hut


-- STEP 5

with cte_trails1 as
		(select t1.hut1 as start_hut, h1.name as start_hut_name,
		 h1.altitude as start_hut_altitude, t1.hut2 as end_hut
		from mountain_huts h1
		join trails t1 on t1.hut1 = h1.id)
select t2.*,h2.name as end_hut_name, h2.altitude as end_hut_altitude,
case when start_hut_altitude > h2.altitude then 1 else 0 end as altitude_flag
from cte_trails1 t2
join mountain_huts h2 on h2.id = t2.end_hut


-- STEP 6

with cte_trails1 as
		(select t1.hut1 as start_hut, h1.name as start_hut_name,
		 h1.altitude as start_hut_altitude, t1.hut2 as end_hut
		from mountain_huts h1
		join trails t1 on t1.hut1 = h1.id),
	cte_trails2 as
		(select t2.*,h2.name as end_hut_name, h2.altitude as end_hut_altitude,
		case when start_hut_altitude > h2.altitude then 1 else 0 end as altitude_flag
		from cte_trails1 t2
		join mountain_huts h2 on h2.id = t2.end_hut)
select *
from cte_trails2


-- STEP 7

with cte_trails1 as
		(select t1.hut1 as start_hut, h1.name as start_hut_name,
		 h1.altitude as start_hut_altitude, t1.hut2 as end_hut
		from mountain_huts h1
		join trails t1 on t1.hut1 = h1.id),
	cte_trails2 as
		(select t2.*,h2.name as end_hut_name, h2.altitude as end_hut_altitude,
		case when start_hut_altitude > h2.altitude then 1 else 0 end as altitude_flag
		from cte_trails1 t2
		join mountain_huts h2 on h2.id = t2.end_hut)
select case when altitude_flag = 1 then start_hut else end_hut end as start_hut,
case when altitude_flag = 1 then start_hut_name else end_hut_name end as start_hut_name
,case when altitude_flag = 1 then end_hut else start_hut end as end_hut
,case when altitude_flag = 1 then end_hut_name else start_hut_name end as end_hut_name
from cte_trails2


-- STEP 8

with cte_trails1 as
		(select t1.hut1 as start_hut, h1.name as start_hut_name,
		 h1.altitude as start_hut_altitude, t1.hut2 as end_hut
		from mountain_huts h1
		join trails t1 on t1.hut1 = h1.id),
	cte_trails2 as
		(select t2.*,h2.name as end_hut_name, h2.altitude as end_hut_altitude,
		case when start_hut_altitude > h2.altitude then 1 else 0 end as altitude_flag
		from cte_trails1 t2
		join mountain_huts h2 on h2.id = t2.end_hut),
	cte_final as	
		(select case when altitude_flag = 1 then start_hut else end_hut end as start_hut,
		case when altitude_flag = 1 then start_hut_name else end_hut_name end as start_hut_name
		,case when altitude_flag = 1 then end_hut else start_hut end as end_hut
		,case when altitude_flag = 1 then end_hut_name else start_hut_name end as end_hut_name
		from cte_trails2)
select *
from cte_final c1
join cte_final c2 on c1.end_hut = c2.start_hut


-- STEP 9

with cte_trails1 as
		(select t1.hut1 as start_hut, h1.name as start_hut_name,
		 h1.altitude as start_hut_altitude, t1.hut2 as end_hut
		from mountain_huts h1
		join trails t1 on t1.hut1 = h1.id),
	cte_trails2 as
		(select t2.*,h2.name as end_hut_name, h2.altitude as end_hut_altitude,
		case when start_hut_altitude > h2.altitude then 1 else 0 end as altitude_flag
		from cte_trails1 t2
		join mountain_huts h2 on h2.id = t2.end_hut),
	cte_final as	
		(select case when altitude_flag = 1 then start_hut else end_hut end as start_hut,
		case when altitude_flag = 1 then start_hut_name else end_hut_name end as start_hut_name
		,case when altitude_flag = 1 then end_hut else start_hut end as end_hut
		,case when altitude_flag = 1 then end_hut_name else start_hut_name end as end_hut_name
		from cte_trails2)
select c1.start_hut_name as startpt,
c1.end_hut_name as middlept,
c2.end_hut_name as endpt
from cte_final c1
join cte_final c2 on c1.end_hut = c2.start_hut














