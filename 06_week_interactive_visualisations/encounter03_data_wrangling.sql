/*
WEEK 06
Encounter 03 - Data Wrangling
Project Challenge - SQL Challenges

Once the data is in the database you can start exploring it!
*/

-- Task 1
-- How many records are there in the temperature data?

select count(*) from mean_temperature mt ; -- 112_851_879


-- Task 2
-- Get a list of all countries included. Remove all duplicates and sort it alphabetically.

select distinct cn
	from stations s 
	--where hght <> -9999 -- gives the same result
	order by cn;

/*
-- missed stations data
select *
	from stations
	where hght = -9999;
*/

-- Task 2 - with country names
select distinct c.name --s.cn
	from stations s
		join countries c 
		on s.cn = c.alpha2
	--where hght <> -9999 -- the same result
	order by c.name;


-- Task 3
-- Get the number of weather stations for each country. Group by the number of stations in descending order!

select s.cn, count(1) as number_of_stations
from stations s
--where hght <> -9999 -- Results: -5 stations in 'NO'
group by s.cn
order by number_of_stations desc;

-- the same but with country name
select c.name as country_name, 
       count(1) as number_of_stations
	from stations s
		join countries c 
		on c.alpha2 = s.cn 
	--where s.hght <> -9999 -- Results: -5 stations in 'NO'
group by country_name
order by number_of_stations desc;


select * from countries where name in ('Switzerland', 'Netherlands'); -- 'CH' and 'NL'

-- Task 4
-- What’s the average height of stations in Switzerland compared to Netherlands?

select cn, 
       avg(hght) as average_height_of_stations
	from stations s
	where (cn = 'CH' or cn = 'NL')
	  --and hght <> -9999 -- returns the same results
group by cn;

-- proportions
select cn,
	   average_height_of_stations/ sum(average_height_of_stations) over() as proportion
from (select cn, 
       		 avg(hght) as average_height_of_stations
		from stations s
		where cn in ('CH', 'NL') --and hght <> -9999 -- returns the same results
		group by cn) as avgs;
	
-- the same (proportions), but with country names
select country_name,
	   round(average_height_of_stations/ sum(average_height_of_stations) over(), 2) as proportion
from (select c.name as country_name, 
       		 avg(hght) as average_height_of_stations
		from stations s
			join countries c 
			on c.alpha2 = s.cn 
		where cn in ('CH', 'NL') --and hght <> -9999 -- returns the same results
		group by country_name) as avgs;
	
/* RETURNS:
 * country_name  proportion
 * -----------------------------------
 * Switzerland	 0.98
 * Netherlands	 0.02
 */


-- Task 5
-- What is the highest station in Germany?

select staname
from stations s 
where cn='DE'
order by hght desc
limit 1;

-- the same, but universal solution:
-- could return all station names (if there are a few) with maximum height
select staname
from (select staname,
	   		 rank() over (order by hght desc) as hght_rank
		from stations s 
		where cn='DE') as ranked_german_station_heights
where hght_rank = 1
order by staname;


-- Task 6
-- What’s the minimum and maximum daily average temperature ever recorded in Germany?

select min(tg) as min_avg_temperature_c_grad,
	   max(tg) as max_avg_temperature_c_grad
	from mean_temperature mt 
		inner join stations s 
		using(staid)
	where cn='DE';

/*
 * min_avg_temperature_c_grad	max_avg_temperature_c_grad
 * -33.1						32.4
 */

select min(tg) as min_avg_temperature,
	   max(tg) as max_avg_temperature
	from mean_temperature mt;

/*
 * min_avg_temperature	max_avg_temperature
 * -661					564
 */
 