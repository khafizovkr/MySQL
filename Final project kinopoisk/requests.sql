-- запрос на id фильма, фильма и актеров, которые в нем снимаются
SELECT fa.film_id, f2.title, concat(c.first_name, ' ', c.last_name) AS name
FROM film_actors fa 
	JOIN celebrities c ON fa.celebrity_id = c.id
	JOIN films f2 ON fa.film_id = f2.id;


-- делаем запрос на рейтинг фильмов
SELECT f.id, f.title, f.country, f.release_date, r.avg_rating
FROM films f
JOIN 
(SELECT film_id, AVG(rating) AS avg_rating 
FROM rating GROUP BY film_id) r
ON f.id = r.film_id;

-- представление топ-10 фильмов
CREATE OR REPLACE VIEW top_10
AS
	SELECT f.id, f.title, f.country, f.release_date, r.avg_rating
	FROM films f
	JOIN 
	(SELECT film_id, AVG(rating) AS avg_rating 
	FROM rating GROUP BY film_id) r
	ON f.id = r.film_id
	ORDER BY avg_rating DESC
	limit 10;

SELECT * FROM top_10;
