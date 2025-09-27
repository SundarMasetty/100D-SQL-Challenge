create table emp(emp_id int,emp_name varchar(10),salary int ,manager_id int);

insert into emp values(1,'Ankit',10000,4);
insert into emp values(2,'Mohit',15000,5);
insert into emp values(3,'Vikas',10000,4);
insert into emp values(4,'Rohit',5000,2);
insert into emp values(5,'Mudit',12000,6);
insert into emp values(6,'Agam',12000,2);
insert into emp values(7,'Sanjay',9000,2);
insert into emp values(8,'Ashish',5000,2);


-- We need to find out the employees who are earning more than their managers
-- So here we have information on manager_id and emp_id in the same table so to map with employees 
--Here we will use the self join with the condition so we can achieve it.
select * from emp;

SELECT * FROM emp e 
inner join
emp m 
on
e.manager_id = m.emp_id;


SELECT e.emp_id, e.emp_name, m.emp_name as manager_name , e.salary , m.salary as manager_salary 
FROM emp e 
inner join
emp m 
on
e.manager_id = m.emp_id
WHERE e.salary > m.salary;
