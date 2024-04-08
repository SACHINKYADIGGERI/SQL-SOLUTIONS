drop table if exists Day_Indicator;
create table Day_Indicator
(
	Product_ID 		varchar(10),	
	Day_Indicator 	varchar(7),
	Dates			date
);
insert into Day_Indicator values ('AP755', '1010101', to_date('04-Mar-2024','dd-mon-yyyy'));
insert into Day_Indicator values ('AP755', '1010101', to_date('05-Mar-2024','dd-mon-yyyy'));
insert into Day_Indicator values ('AP755', '1010101', to_date('06-Mar-2024','dd-mon-yyyy'));
insert into Day_Indicator values ('AP755', '1010101', to_date('07-Mar-2024','dd-mon-yyyy'));
insert into Day_Indicator values ('AP755', '1010101', to_date('08-Mar-2024','dd-mon-yyyy'));
insert into Day_Indicator values ('AP755', '1010101', to_date('09-Mar-2024','dd-mon-yyyy'));
insert into Day_Indicator values ('AP755', '1010101', to_date('10-Mar-2024','dd-mon-yyyy'));
insert into Day_Indicator values ('XQ802', '1000110', to_date('04-Mar-2024','dd-mon-yyyy'));
insert into Day_Indicator values ('XQ802', '1000110', to_date('05-Mar-2024','dd-mon-yyyy'));
insert into Day_Indicator values ('XQ802', '1000110', to_date('06-Mar-2024','dd-mon-yyyy'));
insert into Day_Indicator values ('XQ802', '1000110', to_date('07-Mar-2024','dd-mon-yyyy'));
insert into Day_Indicator values ('XQ802', '1000110', to_date('08-Mar-2024','dd-mon-yyyy'));
insert into Day_Indicator values ('XQ802', '1000110', to_date('09-Mar-2024','dd-mon-yyyy'));
insert into Day_Indicator values ('XQ802', '1000110', to_date('10-Mar-2024','dd-mon-yyyy'));

select * from Day_Indicator;


select *,extract('isodow' from dates) as dow
from Day_Indicator
where product_id='AP755'


select *,extract('isodow' from dates) as dow,
case when substring(day_indicator,1,1) ='1' then 1 else 0 end as flag
from Day_Indicator
where product_id='AP755'



select *,extract('isodow' from dates) as dow,
case when substring(day_indicator,extract('isodow' from dates)::int,1) ='1' then 1 else 0 end as flag
from Day_Indicator
where product_id='AP755'


select product_id, day_indicator, dates
from(
	select *,extract('isodow' from dates) as dow,
	case when substring(day_indicator,extract('isodow' from dates)::int,1) ='1' then 1 else 0 end as flag
	from Day_Indicator
	where product_id='AP755') x
where flag =1;



select product_id, day_indicator, dates
from(
	select *,extract('isodow' from dates) as dow,
	case when substring(day_indicator,extract('isodow' from dates)::int,1) ='1' then 1 else 0 end as flag
	from Day_Indicator) x
where flag =1;









