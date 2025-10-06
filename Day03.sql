-- problem_statement: This is a customer_data_set where company has started newly and has to track the user count weather they are new or revisited by date 

create table customer_orders (
order_id integer,
customer_id integer,
order_date date,
order_amount integer
);

insert into customer_orders values(1,100,cast('2022-01-01' as date),2000),(2,200,cast('2022-01-01' as date),2500),(3,300,cast('2022-01-01' as date),2100)
,(4,100,cast('2022-01-02' as date),2000),(5,400,cast('2022-01-02' as date),2200),(6,500,cast('2022-01-02' as date),2700)
,(7,100,cast('2022-01-03' as date),3000),(8,400,cast('2022-01-03' as date),1000),(9,600,cast('2022-01-03' as date),3000);


select * from customer_orders;

SELECT customer_id, min(order_date) as first_visit_date from customer_orders 
GROUP BY customer_id;

WITH first_visit AS (
SELECT customer_id, min(order_date) AS first_visit_date 
FROM customer_orders 
GROUP BY customer_id
),
agg_visit AS (
SELECT co.* , fv.first_visit_date,
CASE WHEN co.order_date = fv.first_visit_date THEN 1 ELSE 0 END AS first_cust_flag,
CASE WHEN co.order_date != fv.first_visit_date THEN 1 ELSE 0 END AS repeat_cust_flag
FROM customer_orders co INNER JOIN first_visit fv ON co.customer_id = fv.customer_id 
)
select order_date , sum(first_cust_flag) as new_customers , sum(repeat_cust_flag)as repeat_customers from agg_visit GROUP BY order_date;
