/*
WEEK 06
Encounter 07 - SQL Window Functions
Project Challenge (optional)
*/

/*  PART 1

    Create a query which returns the yearly_mean_temperature table with an average_temp_all_time column.

    TIP: The column can be created using a window function that partitions over the station ids.
*/

select staid,
	   year,
	   yearly_temp,
	   avg(yearly_temp) over(partition by staid) as average_temp_all_time
	from yearly_mean_temperature;

/* PART 2

   
    What are the rankings of the yearly average temperatures for each of the stations? 
    Using yearly_mean_temperature create a query to add a ranking per year 
    partitioned by the station and ordered by the avg_temp

    TIP: The column can be created using a window function that partitions over the station ids 
         and ranks absed on the temperature.
 */

select staid,
	   year,
	   yearly_temp,
	   rank() over(partition by staid order by yarly_temp) as average_temp_all_time
	from yearly_mean_temperature;


/* PART 3 (BONUS)

    For every mean measurement we want to know what is the difference in the measured temperature 
    compared to the previous measurement. 
    Using mean_temperature and stations create a query which results in a table with staid, date, 
    temp (tg/10), staname, cn and a column with the day over day temperature difference for one station.

    Requires: window function, JOIN, and WHERE
*/

select mt.staid, 
	   mt.date,
	   (mt.tg/10) as temp,
	   s.staname,
	   s.cn,
	   --LAG(mt.tg/10) over (partition by mt.staid order by mt.date) as temp_for_prev_day,
	   (mt.tg/10) - LAG(mt.tg/10) over (partition by mt.staid order by mt.date) as day_over_day_temp_diff -- for one station
	from mean_temperature mt
		join stations s 
		on s.staid = mt.staid
	where s.staname ilike '%minsk%';


/* PART 4 (BONUS)

    Investigate global warming patterns by creating a query that will return staid, year, 
    avg_temp as yearly_avg, staname, cn, the all time average per station, and the average of each station 
    up until the current row’s year.

    Then you can compare the average over time and see if it increases, stays the same or decreases. 
    It can also then be compared to the all time average and each year’s average temperature.

    Requires: window functions, ROWS, and JOIN statements
*/

-- temperatures are converted to celcius
select mt.staid, 
	   mt.year,
	   (mt.yearly_temp/10) as yearly_temp,
	   s.staname,
	   s.cn,
	   avg(mt.yearly_temp/10) over(partition by mt.staid) as average_temp_all_time,
	   avg(mt.yearly_temp/10) over(partition by  mt.staid
	   							   order by mt.year
	   							   rows unbounded preceding) as avg_station_temp_till_curr_year
    from yearly_mean_temperature mt
		join stations s 
		on s.staid = mt.staid
	order by mt.staid, mt.year;
