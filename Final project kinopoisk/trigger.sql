-- создаю тригер на проверку пола и даты рождения
DROP TRIGGER IF EXISTS check_celebrity_gender_birthday;
delimiter //
CREATE TRIGGER check_celebrity_gender BEFORE INSERT ON celebrities
FOR EACH ROW
BEGIN 
	IF NEW.gender IS NULL AND NEW.birthday IS NULL THEN 
		SIGNAL SQLSTATE '45000' SET message_text = 'Insert Canceled. You must specify gender and birthday.';
	END IF;
END //

DELIMITER ;

INSERT INTO celebrities VALUES
	(DEFAULT,'Лиза','Кудроу',NULL,NULL,'Кедар-Рапидс','США',120,10,'2003-11-07',DEFAULT);
	
INSERT INTO celebrities VALUES
	(DEFAULT,'Стив','Каррел','m',NULL,'Кедар-Рапидс','США',120,10,'2003-11-07',DEFAULT);
	