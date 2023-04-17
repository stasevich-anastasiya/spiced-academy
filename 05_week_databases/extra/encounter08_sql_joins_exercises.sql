/*
Encounter 08 - sql Joins
Exercises
*/

/*
Step 1: Inspect the genres
Connect to the movielens database. Select the genres column to inspect the data:
*/
SELECT genres FROM movies LIMIT 5;

/*
Step 2: Split the genres
To map each indivdual movie to a genres the regexp_split_to_table(column, 'pattern') can be used. 
The first argument is the column on which to execute the function and the second the pattern to split the string with:
*/
SELECT movie_id, regexp_split_to_table(genres, '\|') FROM movies LIMIT 10;

/*
Step 3: Create a genres tables

The table above is only a result of the query. In order to make the results persistant as a table the following code can either be executed in the psqlshell or added to the movie_lens.sql and run with the -f argument:
*/
DROP TABLE IF EXISTS genres;
CREATE TABLE genres AS (
    SELECT 
    	movie_id,
    	regexp_split_to_table(genres, '\|') AS genre
    FROM movies
);

/*
BONUS:
Use ALTER TABLE command to add foreign key constraint to movieid. 
This would create a primary-foreign key relationship between the genres and movies tables.
 */

alter table genres
add foreign key (movie_id) references movies (movie_id);


/*
Step 4: Inspect the result
After executing the code the following command should result in a table similar to the results above.
 */

select * from genres limit 10;

