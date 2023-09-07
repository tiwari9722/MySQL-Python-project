show tables ;

# 2) We want to reward the user who has been around the longest, Find the 5 oldest users.

select * from users   
order by created_at asc limit 5 ;

# 3)To understand when to run the ad campaign, figure out the day of the week most users register on? 

show tables ;

select * from users ;

SELECT username, DAYNAME(created_at) AS day,COUNT(*) AS total
FROM users
GROUP BY day
ORDER BY total DESC ;


# 4) To target inactive users in an email ad campaign, find the users who have never posted a photo.

select * from users ;
select * from photos ;

SELECT username FROM users
LEFT JOIN photos ON users.id = photos.user_id
WHERE photos.id IS NULL ;

# 5)Suppose you are running a contest to find out who got the most likes on a photo. Find out who won.
select * from users ;
select * from photos ;
select * from likes ;

SELECT p.id,u.username,p.image_url, COUNT(*) AS total_likes
FROM photos as p
INNER JOIN likes l ON l.photo_id = p.id
INNER JOIN users u ON p.user_id = u.id
GROUP BY p.id
ORDER BY total_likes DESC;

#6) The investors want to know how many times does the average user post.
select * from users ;
select * from photos ;

SELECT u.username,COUNT(p.image_url)
FROM users as u
JOIN photos p ON u.id = p.user_id
GROUP BY u.id
ORDER BY COUNT(p.image_url)  DESC;

# 7) A brand wants to know which hashtag to use on a post, and find the top 5 most used hashtags.

select * from tags ;

SELECT tag_name, COUNT(tag_name) AS hashtags
FROM tags
JOIN photo_tags ON tags.id = photo_tags.tag_id
GROUP BY tags.id
ORDER BY hashtags DESC
limit 5 ;

# 8)To find out if there are bots, find users who have liked every single photo on the site.

SELECT u.id,username, COUNT(u.id) As like_single_photo
FROM users as u
JOIN likes l ON u.id = l.user_id
GROUP BY u.id
HAVING like_single_photo =  COUNT(u.id) ;

# 9) To know who the celebrities are, find users who have never commented on a photo.

select * from users ;
select * from comments ;

SELECT username,comment_text
FROM users
LEFT JOIN comments ON users.id = comments.user_id
GROUP BY users.id
HAVING comment_text IS NULL;

#10)Now it's time to find both of them together, find the users who have never commented on any photo or have commented on every photo.

with cte as 
(select c.user_id,u.username,count(*)Number_of_photos_commented
 from comments c 
inner join users u on u.id=c.user_id
group by c.user_id 
having (select count(*) from photos)
union 
select c.user_id,u.username,count(*)Number_of_photos_commented
from comments c
inner join users u on u.id=c.user_id
group by c.user_id
having count(*) between 1 and (select count(*) from photos)-1
union 
select u.id,u.username,c.user_id from 
users u 
left join comments c on u.id=c.user_id is null )
select *,
case when number_of_photos_commented=(select count(*)from photos)then 'commented_every_photo'
when number_of_photos_commented between 1 and (select count(*) from photos)-1 then 'some photos'
when number_of_photos_commented is  null  then 'not commented'
end as comment_details_from_users from cte ;















select count(follower_id) as highest_follower from follows
where followee_id order by highest_follower in (select id from users);











































Drop table P_ACTOR_DETAILS ;
DELIMITER //
CREATE PROCEDURE P_ACTOR_DETAILS(I INT)
begin
IF (I=1) then
SELECT username,id FROM users WHERE id NOT IN(select distinct(user_id) from comments);
else

SELECT u.username, u.id FROM users u
INNER JOIN comments c ON c.user_id = u.id
GROUP BY u.id HAVING COUNT(c.user_id) = (select count(distinct(photo_id)) from comments);

end if ;
END//

DELIMITER ;
call p_actor_details(1);