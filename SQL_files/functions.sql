-- pls add some comments where you change 
-- fixed the syntax errors
-- fixed add_new_registered_user to have a transaction or else user table keeps getting rows without rollback

SET GLOBAL log_bin_trust_function_creators = 1;

DROP FUNCTION IF EXISTS calculateAge;
-- DROP TRIGGER IF EXISTS get_jointime;
DROP TRIGGER IF EXISTS calculate_scheduled_arrival;
DROP FUNCTION IF EXISTS IsRegisteredUser;
DROP FUNCTION IF EXISTS calculateTotalPrice;
DROP PROCEDURE IF EXISTS insert_a_new_flight;
DROP PROCEDURE IF EXISTS add_new_registered_user;

-- calculate age
DELIMITER |
CREATE FUNCTION calculateAge (birthday DATE)
RETURNS int
BEGIN
DECLARE birthYear INT;
DECLARE currentYear INT;
SET birthYear = YEAR(birthday);
SET currentYear = YEAR(CURDATE());
RETURN currentYear-birthYear;
END;
|
DELIMITER ;

--scheduled arrival is set to calculate before inserting
DELIMITER |
CREATE TRIGGER calculate_scheduled_arrival
BEFORE INSERT ON Scheduled_Flight
FOR EACH ROW
BEGIN
    DECLARE route_duration TIME;
    SELECT route_duration INTO route_duration FROM Route WHERE route_id = NEW.route_id;
    
    SET NEW.scheduled_arrival = TIMESTAMPADD(SECOND, TIME_TO_SEC(route_duration), NEW.scheduled_departure);
    
    UPDATE Scheduled_Flight
    SET scheduled_arrival = NEW.scheduled_arrival
    WHERE schedule_id = NEW.schedule_id;
END;
|
DELIMITER ;

-- used for validatation
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
CREATE FUNCTION calculateTotalPrice(val_route_id varchar(10), val_seat_class_id int, val_user_id int)
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

--  change this function , aircraft instance is now not available ///////////////////////////////////
DELIMITER |
CREATE PROCEDURE insert_a_new_flight(val_route_id varchar(10), val_aircraft_id varchar(20), val_scheduled_depature datetime)
BEGIN
DECLARE val_scheduled_arrival datetime;
DECLARE val_aircraft_instance_id int;
DECLARE rec_exists INT;
DECLARE maintenance_time time;
DECLARE if_available boolean;
SET maintenance_time = '02:00:00';

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

DELIMITER |
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_new_registered_user`(
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    dob DATE,
    gender ENUM('Male', 'Female', 'Other'),
    passport VARCHAR(20),
    address VARCHAR(100),
    email VARCHAR(50),
    mobile VARCHAR(15),
    password VARCHAR(50)
)
BEGIN
    DECLARE new_user_id INT;
    DECLARE email_count INT;
    DECLARE passport_count INT;
        -- Start a transaction
    START TRANSACTION;

    -- create the user first
    BEGIN
        DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
        BEGIN
            -- Rollback the transaction if any query fails
			ROLLBACK;
            RESIGNAL;
        END;

        INSERT INTO User (user_state)
        VALUES ("Registered");

        SET new_user_id = LAST_INSERT_ID();
    
    -- check if email and passport are unique
    -- SELECT COUNT(*) INTO email_count FROM Registered_User WHERE email = email;
    -- SELECT COUNT(*) INTO passport_count FROM Registered_User WHERE passport_no = passport;
    
    -- IF email_count > 0 THEN
    --     SIGNAL SQLSTATE '45000'
    --     SET MESSAGE_TEXT = 'Email already exists';
    -- END IF;
    
    -- IF passport_count > 0 THEN
    --     SIGNAL SQLSTATE '45000'
    --     SET MESSAGE_TEXT = 'Passport already exists';
    -- END IF;

    -- create the registered user
    -- category and joined date time are not sent
    INSERT INTO Registered_User (user_id, email, password, first_name, last_name, birth_date, gender, passport_no, address)
    VALUES (new_user_id, email,password, first_name, last_name, dob, gender, passport, address);
    -- add the mobile no to the contact no table
    INSERT INTO Contact_No (user_id, contact_no) VALUES (new_user_id, mobile);
	-- Commit the transaction if everything is successful
    COMMIT;
    END;
END
|
DELIMITER ;



DELIMITER |
CREATE PROCEDURE add_new_guest_user(
    name VARCHAR(50),
    dob DATE,
    gender ENUM('Male', 'Female', 'Other'),
    passport VARCHAR(20),
    address VARCHAR(100),
    mobile VARCHAR(20),
    email VARCHAR(50)
)
BEGIN
    DECLARE new_user_id INT;

    -- here the data are not checked for uniqueness, a user can run in user state multiple times

    -- create the user first
    INSERT INTO User (user_state)
    VALUES ("Guest");
    
    SET new_user_id = LAST_INSERT_ID();
    
    -- create the guest user
    INSERT INTO Guest_User (user_id, name, address, birth_date, gender, passport_no, email) 
    VALUES (new_user_id, name, address, dob, gender, passport, email);
END;
|
DELIMITER ;

