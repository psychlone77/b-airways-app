-- pls add some comments where you change 
-- fixed the syntax errors
-- fixed add_new_registered_user to have a transaction or else user table keeps getting rows without rollback
-- changed scheduled_arrival trigger, fixed since there was error.

SET GLOBAL log_bin_trust_function_creators = 1;

DROP FUNCTION IF EXISTS calculateAge;
-- DROP TRIGGER IF EXISTS get_jointime;
DROP TRIGGER IF EXISTS calculate_scheduled_arrival;
DROP FUNCTION IF EXISTS IsRegisteredUser;
DROP FUNCTION IF EXISTS calculateTotalPrice;
DROP PROCEDURE IF EXISTS insert_scheduled_flight;
DROP PROCEDURE IF EXISTS add_new_registered_user;
DROP PROCEDURE IF EXISTS add_new_guest_user;
DROP PROCEDURE if exists get_aircraft_schedule;
DROP PROCEDURE if exists InsertAircraftSeats;
DROP TRIGGER if exists aircraft_insert_trigger;
DROP TRIGGER if exists aircraft_insert_trigger;


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

-- scheduled arrival is set to calculate before inserting
DELIMITER |
CREATE TRIGGER calculate_scheduled_arrival
BEFORE INSERT ON Scheduled_Flight
FOR EACH ROW
BEGIN
    DECLARE duration TIME;
    SELECT route_duration INTO duration FROM Route WHERE Route.route_id = NEW.route_id;
    SET NEW.scheduled_arrival = TIMESTAMPADD(SECOND, TIME_TO_SEC(duration), NEW.scheduled_departure);
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
|
DELIMITER ;

DELIMITER |

CREATE PROCEDURE insert_scheduled_flight(
    IN val_route_id VARCHAR(10),
    IN val_aircraft_id VARCHAR(20),
    IN val_scheduled_departure DATETIME
)
BEGIN
    DECLARE val_scheduled_arrival DATETIME;
    DECLARE val_duration TIME;
    DECLARE rec_exists INT;
    DECLARE maintenance_time TIME;
    DECLARE if_available BOOLEAN;
    
    SET maintenance_time = '02:00:00';
    
    -- Get the duration of the route
    SELECT route_duration INTO val_duration FROM Route WHERE route_id = val_route_id;
    SELECT route_duration INTO val_duration FROM Route WHERE route_id = val_route_id;
    
    -- Calculate the scheduled arrival time
    SET val_scheduled_arrival = TIMESTAMPADD(SECOND, TIME_TO_SEC(val_duration),val_scheduled_departure);
    
    -- Check if the aircraft is available
    SELECT COUNT(*) INTO rec_exists
    FROM Scheduled_Flight f
    WHERE aircraft_id = val_aircraft_id
        AND (
            (f.scheduled_departure <= val_scheduled_departure AND f.scheduled_arrival >= val_scheduled_departure)
            OR (f.scheduled_departure <= val_scheduled_arrival AND f.scheduled_arrival >= val_scheduled_arrival)
            OR (f.scheduled_departure >= val_scheduled_departure AND f.scheduled_arrival <= val_scheduled_arrival)
        );
    
    IF rec_exists = 0 THEN
        INSERT INTO Scheduled_Flight (route_id, aircraft_id, scheduled_departure, scheduled_arrival)
        VALUES (val_route_id, val_aircraft_id, val_scheduled_departure, val_scheduled_arrival);
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
/*
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
*/
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


DELIMITER |

CREATE PROCEDURE get_aircraft_schedule(
    IN origin_code VARCHAR(4),
    IN destination_code VARCHAR(4),
    IN departure_time DATETIME,
    IN class_type VARCHAR(15)
    )
    BEGIN
        SELECT
            a.aircraft_id AS "Aircraft ID",
            sf.scheduled_departure AS "Scheduled Departure",
            sf.scheduled_arrival AS "Scheduled Arrival",
            r.route_origin AS "From",
            r.route_destination AS "To"
        FROM
            Scheduled_Flight sf
        JOIN
            Aircraft a ON sf.aircraft_id = a.aircraft_id
        JOIN
            Aircraft_Model am ON a.model_id = am.model_id
        JOIN
            Route r ON sf.route_id = r.route_id
        WHERE
            r.route_origin = origin_code
            AND r.route_destination = destination_code
            AND DATE(sf.scheduled_departure) < departure_time
            AND DATE(sf.scheduled_departure) > NOW()
            AND (
                CASE
                    WHEN class_type = 'Economy' THEN am.economy_seats
                    WHEN class_type = 'Business' THEN am.business_seats
                    WHEN class_type = 'Platinum' THEN am.platinum_seats
                END > (
                    SELECT COUNT(ub.booking_id)
                    FROM User_Booking ub
                    WHERE ub.seat_id = (
                        SELECT seat_id
                        FROM Aircraft_Seat
                        WHERE seat_class_id = (
                            SELECT class_id
                            FROM Seating_Class
                            WHERE class_name = classType
                        )
                    )
                )
            );
END;
|
DELIMITER ;


DELIMITER |

CREATE PROCEDURE InsertAircraftSeats(IN val_aircraft_id VARCHAR(20), IN val_model_id varchar(4))
BEGIN
    DECLARE e_seats INT;
    DECLARE p_seats INT;
    DECLARE b_seats INT;
    DECLARE economy_class_id INT;
    DECLARE platinum_class_id INT;
    DECLARE business_class_id INT;
    DECLARE i INT;
    
    -- Get the number of seats for each class from the Aircraft_Model table
    SELECT economy_seats, platinum_seats, business_seats
    INTO e_seats, p_seats, b_seats
    FROM Aircraft_Model
    WHERE model_id = val_model_id;
    
    SELECT class_id INTO economy_class_id
    FROM Seating_Class
    WHERE class_name = 'Economy';

    SELECT class_id INTO platinum_class_id
    FROM Seating_Class
    WHERE class_name = 'Platinum';

    SELECT class_id INTO business_class_id
    FROM Seating_Class
    WHERE class_name = 'Business';
    
    -- Insert economy seats
    SET i = 1;
    WHILE i <= e_seats DO
        INSERT INTO Aircraft_Seat (seat_id, aircraft_id, seat_class_id)
        VALUES (CONCAT('S', LPAD(i, 3, '0')), val_aircraft_id, economy_class_id);
        SET i = i + 1;
    END WHILE;
    
    -- Insert platinum seats
    SET i = 1;
    WHILE i <= p_seats DO
        INSERT INTO Aircraft_Seat (seat_id, aircraft_id, seat_class_id)
        VALUES (CONCAT('S', LPAD(i, 3, '0')), val_aircraft_id, platinum_class_id);
        SET i = i + 1;
    END WHILE;
    
    -- Insert business seats
    SET i = 1;
    WHILE i <= b_seats DO
        INSERT INTO Aircraft_Seat (seat_id, aircraft_id, seat_class_id)
        VALUES (CONCAT('S', LPAD(i, 3, '0')), val_aircraft_id, business_class_id);
        SET i = i + 1;
    END WHILE;
END;
|

DELIMITER ;


DELIMITER |

CREATE TRIGGER aircraft_insert_trigger
AFTER INSERT ON Aircraft
FOR EACH ROW
BEGIN
    CALL InsertAircraftSeats(NEW.aircraft_id, NEW.model_id);
END;
|

DELIMITER ;
