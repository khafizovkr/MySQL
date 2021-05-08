SELECT rating FROM rating WHERE film_id = 1;

SELECT avg(rating) FROM rating; 

SELECT 
	f2.title,
	concat(c.first_name, ' ', c.last_name) AS name,
	(SELECT avg(rating) FROM rating) AS rating,
	f2.release_date
FROM film_actors fa 
	JOIN celebrities c ON fa.celebrity_id = c.id
	JOIN films f2 ON fa.film_id = f2.id
WHERE f2.id;


SELECT f2.title, concat(c.first_name, ' ', c.last_name) AS name
FROM film_actors fa 
	JOIN celebrities c ON fa.celebrity_id = c.id
	JOIN films f2 ON fa.film_id = f2.id
WHERE f2.id = 1;


SELECT f.title, (SELECT avg(rating) FROM rating) AS rating 
FROM films f
JOIN rating r ON r.film_id = f.id
GROUP BY title AND rating 
ORDER BY rating DESC
limit 20;