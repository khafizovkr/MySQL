
USE kinopoisk;

DROP TABLE IF EXISTS users;
CREATE TABLE users (
	id bigint UNSIGNED AUTO_INCREMENT PRIMARY KEY, 
	first_name varchar(145),
	last_name varchar(145),
	email varchar(145) NOT NULL,
	phone char(11) NOT NULL,
	password_hash char(65) DEFAULT NULL,
	created_at datetime NOT NULL DEFAULT current_timestamp,
	updated_at datetime DEFAULT NULL ON UPDATE current_timestamp,
	UNIQUE INDEX email_idx (email),
	UNIQUE INDEX phone_idx (phone)
) comment "Обычные юзеры";

DROP TABLE IF EXISTS profiles;
CREATE TABLE profiles (
	user_id bigint UNSIGNED PRIMARY KEY,
	gender enum('f', 'm', 'x'),
	birthday date,
	photo_id int,
	country varchar(130),
	city varchar(130),
  	CONSTRAINT fk_profiles_users FOREIGN KEY (user_id) REFERENCES users (id)
) comment "Профили обычных юзеров";

DROP TABLE IF EXISTS celebrities;
CREATE TABLE celebrities (
  	id bigint UNSIGNED AUTO_INCREMENT PRIMARY KEY, 
  	first_name varchar(145) NOT NULL,
  	last_name varchar(145) NOT NULL,
  	gender enum('f', 'm', 'x'),
  	birthday date,
  	city varchar(145) comment 'Место рождения\город',
  	country varchar(145) comment 'Место рождения\страна',
  	total_films int NOT null comment "Количество фильмов",
  	photo varchar(100) NOT NULL,
  	created_at datetime DEFAULT current_timestamp,  
  	updated_at datetime DEFAULT NULL ON UPDATE current_timestamp
) comment "В эту таблицу могут входить актеры, сценаристы, режиссеры, продюссеры и т.д."; 

DROP TABLE IF EXISTS films;
CREATE TABLE films (
	id bigint UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	title_orig varchar(145),
	title varchar(145) NOT NULL,
	description text NOT NULL,
	release_date date NOT NULL,
	country varchar(145) NOT NULL,
	INDEX title_idx (title)
);

DROP TABLE IF EXISTS genres;
create table genres (
 	id int UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  	name varchar(255) NOT NULL UNIQUE
);

DROP TABLE IF EXISTS films_genres;
CREATE TABLE films_genres (
  	film_id bigint UNSIGNED NOT NULL,
  	genre_id int UNSIGNED NOT NULL,
  	PRIMARY KEY (film_id, genre_id),
  	CONSTRAINT fk_films_genres_films FOREIGN KEY (film_id) REFERENCES films (id),
  	CONSTRAINT fk_films_genres_genre FOREIGN KEY (genre_id) REFERENCES genres (id)
) comment 'Для каждого фильма будет своя табличка с жанрами, т.к. один фильм может быть в нескольких жанрах';

DROP TABLE IF EXISTS film_actors;
CREATE TABLE film_actors (
	film_id bigint UNSIGNED NOT NULL,
	celebrity_id bigint UNSIGNED NOT NULL,
	PRIMARY KEY (film_id, celebrity_id),
  	CONSTRAINT fk_film_actors_films FOREIGN KEY (film_id) REFERENCES films (id),
  	CONSTRAINT fk_film_actors_celeb FOREIGN KEY (celebrity_id) REFERENCES celebrities (id)
) comment 'Таблица с актерами в фильме.';

DROP TABLE IF EXISTS rating;
CREATE TABLE rating (
  	film_id bigint UNSIGNED NOT NULL,
  	user_id bigint UNSIGNED NOT NULL,
  	rating bigint NOT NULL,
  	PRIMARY KEY (film_id, user_id),
  	CONSTRAINT fk_rating_films FOREIGN KEY (film_id) REFERENCES films (id),
  	CONSTRAINT fk_rating_user FOREIGN KEY (user_id) REFERENCES users (id)
);

DROP TABLE IF EXISTS media_types;
CREATE TABLE media_types (
  	id int UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  	name varchar(255) NOT NULL UNIQUE
);

DROP TABLE IF EXISTS media;
CREATE TABLE media (
  	id bigint UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  	user_id bigint UNSIGNED,
  	celebrity_id bigint UNSIGNED,
  	film_id bigint UNSIGNED,
  	media_types_id int UNSIGNED NOT NULL,
  	file_name varchar(255) NOT NULL,
  	file_size bigint NOT NULL,
	created_at datetime NOT NULL DEFAULT current_timestamp,
	KEY fk_media_users_idx (user_id),
  	KEY fk_media_media_types (media_types_id),
  	CONSTRAINT fk_media_media_types FOREIGN KEY (media_types_id) REFERENCES media_types (id),
  	CONSTRAINT fk_media_users FOREIGN KEY (user_id) REFERENCES users (id),
  	CONSTRAINT fk_media_celebrity FOREIGN KEY (celebrity_id) REFERENCES celebrities (id),
  	CONSTRAINT fk_media_film FOREIGN KEY (film_id) REFERENCES films (id)
);







