drop table if exists hotel_ratings;
create table hotel_ratings
(
	hotel 		varchar(30),
	year		int,
	rating 		decimal
);
insert into hotel_ratings values('Radisson Blu', 2020, 4.8);
insert into hotel_ratings values('Radisson Blu', 2021, 3.5);
insert into hotel_ratings values('Radisson Blu', 2022, 3.2);
insert into hotel_ratings values('Radisson Blu', 2023, 3.8);
insert into hotel_ratings values('InterContinental', 2020, 4.2);
insert into hotel_ratings values('InterContinental', 2021, 4.5);
insert into hotel_ratings values('InterContinental', 2022, 1.5);
insert into hotel_ratings values('InterContinental', 2023, 3.8);

select * from hotel_ratings;

with cte as
		(select *, round(avg(rating) over(partition by hotel order by year
									range between unbounded preceding and unbounded following)	
					 ,2) as avg_rating
		from hotel_ratings),
	cte_rnk as	
		(select *
		,abs(rating - avg_rating)
		,rank()over(partition by hotel order by abs(rating - avg_rating)desc)as rnk
		from cte)
select hotel,year, rating
from cte_rnk
where rnk>1
order by hotel desc, year














