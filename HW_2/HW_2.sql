-- 2.
drop database example;

create database EXAMPLE;

use example;

create table users (id serial, name varchar(100) not null unique);

SHOW DATABASES;

/*3. Чтобы сделать дамп базы, в командной строке ввожу: 
 mysqldump example > example.SQL
 Разворачиваю дамп в новую базу данных sample:
 mysql sample < example.sql 
 4. Чтобы сделать дамп первых 100 значений, ввожу в командную строку команду:
 mysqldump --opt --where="1 order by help_keyword_id limit 100" mysql help_keyword > dump.sql*/
