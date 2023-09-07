use moviedb ;

---Write a SQL query to find the actors who were cast in the movie 'Annie Hall'. Return actor first name, last name and role.------

select * from actors ;
select * from movie_cast ;
select * from movie ;

select act_fname,act_lname,role from actors 
join movie_cast on actors.act_id=movie_cast.act_id
join movie on movie_cast.mov_id=movie.mov_id
and movie.mov_title = 'Annie hall' ;

write a ---SQL query to find the director who directed a movie that casted a role for 'Eyes Wide Shut'. 
Return director first name, last name and movie title.

select * from director ;
select * from movie ;
select * from movie_direction ;
select * from movie_cast ;

select dir_fname,dir_lname,mov_title from director 
natural join movie_direction,movie_cast,movie
where role is not null
and mov_title = 'Eyes Wide Shut' ;



Write a SQL query to find who directed a movie that casted a role as 'Sean Maguire'.
 Return director first name, last name and movie title.
select * from movie ;
select * from movie_cast ;
select * from director ;

-- answer 3 --
select dir_fname,dir_lname,mov_title
from director
join movie_direction on director.dir_id=movie_direction.dir_id
join movie on movie_direction.mov_id=movie.mov_id
join movie_cast on movie_cast.mov_id=movie.mov_id
where role = 'Sean Maguire'

Write a SQL query to find the actors who have not acted in any movie between 1990 and 2000 (Begin and end values are included.). 
Return actor first name, last name, movie title and release year. 

select * from actor ;
select * from movie ;


select act_fname,act_lname,mov_title,mov_year
from actors
join movie_cast on actors.act_id=movie_cast.act_id
join movie on movie_cast.mov_id=movie.mov_id
where mov_year not between 1990 and 2000 ;

Write a SQL query to find the directors with the number of genres of movies. Group the result 
set on director first name, last name and generic title. Sort the result-set in ascending order by director 
first name and last name. Return director first name, last name and number of genres of movies.

select * from  director ;
select*from genres ;  #gen_title
select * from reviewer ;

select d.dir_

 #OR
select dir_fname,dir_lname, gen_title, count(gen_title)
from director
natural join movie_direction
natural join movie_genres
natural join genres
natural join reviewer
group by dir_fname, dir_lname,gen_title
order by dir_fname, dir_lname asc ;