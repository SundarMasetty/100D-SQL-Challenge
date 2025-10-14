create table emp_compensation (
emp_id int,
salary_component_type varchar(20),
val int
);

insert into emp_compensation
values (1,'salary',10000),(1,'bonus',5000),(1,'hike_percent',10)
, (2,'salary',15000),(2,'bonus',7000),(2,'hike_percent',8)
, (3,'salary',12000),(3,'bonus',6000),(3,'hike_percent',7);

select * from emp_compensation;

--Problem statement we need to make the emp_compensation table where we have different salary_component we need to create each columnn from it,t-2 and aswell create the emp_compensation table again

SELECT emp_id , 
SUM(CASE WHEN  salary_component_type = 'salary' THEN val END) AS salary, -- When we use just the case statement we get the salary , null ,null and bonus , null , null so at atlast we need to group them together by emp_id to achieve it.
SUM(CASE WHEN  salary_component_type = 'bonus' THEN val END) AS bonus,
SUM(CASE WHEN  salary_component_type = 'hike_percent' THEN val END )AS hike_percent
INTO emp_pivot_table
FROM emp_compensation
GROUP BY emp_id

SELECT * FROM emp_pivot_table;

SELECT emp_id , 'salary' AS salary_component_type, salary as 'val' FROM  emp_pivot_table
UNION -- we run this query for bonus and hikepercent then can perfom union
SELECT emp_id, 'bonus' AS salary_component_type, bonus as 'val' FROM emp_pivot_table
UNION
SELECT emp_id, 'hike_percent' AS salary_component_type, hike_percent as 'val' FROM emp_pivot_table