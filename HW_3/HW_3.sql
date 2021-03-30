/* Практическое задание #3. Придумать 2-3 таблицы для БД vk, которую мы создали на занятии (с перечнем полей, указанием индексов и внешних ключей). Прислать результат в виде скрипта *.sql.  */

DROP DATABASE vk_homework;
CREATE DATABASE vk_homework;

USE vk_homework;

CREATE TABLE users (
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  first_name VARCHAR(145) NOT NULL, 
  last_name VARCHAR(145) NOT NULL,
  email VARCHAR(145) NOT NULL,
  phone CHAR(11) NOT NULL,
  password_hash CHAR(65) DEFAULT NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP, 
  UNIQUE INDEX email_unique_idx (email),
  UNIQUE INDEX phone_unique_idx (phone)
) ENGINE=InnoDB;

INSERT INTO users VALUES (DEFAULT, 'Petya', 'Petukhov', 'petya@mail.com', '89212223334', DEFAULT, DEFAULT);
INSERT INTO users VALUES (DEFAULT, 'Vasya', 'Vasilkov', 'vasya@mail.com', '89212023334', DEFAULT, DEFAULT);


SELECT * FROM users;

CREATE TABLE media_types (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name varchar(45) NOT NULL UNIQUE -- изображение, музыка, документ
) ENGINE=InnoDB;

-- Добавим типы в каталог
INSERT INTO media_types VALUES (DEFAULT, 'изображение');
INSERT INTO media_types VALUES (DEFAULT, 'музыка');
INSERT INTO media_types VALUES (DEFAULT, 'документ');

CREATE TABLE media (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY, -- Картинка 1
  user_id BIGINT UNSIGNED NOT NULL,
  media_types_id INT UNSIGNED NOT NULL, -- фото
  file_name VARCHAR(245) DEFAULT NULL COMMENT '/files/folder/img.png',
  file_size BIGINT UNSIGNED,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  INDEX media_media_types_idx (media_types_id),
  INDEX media_users_idx (user_id),
  CONSTRAINT fk_media_media_types FOREIGN KEY (media_types_id) REFERENCES media_types (id),
  CONSTRAINT fk_media_users FOREIGN KEY (user_id) REFERENCES users (id)
);

-- Добавим два изображения, которые добавил Петя
INSERT INTO media VALUES (DEFAULT, 1, 1, 'im.jpg', 100, DEFAULT);
INSERT INTO media VALUES (DEFAULT, 1, 1, 'im1.png', 78, DEFAULT);
-- Добавим документ, который добавил Вася
INSERT INTO media VALUES (DEFAULT, 2, 3, 'doc.docx', 1024, DEFAULT);

SELECT * FROM media;

-- Создаю таблицу с видами учебных заведений

CREATE TABLE education_list (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  institution_name varchar(100) NOT NULL UNIQUE -- название учебного заведения
) ENGINE=InnoDB;

-- DROP TABLE education_list;

INSERT INTO education_list VALUES (DEFAULT, 'School'); -- школы
INSERT INTO education_list VALUES (DEFAULT, 'College'); -- колледжи
INSERT INTO education_list VALUES (DEFAULT, 'University'); -- университеты

SELECT * FROM education_list;

-- Создаю таблицу учебных заведений к каждому профилю

CREATE TABLE study (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY, 
  user_id BIGINT UNSIGNED NOT NULL,
  education_list_id INT UNSIGNED NOT NULL, -- номер id в таблице с видами учебных заведений.
  institution_name VARCHAR(245) DEFAULT NULL, -- название учебного заведения
  institution_сity VARCHAR(100), -- город
  institution_country VARCHAR(100), -- страна
  INDEX study_education_list_idx (education_list_id), -- Индекс по номеру из таблицы с видами учебных заведений.
  INDEX study_users_idx (user_id), -- индекс по user id
  CONSTRAINT fk_study_education_list FOREIGN KEY (education_list_id) REFERENCES education_list (id),
  CONSTRAINT fk_study_users FOREIGN KEY (user_id) REFERENCES users (id)
);

-- DROP TABLE study;

INSERT INTO study VALUES (DEFAULT, 1, 1, '29', 'Nizhnekamsk', 'Russia');
INSERT INTO study VALUES (DEFAULT, 1, 3, 'KGASU', 'Kazan', 'Russia');
INSERT INTO study VALUES (DEFAULT, 2, 1, '29', 'Nizhnekamsk', 'Russia');
INSERT INTO study VALUES (DEFAULT, 2, 2, '44', 'Nizhnekamsk', 'Russia');


SELECT * FROM study;

-- Создаю таблицу стены

CREATE TABLE blog (
	news_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	user_id BIGINT UNSIGNED NOT NULL, -- кем создано (чья стена)
	caption VARCHAR(145) NOT NULL, -- заголовок
	text_info TEXT NOT NULL, -- текст
	media_id BIGINT UNSIGNED NOT NULL, -- вложение медиа
	privacy_set ENUM('for_all', 'for_friends', 'draft') NOT NULL,-- настройки приватности (для всех, для друзей, черновик)
	created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,-- когда создано
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP, -- когда отредактировано
	INDEX fk_user_id_idx (user_id),
	INDEX fk_theme_idx (caption), -- индекс темы
	CONSTRAINT fk_news_creator_id FOREIGN KEY (user_id) REFERENCES users (id), -- внешний ключ создателя
	CONSTRAINT fk_news_media_id FOREIGN KEY (media_id) REFERENCES media (id) -- внешний ключ медиа
);

INSERT INTO blog VALUES (DEFAULT, 1, 'История развития СУБД', 'Современные базы данных за последние 60 лет...', 2, 3, DEFAULT, DEFAULT);

SELECT * FROM blog;
