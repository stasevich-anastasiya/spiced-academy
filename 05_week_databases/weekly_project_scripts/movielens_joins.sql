/*
Encounter 08 - sql Joins
Project Challenge
*/

/*
1. Imdb is one of the movie platforms which has its own movies database where movies also have their own ids. 
   Find 5 movie titles from our database with the lowest imdb ids (the movies that were added at first to the platform).

   Using a JOIN display 5 movie titles with the lowest imdb ids
 */
select m.title, l.imdb_id 
	from movies m 
		full join links l 
		on m.movie_id = l.movie_id 
	order by l.imdb_id -- asc 
	limit 5;

/*
2. As we have created the genres table before, we want to modify the query asking about the count of drama movies.

   Display the count of drama movies
*/

select count(m.movie_id) as drama_moview_qty -- 4_359
	from movies m 
		join genres g 
		on m.movie_id = g.movie_id
	where g.genre = 'Drama';


/*
3. One of the ways to describe the movies is to assign the genres to them. 
   Besides genres, there is also tags information available for us. 
   Find out all the movies that are matching a defined tag (e.g. ‘fun’).

   Using a JOIN display all of the movie titles that have the tag fun
*/

-- checking the options
select count(*) 
	from tags t 
	--where tag = 'fun'; -- 5 			-- tag contains only 'fun'
	where tag ilike '%fun%'; -- 35      -- tag contains 'fun' as substring inside 'tag' value
	
-- all of the movie titles that have the tag fun (in any combination)
select distinct m.title -- 30 unique movie titles
	from movies m 
		join tags t 
		on m.movie_id = t.movie_id
	where tag ilike '%fun%'
	order by m.title;
		
/*
4. Not all the movies where marked with a tag by the users. Find the first movie without any tags in the database.

   Using a JOIN find out which movie title is the first without a tag
*/

select m.title -- 8_158 in total; 1st is 'Waiting to Exhale'
	from movies m 
		left join tags t 
		on m.movie_id = t.movie_id
	where t.movie_id is null
	limit 1;
	
/*
5. Which genres are the most liked ones? 
   Calculate average rating for all the genres and show the 3 highest rated ones. 
   (Tip: Join the genres and the rating table.)

Using a JOIN display the top 3 genres and their average rating
*/

select g.genre, avg(r.rating) as average_genre_rating
	from genres g 
		join ratings r 
		on g.movie_id = r.movie_id 
	group by g.genre
	order by avg(r.rating) desc
	limit 3;
	
/* RESULTS:
Film-Noir	3.9
War			3.8
Documentary	3.8
*/

/*
6. Let’s assume that number of ratings is proportional to the number of people who watched a film. 
   Which movies where watched by the biggest group of people?

   Using a JOIN display the top 10 movie titles by the number of ratings
*/

select m.title, count(r.rating) as number_of_ratings
	from movies m
		join ratings r 
		on m.movie_id = r.movie_id
	group by m.movie_id, m.title
	order by number_of_ratings desc 
	limit 10;

/*
7. If you have seen Star Wars, do you have your favorite Star Wars movie? 
   Compare your verdict with the ratings from the dataset.

   Using a JOIN display all of the Star Wars movies in order of average rating where the film was rated by at least 40 users
*/	

select m.title, avg(r.rating) as average_movie_rating
	from movies m 
		join ratings r 
		on m.movie_id = r.movie_id
	where m.title ilike '%star wars%'
	group by m.movie_id, m.title
	having count(r.rating) >=40
	order by average_movie_rating desc;

/* RESULTS:
Star Wars: Episode IV - A New Hope 				4.23
Star Wars: Episode V - The Empire Strikes Back 	4.22
Star Wars: Episode VI - Return of the Jedi 		4.14
Star Wars: Episode VII - The Force Awakens 		3.85
Star Wars: Episode III - Revenge of the Sith 	3.43
Star Wars: Episode II - Attack of the Clones 	3.16
Star Wars: Episode I - The Phantom Menace 		3.17
*/

/*
8. Imagine that you will need to reuse the results of one of the queries above. Save the results in the derived table.

   Create a derived table from one or more of the above queries
*/

-- table for # 5
-- all genres and their average rating

drop table if exists genre_ratings;

create table genre_ratings
as (select g.genre, round(avg(r.rating)::numeric,2) as average_genre_rating
		from genres g 
			join ratings r 
			on g.movie_id = r.movie_id 
		group by g.genre
		order by avg(r.rating) desc
);

select * from genre_ratings limit 50;

-- table for # 6
-- Which movies where watched by the biggest group of people?
-- all movie titles by the number of ratings in descending order

drop table if exists most_watched_movies;

create table most_watched_movies
as (select m.movie_id, m.title, count(r.rating) as number_of_ratings
	from movies m
		join ratings r 
		on m.movie_id = r.movie_id
	group by m.movie_id, m.title
	order by number_of_ratings desc
);

select * from most_watched_movies limit 40;

select count(*) from most_watched_movies; -- total number of rows is 9_711 (movies without ratings are not included: 18)

/*
-- films with the same title but different ID

select title
	from most_watched_movies 
	group by title
	having count(movie_id) > 1;
	
Examples: ["Robin Hood", "Alice in Wonderland" , "Mummy, The", "Persuasion", "Friday the 13th", "RoboCop"]

-- the title with the maximum number of unique movie_id
select title, count(movie_id) as films_qty
	from most_watched_movies 
	group by title
	having count(movie_id) > 1
    order by films_qty desc
    limit 10;
   
RESULTS:

TITLE		FILMS QUANTITY
---------------------------
Hamlet 					5
MisГ©rables, Les 		4
Three Musketeers, The 	4
Jane Eyre 				4
Christmas Carol, A 		4
King Solomon's Mines 	3
King Kong 				3
Running Scared 			3
Little Women 			3
Alice in Wonderland 	3

*/

-- table for # 7
-- all movies in order of average rating where the film was rated by at least 40 users

drop table if exists highly_rated_movie_avg_ratings;

create table highly_rated_movie_avg_ratings -- 638 records
as (select m.title, round(avg(r.rating)::numeric,2) as average_movie_rating
		from movies m 
			join ratings r 
			on m.movie_id = r.movie_id
		group by m.movie_id, m.title
		having count(r.rating) >=40
		order by average_movie_rating desc
);

select * from highly_rated_movie_avg_ratings limit 40;

/*
BONUS
 */

-- the movie titles with the number of unique movie_id

drop table if exists remakes;

create table remakes
as (select title, count(movie_id) as films_qty
	from movies 
	group by title
	having count(movie_id) > 1
    order by films_qty desc
);

select * from remakes where films_qty >=4;

/* RESULTS:
 
 TITLE		FILMS QUANTITY
---------------------------
Hamlet 					5
MisГ©rables, Les 		4
Three Musketeers, The 	4
Jane Eyre 				4
Christmas Carol, A 		4

 */
