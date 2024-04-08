drop TABLE if exists orders;
CREATE TABLE orders 
(
	customer_id 	INT,
	dates 			DATE,
	product_id 		INT
);
INSERT INTO orders VALUES
(1, '2024-02-18', 101),
(1, '2024-02-18', 102),
(1, '2024-02-19', 101),
(1, '2024-02-19', 103),
(2, '2024-02-18', 104),
(2, '2024-02-18', 105),
(2, '2024-02-19', 101),
(2, '2024-02-19', 106); 


select * from orders;


select dates, product_id
from orders
where customer_id=1 and dates='2024-02-18';


select dates,string_agg(cast(product_id as varchar),',') as products
from orders
where customer_id=1 and dates='2024-02-18'
group by customer_id,dates


select dates, cast(product_id as varchar) as products
from orders
-- where customer_id=1 and dates='2024-02-18'
union
select dates,string_agg(cast(product_id as varchar),',') as products
from orders
-- where customer_id=1 and dates='2024-02-18'
group by customer_id,dates


select dates, cast(product_id as varchar) as products
from orders
union
select dates,string_agg(cast(product_id as varchar),',') as products
from orders
group by customer_id,dates
order by dates, products






