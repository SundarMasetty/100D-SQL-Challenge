create table entries ( 
name varchar(20),
address varchar(20),
email varchar(20),
floor int,
resources varchar(10));

insert into entries 
values ('A','Bangalore','A@gmail.com',1,'CPU'),('A','Bangalore','A1@gmail.com',1,'CPU'),('A','Bangalore','A2@gmail.com',2,'DESKTOP')
,('B','Bangalore','B@gmail.com',2,'DESKTOP'),('B','Bangalore','B1@gmail.com',2,'DESKTOP'),('B','Bangalore','B2@gmail.com',1,'MONITOR');

select * from entries;

--select name , count(*) as total_visits from entries  group by name;

--Problem_statement: we  have users who are accessing the company building floor (same person with different mail id) we have to find most_visited_floor and their overall total number of visits
-- And what resources thay have used 

--approach 
-- first find the most visited floor using rank function 
-- second find the no of visits seperately and then join using cte's 
-- for resources used we need to find out the distinct resources with one cte and then we need to used string_agg() to group the resources 

WITH mvf as (
SELECT name ,floor, count(1) AS no_of_visits , rank() over (PARTITION BY name ORDER BY count(1) DESC) as rn
FROM  entries
GROUP BY name , floor 
)
,
tv as (
    select name , count(*) as total_visits from entries  group by name

)
,
dr as (
    SELECT distinct  name ,  resources from entries 
),
unique_resources as (
    SELECT name , STRING_AGG(resources,',') as resources_used  from dr group by name
)

SELECT mvf.name,mvf.floor as most_visited_floor , tv.total_visits, unique_resources.resources_used from mvf
INNER JOIN tv ON mvf.name = tv.name
INNER JOIN unique_resources ON unique_resources.name = mvf.name
where rn = 1; 

