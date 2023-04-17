/*  PART 1 - POPULARITY BY AVERAGE RATINGS (DATES are RATING_TIMESTAMP) */


-- 1. ratings interval
select min(to_timestamp(rating_timestamp)) as min_rating_date
     , max(to_timestamp(rating_timestamp)) as max_rating_date
	from ratings m;

/*
 * 1996-03-29 19:36:55.000 +0100	2018-09-24 16:27:30.000 +0200
 */

-- genres and movie_year for 'Doctor Strange' movie :)
select * from movies m where title ilike '%Doctor Strange%';
/*
 * movie_id = 122922
 * title = 'Doctor Strange '
 * genres = 'Action|Adventure|Sci-Fi'
 * movie_year =	2016
 */


-- 2. get all movies for this interval
drop table if exists genres_popularity_by_films_qty;

create table genres_popularity_by_films_qty as ( -- 115 rows
with cte as (
select m.movie_id, m.title, m.movie_year, g.genre
	from movies m 
		join genres g 
		on m.movie_id = g.movie_id 
	where movie_year between 1996 and 2018
		and genre in ('Adventure', 'Action', 'Drama', 'Horror', 'Sci-Fi')
	order by m.movie_year, m.movie_id, m.title, g.genre
)
select movie_year, genre, count(movie_id) as movies_qty_pro_year
--select count(distinct movie_year) -- 23 years
	from cte
	group by movie_year, genre
	order by movie_year, genre
);

select * from genres_popularity_by_films_qty limit 10;

-- saving view results as csv file
/*
DOESN'T WORKK FOR SOME REASON: 

ERROR: 
eclipse.buildId=unknown
java.version=17.0.5
java.vendor=Eclipse Adoptium
BootLoader constants: OS=win32, ARCH=x86_64, WS=win32, NL=en
Command-line arguments:  -os win32 -ws win32 -arch x86_64

org.jkiss.dbeaver.model
Error
Fri Feb 10 11:14:57 CET 2023
SQL Error [42601]: ERROR: syntax error at or near "\"
  Position: 1
*/

-- \COPY (SELECT * FROM genres_popularity_by_films_qty) TO 'genres_popularity_by_films_qty.csv'  WITH DELIMITER ',' CSV HEADER;

-- \COPY genres_popularity_by_films_qty TO 'genres_popularity_by_films_qty.csv'  WITH DELIMITER ',' CSV HEADER;

-- \copy genres_popularity_by_films_qty to 'genres_popularity_by_films_qty.csv'  with delimiter ',' csv header;



-------------------------------------------------------------

/*  PART 2 - POPULARITY BY AVERAGE RATINGS (DATES are RATING_TIMESTAMP) */


drop table if exists genres_popularity_by_avg_rating;

create table genres_popularity_by_avg_rating as ( -- 115 rows
with cte2 as(
select g.movie_id 
     , g.genre 
     , r.rating
     , to_timestamp(rating_timestamp) as rating_date
     , date_part('YEAR',to_timestamp(rating_timestamp)) as rating_year
	from genres g
		join ratings r 
		on g.movie_id = r.movie_id
	where genre in ('Adventure', 'Action', 'Drama', 'Horror', 'Sci-Fi')
)
select rating_year
     , genre
     , avg(rating) as average_rating
     , count(rating) as ratings_qty
	from cte2
	group by rating_year, genre
	order by rating_year, genre
);

select * from genres_popularity_by_avg_rating limit 50;

	
--\COPY genres_popularity_by_avg_rating TO 'genres_popularity_by_avg_rating.csv'  WITH DELIMITER ',' CSV HEADER;


