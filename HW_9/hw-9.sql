-- 
-- В базе данных shop и sample присутствуют одни и те же таблицы, учебной базы данных. 
-- Переместите запись id = 1 из таблицы shop.users в таблицу sample.users. Используйте транзакции.
-- 

START TRANSACTION;
INSERT INTO sample.users (name)
SELECT (name) FROM shop.users WHERE id=1;
-- т.к. значение перемещаем, то удаляем пользователя с id=1 из таблицы users базы данных shop.
DELETE FROM shop.users WHERE id=1;
COMMIT;

-- 
-- Создайте представление, которое выводит название name товарной позиции из таблицы products и 
-- соответствующее название каталога name из таблицы catalogs.

CREATE OR REPLACE VIEW view_products
AS
  SELECT products.id, products.name, catalogs.name AS cat_name
  FROM products
  	JOIN catalogs ON products.catalog_id = catalogs.id;

SELECT * FROM view_products;

-- 
-- (по желанию) Пусть имеется таблица с календарным полем created_at. В ней размещены разряженые 
-- календарные записи за август 2018 года '2018-08-01', '2016-08-04', '2018-08-16' и 2018-08-17. 
-- Составьте запрос, который выводит полный список дат за август, выставляя в соседнем поле 
-- значение 1, если дата присутствует в исходном таблице и 0, если она отсутствует.
-- 

CREATE TABLE datetbl (
	created_at DATE
);

INSERT INTO datetbl VALUES
	('2018-08-01'),
	('2018-08-04'),
	('2018-08-16'),
	('2018-08-17');

drop TABLE datetb2;
CREATE TABLE datetb2 (
	created_at DATE
);


SELECT * FROM datetb2;

DROP PROCEDURE IF EXISTS filldates;
DELIMITER //
CREATE PROCEDURE filldates(IN dateStart DATE, IN dateEnd DATE)
BEGIN
  WHILE dateStart <= dateEnd DO
    INSERT INTO datetb2 (created_at) VALUES (dateStart);
    SET dateStart = date_add(dateStart, INTERVAL 1 DAY);
  END WHILE;
END //

DELIMITER ;
CALL filldates('2018-08-01','2018-08-31');



DROP TABLE IF EXISTS datetbl4;
CREATE TABLE datetbl4 (
	created_at DATE
);

INSERT INTO datetbl4 VALUES
	('2020-12-30'),
	('1990-08-15'),
	('2000-01-06'),
	('2005-09-15'),
	('2016-07-08'),
	('2006-07-08'),
	('1900-06-30'),
	('500-01-31'),
	('2019-11-08'),
	('2022-05-19');

DELETE FROM datetbl4
WHERE created_at NOT IN (
	SELECT *
	FROM (
		SELECT *
		FROM datetbl4
		ORDER BY created_at DESC
		LIMIT 5
	) AS not_del
) ORDER BY created_at DESC;

SELECT * FROM datetbl4 ORDER BY created_at DESC;

-- 
-- Практическое задание по теме “Хранимые процедуры и функции, триггеры"
-- Создайте хранимую функцию hello(), которая будет возвращать приветствие, в зависимости от текущего времени суток. 
-- С 6:00 до 12:00 функция должна возвращать фразу "Доброе утро", с 12:00 до 18:00 функция должна возвращать фразу 
-- "Добрый день", с 18:00 до 00:00 — "Добрый вечер", с 00:00 до 6:00 — "Доброй ночи".

DROP PROCEDURE IF EXISTS pr_hello;
delimiter //
CREATE PROCEDURE pr_hello()
BEGIN
	IF(DATE_FORMAT(NOW(), "%H") between '6' and '12') then
		select 'Доброе утро';
	ELSEIF(DATE_FORMAT(NOW(), "%H") between '12' and '18') then
		select 'Добрый день';
	ELSEIF(DATE_FORMAT(NOW(), "%H") between '18' and '0') then
		select 'Добрый вечер';
	ELSEIF(DATE_FORMAT(NOW(), "%H") between '0' and '6') then
		select 'Доброй ночи';
	END IF;
END //
delimiter ;

CALL pr_hello();

-- Показывает немного не корректно. Я думаю это все из за часовых поясов.


-- 
-- В таблице products есть два текстовых поля: name с названием товара и description с его описанием. Допустимо присутствие 
-- обоих полей или одно из них. Ситуация, когда оба поля принимают неопределенное значение NULL неприемлема. Используя триггеры, 
-- добейтесь того, чтобы одно из этих полей или оба поля были заполнены. При попытке присвоить полям NULL-значение необходимо 
-- отменить операцию.
-- 

DROP TRIGGER IF EXISTS check_products;
delimiter //
CREATE TRIGGER check_products BEFORE INSERT ON products
FOR EACH ROW
BEGIN 
	IF NEW.name IS NULL AND NEW.description IS NULL THEN 
		SIGNAL SQLSTATE '45000' SET message_text = 'Insert Canceled. You must specify name and description.';
	END IF;
END //

DELIMITER ;

-- 
-- (по желанию) Напишите хранимую функцию для вычисления произвольного числа Фибоначчи. Числами Фибоначчи называется 
-- последовательность в которой число равно сумме двух предыдущих чисел. Вызов функции FIBONACCI(10) должен возвращать 
-- число 55.
-- 

DROP FUNCTION IF EXISTS func_fib;
delimiter //
CREATE FUNCTION func_fib(fib_num INT)
RETURNS INT NO SQL
BEGIN
	DECLARE prev int DEFAULT 1;
	DECLARE cur int DEFAULT 1;
	DECLARE i int DEFAULT 0;
	DECLARE res int DEFAULT 0;
	WHILE i < (fib_num-2) DO
		SET res = prev+cur;
		SET prev = cur;
		SET cur = res;
		SET i = i+1;
	END WHILE;
	RETURN res;
END //
delimiter ;

SELECT func_fib(10)




