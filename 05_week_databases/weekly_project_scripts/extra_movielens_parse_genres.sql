----------------------
-- parse genres
----------------------

/* from README.TXT :
  
 Genres are a pipe-separated list, and are selected from the following:

* Action
* Adventure
* Animation
* Children's
* Comedy
* Crime
* Documentary
* Drama
* Fantasy
* Film-Noir
* Horror
* Musical
* Mystery
* Romance
* Sci-Fi
* Thriller
* War
* Western
* (no genres listed)
 
 */

-- genres: how many pure ganres could be in 1 complex genre?
select max(array_length(string_to_array(genres, '|'), 1)) -- 10 (the same)
	from movies;

-- 

-- create view with pure genres as separate boolean columns
-- drop view movies_parsed_genres;
create or replace view movies_parsed_genres as
	select movie_id
	     , title
	     , genres
	     , array_length(string_to_array(genres, '|'), 1) as pure_genres_qty
	     , case 
	     	when position('Adventure' in genres) > 0 then true
	     	else false
	       end as is_adventure
	     , case 
	     	when position('Animation' in genres) > 0 then true
	     	else false
	       end as is_animation
	     , case 
	     	when position('Children' in genres) > 0 then true
	     	else false
	       end as is_children
	     , case 
	     	when position('Comedy' in genres) > 0 then true
	     	else false
	       end as is_comedy
 	     , case 
	     	when position('Fantasy' in genres) > 0 then true
	     	else false
	       end as is_fantasy
	     , case 
	     	when position('Romance' in genres) > 0 then true
	     	else false
	       end as is_romance
	     , case 
	     	when position('Drama' in genres) > 0 then true
	     	else false
	       end as is_drama	       
	     , case 
	     	when position('Action' in genres) > 0 then true
	     	else false
	       end as is_action
	     , case 
	     	when position('Crime' in genres) > 0 then true
	     	else false
	       end as is_crime
	     , case 
	     	when position('Thriller' in genres) > 0 then true
	     	else false
	       end as is_thriller
	     , case 
	     	when position('Horror' in genres) > 0 then true
	     	else false
	       end as is_horror
	     , case 
	     	when position('Mystery' in genres) > 0 then true
	     	else false
	       end as is_mystery
	     , case 
	     	when position('Sci-Fi' in genres) > 0 then true
	     	else false
	       end as is_sci_fi
	     , case 
	     	when position('War' in genres) > 0 then true
	     	else false
	       end as is_war
	     , case 
	     	when position('Musical' in genres) > 0 then true
	     	else false
	       end as is_musical
	     , case 
	     	when position('Documentary' in genres) > 0 then true
	     	else false
	       end as is_documentary
	     , case 
	     	when position('IMAX' in genres) > 0 then true
	     	else false
	       end as is_imax
	     , case 
	     	when position('Western' in genres) > 0 then true
	     	else false
	       end as is_western
	     , case 
	     	when position('Film-Noir' in genres) > 0 then true
	     	else false
	       end as is_film_noir
	     , case 
	     	when position('(no genres listed)' in genres) > 0 then true
	     	else false
	       end as is_no_genres
		from movies;

-- displaying the view
select * from movies_parsed_genres;

-- save the view data in csv-file
\COPY (select * from movies_parsed_genres) TO 'movies_parsed_genres.csv'  WITH DELIMITER ',' CSV HEADER;
