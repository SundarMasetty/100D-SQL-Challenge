--write a query which should give the date after 3 weeks 

declare @today_date date;
declare @n int;
set @today_date = '2022-01-01'; -- saturday
set @n = 3;




SELECT DATEADD(week,@n-1,DATEADD(DAY,8-DATEPART(day,@today_date),@today_date)) as Next_week_date
