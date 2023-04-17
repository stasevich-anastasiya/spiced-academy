/*
WEEK 06
Encounter 04 - Advanced SQL Queries
Project Challenge - Solve with SQL
*/

/*  PART 1

    Create a derived table called yearly_mean_temperature that contains 
    the yearly temperature averages for all weather stations from the mean_temperature table. 
    It should contain staid, yearly_temp and year as columns.
*/

drop table if exists yearly_mean_temperature;

create table yearly_mean_temperature as
select staid,
	   date_part('year', date) as year,
	   avg(tg) as yearly_temp
	from mean_temperature mt 
	group by staid, year
	order by staid, year;

-- displaying the details for new table
select * from yearly_mean_temperature limit 50;
select count(*) from yearly_mean_temperature; -- 321_971 records
select sum(yearly_temp) as checksum from yearly_mean_temperature; -- 19_371_303.93456094613447124023


/*  PART 2

    Bucketize tg values in the mean_temperature table. 
    Use CASE to to return a column that will hold the value hot when the temperature 
    is above 25 degrees, normal when between 10 and 25 and cold when under 10.
*/

/*
 -- Query to get bucket values in SELECT statement:
 select case when tg > 25*10 then 'hot'
			when tg between 10*10 and 25*10 then 'normal'
			when tg < 10*10 then 'cold'
	   end as backet,
	   tg
	from mean_temperature mt ;
 */


-- adding new column to 'mean_temperature' table
alter table mean_temperature
	add temp_backet varchar(10);

-- calculating temperature buckets and writing these values into 'temp_backet' column
UPDATE mean_temperature 
SET temp_backet = case when tg > 25*10 then 'hot'
						when tg between 10*10 and 25*10 then 'normal'
						when tg < 10*10 then 'cold'
	   			   end;

-- displaying te results
select * from mean_temperature limit 50;


/*  PART 3
 
    Using GROUP BY and a subquery show the yearly average of the maximum temperatures 
    of all stations in the mean_temperature table.
*/

drop table if exists yearly_avg_max_temps;

create table yearly_avg_max_temps as
select year,
	   avg(max_station_temp) as avg_max_temp -- yearly_avg_max_temp
	from (select staid,
				 date_part('year', date) as year,
				 max(tg) as max_station_temp
			from mean_temperature
			group by year, staid
			order by year, staid ) as max_temps
	group by year
	order by year;

select * from yearly_avg_max_temps; -- 267 recordc in total
	

/*  Bonus:

    Create other derived tables that might be of interest.
*/


-- TABLE #1
-- see yearly_avg_max_temps table above :)


-- TABLE #2
-- yearly_mean_temperature table data
-- but also with number of stations per country per year with country name

drop table if exists yearly_mean_temperature_upd;

create table yearly_mean_temperature_upd as
select c.name as country_name,
	   c.alpha3 as country_iso3,
	   s.staname as station_name,
	   mt.year,
	   round(mt.yearly_temp/10, 1) as yearly_temp_in_grad
			from yearly_mean_temperature mt
				join stations s
				on mt.staid = s.staid
				join countries c
				on s.cn = c.alpha2
	order by year, country_name;

-- number of records in my new table
select count(*) from yearly_mean_temperature_upd; -- 321_971 (correct)

select * from yearly_mean_temperature_upd limit 20;


-- TABLE #3
-- number of stations per country per year with country name
drop table if exists number_of_stations_per_country;

create table number_of_stations_per_country as
select c.name as country_name,
	   c.alpha3 as country_iso3,
	   date_part('year', mt.date) as year,
	   count(distinct mt.staid) as stations_qty
			from mean_temperature mt
				join stations s
				on mt.staid = s.staid
				join countries c
				on s.cn = c.alpha2
			group by year, country_name, country_iso3
			order by year, country_name, country_iso3;

-- number of records in my new table
select count(*) from number_of_stations_per_country; -- 6_024


select * from stations;

-- displaying the data in the table
select * from number_of_stations_per_country limit 10;

-- save the table as csv file
-- Error occurs: SQL Error [42601]: ERROR: syntax error at or near "\" Position: 32
-- Reason: 'Syntax Error or Access Rule Violation.'
-- \COPY number_of_stations_per_country TO 'number_of_stations_per_country.csv'  WITH DELIMITER ',' CSV HEADER;


-- TABLE #4 (used in Weekly Project)
-- weather stations over the years with lat+lon as separate values
-- it is the easiest way to get coordinates ready for ploting
      
drop table if exists stations_lat_lon;

create table stations_lat_lon as
select trim(s.staname) as station_name,
	   trim(c.name) as country_name,
	   trim(c.alpha3) as country_iso3,
	   (split_part(s.lat, ':', 1)::numeric 
	   + split_part(s.lat, ':', 2)::numeric/60 
	   + split_part(s.lat, ':', 3)::numeric/(60*60)
	   ) as lat_formated,
	   (split_part(s.lon, ':', 1)::numeric 
	   + split_part(s.lon, ':', 2)::numeric/60 
	   + split_part(s.lon, ':', 3)::numeric/(60*60)
	   ) as lon_formated,
	   s.coordinates
	from stations s
		join countries c
		on s.cn = c.alpha2
	order by country_name, station_name;

-- number of records in my new table
select count(*) from stations_lat_lon; -- 6_024

-- displaying the data in the table
select * from stations_lat_lon limit 10;


---------------------------------------------------------------------------
---------------------------------------------------------------------------

/* Reference information */

-- counting number of rows in other derived tables to export data into csv-files
select count(*) from yearly_avg_max_temps; -- 267
select count(*) from yearly_mean_temperature; -- 312_971


-- checking date values in mean_temperature table:
select min(date), -- 1756-01-01
	   max(date)  -- 2022-06-30
	from mean_temperature;

