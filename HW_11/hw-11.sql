-- 
-- Создайте таблицу logs типа Archive. Пусть при каждом создании записи в таблицах users, catalogs и products в таблицу logs помещается время и 
-- дата создания записи, название таблицы, идентификатор первичного ключа и содержимое поля name.

DROP TABLE IF EXISTS logs;
CREATE TABLE logs (
	created_at DATETIME NOT NULL,
	table_name VARCHAR(45) NOT NULL,
	str_id BIGINT(20) NOT NULL,
	name_value VARCHAR(45) NOT NULL
) ENGINE = ARCHIVE;


-- тригер для таблицы users
DROP TRIGGER IF EXISTS trigger_users;
delimiter //
CREATE TRIGGER trigger_users AFTER INSERT ON users
FOR EACH ROW
BEGIN
	INSERT INTO logs (created_at, table_name, str_id, name_value)
	VALUES (NOW(), 'users', NEW.id, NEW.name);
END //
delimiter ;


-- тригер для таблицы catalogs
DROP TRIGGER IF EXISTS trigger_catalogs;
delimiter //
CREATE TRIGGER trigger_catalogs AFTER INSERT ON catalogs
FOR EACH ROW
BEGIN
	INSERT INTO logs (created_at, table_name, str_id, name_value)
	VALUES (NOW(), 'catalogs', NEW.id, NEW.name);
END //
delimiter ;


-- тригер для таблицы products
DROP TRIGGER IF EXISTS trigger_products;
delimiter //
CREATE TRIGGER trigger_products AFTER INSERT ON products
FOR EACH ROW
BEGIN
	INSERT INTO logs (created_at, table_name, str_id, name_value)
	VALUES (NOW(), 'products', NEW.id, NEW.name);
END //
delimiter ;

-- проверка

INSERT INTO users (name, birthday_at)
VALUES ('Владимир', '1994-12-12');

SELECT * FROM products;
SELECT * FROM logs;

INSERT INTO catalogs (name)
VALUES ('Блок питания');
		
INSERT INTO products (name, description, price, catalog_id)
VALUES ('Cooler Master', 'Блок питания', 4000.00, 6);
