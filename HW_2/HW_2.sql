-- 2. Создайте базу данных example, разместите в ней таблицу users, состоящую из двух столбцов, числового id и строкового name.
drop database example;

create database EXAMPLE;

use example;

create table users (id serial, name varchar(100) not null unique);

SHOW DATABASES;

/*3. Создайте дамп базы данных example из предыдущего задания, разверните содержимое дампа в новую базу данных sample.
 Чтобы сделать дамп базы, в командной строке ввожу: 
 mysqldump example > example.SQL
 Разворачиваю дамп в новую базу данных sample:
 mysql sample < example.sql 
 4. (по желанию) Ознакомьтесь более подробно с документацией утилиты mysqldump. Создайте дамп единственной таблицы help_keyword базы данных mysql. Причем добейтесь того, чтобы дамп содержал только первые 100 строк таблицы.
 Чтобы сделать дамп первых 100 значений, ввожу в командную строку команду:
 mysqldump --opt --where="1 order by help_keyword_id limit 100" mysql help_keyword > dump.sql*/
