/* Week 05 - Databases
   Encounter 06 - Aggregating Data with sql
   Project Challenge - SQL explanatory data analysis questions
*/


-- 1. Display the (whole) movies table.
select * 
	from movies;
    
-- 2. Display only title and genres of the first 10 entries from the movies table 
--    that is sorted alphabetically (starting from A) by the movie titles.
select title, genres
	from movies
	order by title asc 
	limit 10;

-- 3. How many movies do we have the data for?
--    Display the total row count
select count(*) as qty   -- 9_729
	from movies;

-- 4. Every movie has a genre assign to it. Maybe you have noticed that some of the movies has a few different genres assigned to them. Let’s pick one of the genres - e.g. drama - and check how many movies we have that were classified as this genre only.
--    Display first 10 pure Drama movies. Only Drama is in the genre column.
select *
	from movies
	where genres = 'Drama'
	limit 10;

-- Display the count of pure Drama movies.
select count(*) as pure_drama_movies_qty
	from movies
	where genres = 'Drama';


-- 5. Some of the movies are classified as a combination of a few genres. 
--    Check how many movies have drama as one of the assigned genres.
--    Display the count of drama movies that can also contain other genres.
select count(*) as any_drama_movies_qty   -- 4_359
	from movies
	where genres ilike '%drama%';

-- excluding pure Drama movies
select count(*) as combined_genres_drama_movies_qty   -- 3_307
	from movies
	where genres ilike '%drama%' and genres not ilike 'drama';


-- 6. What is the count of movies that are not classified as drama movies?
--    Display the count of movies don’t have drama (in any combination) as assigned genre
select count(*) as no_drama_movies_qty   -- 5_370
	from movies
	where genres not ilike '%drama%';

-- 7. What is the year distribution of the movies? 
--    Display the count of movies that were released in 2003.
select count(*) as movies_2003_qty   -- 279
	from movies
	where movie_year = 2003;

-- Do you have a favorite film? Which year is it from?
select movie_year -- 2016
	from movies
	where title ilike '%Doctor Strange%';

-- How many movies from this year are visible in the movies dataset?
select count(movie_year) as movies_qty_for_the_same_year -- 218
	from movies
	where movie_year = (select movie_year 
							from movies
							where title ilike '%Doctor Strange%');

						
-- 8. What is the year distribution of the movies? Do we have more movies from recent years? Do we have any movies from earlier years?
--    Find all movies with a year lower 1910.
select *
	from movies m 
	where movie_year < 1910;

-- 9. Have you ever watched Star Wars? Or is there a different series of movies that you loved. Let’s see which of these movies are in the dataset.
--    Retrieve all Star Wars movies from the movie table.
select * 
	from movies m 
	where title ilike '%star wars%';
	
-------------------------------------------------------------

-- EXTRA for #8
-- What is the year distribution of the movies? 
-- Do we have more movies from recent years?

-- for how many unique years do we have films?
select count(distinct movie_year) as number_of_years -- 106
	from movies m;

-- distribution (films quantity) over the years in descending order
select movie_year, count(movie_id) as films_qty_pro_year
	from movies m 
	group by movie_year
	order by movie_year desc;

-- for which year we have the maximum number of films?
WITH movies_qty_pro_years AS (
    select movie_year
         , count(movie_id) as films_qty_pro_year
         , rank() over (order by count(movie_id) desc) as rnk
	from movies m 
	group by movie_year
)
select movie_year, films_qty_pro_year
	from movies_qty_pro_years
	where rnk = 1;



select films_qty_pro_year, movie_year
	from movies_qty_pro_years
	order by films_qty_pro_year desc 
	limit 1;




