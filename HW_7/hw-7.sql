--
-- Составьте список пользователей users, которые осуществили хотя бы один заказ orders в интернет магазине.
--

SELECT 
	orders.user_id,
	users.name,
	orders.id AS order_id
FROM 
	users
RIGHT JOIN
	orders
ON
	users.id = orders.user_id;

--
-- Выведите список товаров products и разделов catalogs, который соответствует товару.
--

SELECT 
	id, 
	name, 
	(SELECT name FROM catalogs WHERE id = catalog_id) AS 'catalog' 
FROM 
	products;

--
-- Пусть имеется таблица рейсов flights (id, from, to) и таблица городов cities (label, name). 
-- Поля from, to и label содержат английские названия городов, поле name — русское. 
-- Выведите список рейсов flights с русскими названиями городов.
--

-- создание таблиц
-- from и to заменил на go_from и go_to, т.к. Mysql немного ругается на синтаксис

DROP TABLE IF EXISTS flights;
CREATE TABLE flights (
  id SERIAL PRIMARY KEY,
  go_from VARCHAR(255) COMMENT 'Откуда',
  go_to VARCHAR(255) COMMENT 'Куда');

INSERT INTO flights (go_from, go_to) VALUES
  ('moscow', 'omsk'),
  ('novgorod', 'kazan'),
  ('irkutsk', 'moscow'),
  ('omsk', 'irkutsk'),
  ('moscow', 'kazan');
 
DROP TABLE IF EXISTS cities;
CREATE TABLE cities (
  label VARCHAR(255) COMMENT 'english',
  name VARCHAR(255) COMMENT 'russian');


INSERT INTO cities (label, name) VALUES
  ('moscow', 'Москва'),
  ('irkutsk', 'Иркутск'),
  ('novgorod', 'Новгород'),
  ('kazan', 'Казань'),
  ('omsk', 'Омск');
 
-- решение

SELECT 
	(SELECT name FROM cities WHERE label = go_from) AS 'from', 
	(SELECT name FROM cities WHERE label = go_to) AS 'to'
FROM 
	flights;