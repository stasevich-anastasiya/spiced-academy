/* 
ENCOUNTER 03 - Data Modeling
Project Challenge - Create tables for movielens adatbase
*/

/*
ENCOUNTER 07 - Foreign Keys
Project Challenge - Add foreign keys to Movie-Lens dataset
*/


-- Movies:
--    movieId,title,genres,year
--    1,Toy Story ,Adventure|Animation|Children|Comedy|Fantasy,1995

DROP TABLE IF EXISTS movies CASCADE;
CREATE TABLE movies (
    movie_id INT primary key,
    title VARCHAR(225) not null,
    genres VARCHAR(225),
    movie_year INT
);

-- Links:
--     movieId,imdbId,tmdbId
--     1,114709,862

DROP TABLE IF EXISTS links;
CREATE TABLE links (
    movie_id INT primary key,
    imdb_id INT,
    tmdb_id INT,
    FOREIGN KEY (movie_id) REFERENCES movies(movie_id)
);

-- Ratings:
--    userId,movieId,rating,timestamp
--    1,1,4.0,964982703

DROP TABLE IF EXISTS ratings;
CREATE TABLE ratings (
    user_id INT not null,
    movie_id INT not null,
    rating NUMERIC(2,1) not null,
    rating_timestamp BIGINT, -- UNIX TIMESTAMP,
    PRIMARY KEY(user_id, movie_id),
    FOREIGN KEY (movie_id) REFERENCES movies(movie_id)
);

-- Tags:
--    userId,movieId,tag,timestamp
--    2,60756,funny,1445714994
--    2,60756,Highly quotable,1445714996

DROP TABLE IF EXISTS tags;
CREATE TABLE tags (
    tag_id SERIAL primary key,
    user_id INT not null,
    movie_id INT not null,
    tag VARCHAR(225),
    tag_timestamp BIGINT, -- UNIX TIMESTAMP
    FOREIGN KEY (movie_id) REFERENCES movies(movie_id)
);

-------------------------------------------------------------

/*
Encounter 04 - Data Import/Export
Project Challenge - Copy Movie-lens Data to Database
*/

\COPY movies FROM '../data/movies.csv' DELIMITER ',' CSV HEADER;

\COPY links FROM '../data/links.csv' DELIMITER ',' CSV HEADER;

\COPY ratings FROM '../data/ratings.csv' DELIMITER ',' CSV HEADER;

\COPY tags(user_id, movie_id, tag, tag_timestamp) FROM '../data/tags.csv' DELIMITER ',' CSV HEADER;

-----------------------------------------------------------

/*
Encounter 08 - SQL Joins
Exersises - Add derived table 'genres' to 'movielens' database
*/
DROP TABLE IF EXISTS genres;
CREATE TABLE genres AS (
    SELECT 
    	movie_id,
    	regexp_split_to_table(genres, '\|') AS genre
    FROM movies
);

-- add FK to 'genres' table
ALTER TABLE genres
ADD FOREIGN KEY (movie_id) REFERENCES movies (movie_id);

------------------------------------------------------------

/*
ENCOUNTER 06 - Group By
Extra - Create a view  with all pure genres from 'movies' table as separate columns
*/

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
