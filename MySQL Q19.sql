-- Given table showcases details of pizza delivery order for the year of 2023.
-- If an order is delayed then the whole order is given for free. Any order that takes 30 minutes more than the expected time is considered as delayed order. 
-- Identify the percentage of delayed order for each month and also display the total no of free pizzas given each month.


DROP TABLE IF EXISTS pizza_delivery;
CREATE TABLE pizza_delivery 
(
	order_id 			INT,
	order_time 			TIMESTAMP,
	expected_delivery 	TIMESTAMP,
	actual_delivery 	TIMESTAMP,
	no_of_pizzas 		INT,
	price 				DECIMAL
);


-- Data to this table can be found in CSV File

select * from pizza_delivery;

select to_char(order_time, 'Mon-YYYY') as period
, concat(round((cast(sum(case when extract(hour from (actual_delivery - order_time))*60 
			+ extract(minute from (actual_delivery - order_time)) 
			> 30 then 1 else 0 end)	as decimal) / count(1))*100,1),'%')  delayed_flag	
, sum(case when extract(hour from (actual_delivery - order_time))*60 
			+ extract(minute from (actual_delivery - order_time)) 
			> 30 then no_of_pizzas else 0 end)	 as free_pizzas		
from pizza_delivery
where actual_delivery is not null
group by to_char(order_time, 'Mon-YYYY')
order by extract(month from to_date(to_char(order_time, 'Mon-YYYY'),'Mon-YYYY'));
