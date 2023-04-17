/* Week 05 - Databases
   Encounter 06 - Aggregating Data with sql
   Project Challenge
*/


-- 1. How many ratings are available in the dataset?
--    Display the total row count of the ratings table.
select count(user_id) as total  -- 10_818
	from ratings;

-- 2. What is the distribution of genres combinations?
-- Display the total count of different genres combinations in the movies table.
select count(distinct genres) as total  -- 951 -- successfully tested also with group by
	from movies;

-- 3. Have you already explored the tags table? What unique tags can you see for a selected movie?
--    Display unique tags for movie with id equal 60756. Use tags table.
select distinct tag -- ('comedy', 'funny', 'Highly quotable', 'will ferrell')
	from tags t 
	where movie_id = 60756;

-- 4. How many movies from different years do we have in the dataset? Focus only on given time period.
--    Display the count of movies in the years 1990-2000 using the movies table. Display year and movie_count.
select count(movie_id) as qty -- 2_495
	from movies m 
	where movie_year between 1990 and 2000;

-- 5. Which year had the highest number of movies in the dataset?
--    Display the year where most of the movies u=in the database are from.
select movie_year, count(1)
	from movies m 
	group by movie_year
	order by count(1) desc
	limit 1;

-- V2 (universal solution if we could have a few years with the same maximum films amount)
-- copied from encounter 5 Project Challenge 'Extra' section
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

-- 6. One of the metrics that could be used to measure the popularity of the movies is the total count of ratings 
--    (the number of people who rated a movie). What are the most popular movies if we use this metric?
--    Display 10 movies with the most ratings. Use ratings table. Display movieid, count_movie_ratings.
select movie_id
     , count(rating) as count_movie_ratings
	from ratings
	group by movie_id
	order by count_movie_ratings desc
	limit 10;

-- 7. Another metric that we could use to measure the popularity of the movies is the average rating. 
--    However, to ensure the quality of this information we need to have at least a given number of ratings. 
--    What are the most popular movies using this metric?

--    Display the top 10 highest rated movies by average that have at least 50 ratings.
--    Display the movieid, average rating and rating count. Use the ratings table.
select movie_id
     , avg(rating) as avg_movie_ratings
     , count(rating) as count_movie_ratings
	from ratings
	group by movie_id
	having count(rating) >=50
	order by avg_movie_ratings desc
	limit 10;

-- 8. Imagine that you would like to continue focusing on the drama movies only. 
--    As you have multiple questions about drama movies you decided to create a view 
--    representing drama movies that you could reuse later on.

--    Create a view that is a table of only movies that contain drama as one of it’s genres.
create or replace view drama_movies as
	select *
		from movies m 
		where genres ilike '%drama%';

--    Display the first 10 movies in the view.
select * 
	from drama_movies
	limit 100;