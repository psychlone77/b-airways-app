DROP FUNCTION IF EXISTS calculateAge;
DROP TRIGGER IF EXISTS get_jointime ON Registered_User;

CREATE FUNCTION calculateAge (birthday DATE)
RETURNS INT
BEGIN
DECLARE birthYear INT;
DECLARE currentYear INT;
SET birthYear = YEAR(birthday);
SET currentYear = YEAR(CURDATE());
RETURN currentYear-birthYear;
END;

DELIMITER |
CREATE TRIGGER get_jointime BEFORE INSERT ON Registered_User
FOR EACH ROW
BEGIN
SET NEW.joined_datetime = NOW();
END;
|
DELIMITER ;