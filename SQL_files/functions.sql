DROP FUNCTION IF EXISTS calculateAge;
DROP TRIGGER IF EXISTS get_jointime;
DROP FUNCTION IF EXISTS IsRegisteredUser;
DROP FUNCTION IF EXISTS calculateTotalPrize;

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

DELIMITER |
CREATE PROCEDURE insert_a_new_flight(val_route_id varchar(10), val_aircraft_id varchar(20), val_scheduled_depature datetime)
BEGIN
DECLARE val_scheduled_arrival datetime;
DECLARE val_aircraft_instance_id int;
DECLARE rec_exists INT;
DECLARE maintenance_time time;
DECLARE if_available boolean;
SET maintenance_time = '02:00:00';
IF departure_time < DATE_ADD(val_scheduled_depature, INTERVAL 1 DAY) THEN
	SIGNAL SQLSTATE '45000'
	SET MESSAGE_TEXT = 'Departure time has to be at least 1 day in the future';
END IF;
SELECT aircraft_instance_id into val_aircraft_instance_id FROM Aircraft_Instance WHERE aircraft_id = val_aircraft_id;
SELECT scheduled_arrival into val_scheduled_arrival FROM Scheduled_Flight WHERE aircraft_instance_id = val_aircraft_instance_id;

SELECT COUNT(*) INTO rec_exists
FROM Scheduled_Flight f
WHERE aircraft_instance_id = val_aircraft_instance_id
LIMIT 1;

IF rec_exists IS NULL THEN
	INSERT INTO Scheduled_Flight (route_id, aircraft_instance_id, scheduled_depature, scheduled_arrival)
	VALUES (val_route_id, val_aircraft_instance_id, val_scheduled_depature, val_scheduled_arrival);
END IF;

SET if_available = ((val_scheduled_arrival +  maintenance_time) < val_scheduled_depature);

IF if_available THEN
	INSERT INTO Scheduled_Flight (route_id, aircraft_instance_id, scheduled_depature, scheduled_arrival)
	VALUES (val_route_id, val_aircraft_instance_id, val_scheduled_depature, val_scheduled_arrival);
ELSE
	SIGNAL SQLSTATE '45000'
	SET MESSAGE_TEXT = 'Aircraft is unavailable for a flight';
END IF;

END;
|
DELIMITER ;