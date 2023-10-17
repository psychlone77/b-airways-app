DROP FUNCTION IF EXISTS calculateAge;
DROP TRIGGER IF EXISTS get_jointime;

DELIMITER |
CREATE FUNCTION calculateAge (birthday DATE)
RETURNS INT
BEGIN
DECLARE birthYear INT;
DECLARE currentYear INT;
SET birthYear = YEAR(birthday);
SET currentYear = YEAR(CURDATE());
RETURN currentYear-birthYear;
END;
|
DELIMITER ;

DELIMITER |
CREATE TRIGGER get_jointime BEFORE INSERT ON Registered_User
FOR EACH ROW
BEGIN
SET NEW.joined_datetime = NOW();
END;
|
DELIMITER ;

DELIMITER |
CREATE FUNCTION IsRegisteredUser(userId int) 
RETURNS BOOLEAN
BEGIN
DECLARE isRegistered BOOLEAN;
SET isRegistered = EXISTS(SELECT 1 FROM User WHERE user_id = userId AND user_state = 'registered');
RETURN isRegistered;
END;
|
DELIMITER ;
DELIMITER |
CREATE FUNCTION calculateTotalPrize(val_route_id varchar(10), val_seat_class_id int, val_user_id int)
RETURNS NUMERIC
BEGIN
DECLARE val_price numeric(10,2);
DECLARE isRegistered BOOLEAN;
DECLARE val_registered_user_category ENUM('General','Frequent','Gold');
DECLARE discount decimal(4,2);
DECLARE final_price numeric(10,2);
SELECT price into val_price FROM Seat_Class_Price where route_id = val_route_id and seat_class_id = val_seat_class_id;
SET isRegistered = isRegistered(val_user_id);
IF isRegistered = 1 THEN
	SELECT registered_user_category into val_registered_user_category FROM Registered_User where user_id = val_user_id;
    SELECT discount_percentage into discount FROM User_Category WHERE registered_user_category= val_registered_user_category;
    SET final_price = val_price*(100+discount);
ELSE
	SET final_price = val_price;
END IF;
RETURN final_price;
END;