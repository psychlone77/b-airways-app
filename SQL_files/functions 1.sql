-- check the comment in calculatetotalprice


SET GLOBAL log_bin_trust_function_creators = 1;

DROP FUNCTION IF EXISTS calculateAge; -- used for queries
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

DROP TRIGGER IF EXISTS calculate_scheduled_arrival;
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

DROP FUNCTION IF EXISTS IsRegisteredUser;
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

DROP FUNCTION IF EXISTS calculateTotalPrice;
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
    SET isRegistered = isRegistered(val_user_id); -- shouldn't this be isRegisteredUser??
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

DROP PROCEDURE IF EXISTS insert_scheduled_flight;
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
        
        -- Calculate the scheduled arrival time
        SET val_scheduled_arrival = TIMESTAMPADD(SECOND, TIME_TO_SEC(val_duration), val_scheduled_departure);
        
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

-- change the below proc if changed @Nithika
DROP PROCEDURE if exists get_aircraft_schedule;
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

-- removed commented email and passport uniqueness checking
DROP PROCEDURE IF EXISTS add_new_registered_user;
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

DROP PROCEDURE IF EXISTS add_new_guest_user;
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

DROP PROCEDURE if exists InsertAircraftSeats;
    DELIMITER |
    CREATE PROCEDURE InsertAircraftSeats(IN val_aircraft_id VARCHAR(20), IN val_model_id varchar(4))
    BEGIN
        DECLARE economy_seats INT;
        DECLARE platinum_seats INT;
        DECLARE business_seats INT;
        DECLARE i INT;
        
        -- Get the number of seats for each class from the Aircraft_Model table
        SELECT economy_seats, platinum_seats, business_seats
        INTO economy_seats, platinum_seats, business_seats
        FROM Aircraft_Model
        WHERE model_id = val_model_id;
        
        -- Insert economy seats
        SET i = 1;
        WHILE i <= economy_seats DO
            INSERT INTO Aircraft_Seat (seat_id, aircraft_id, seat_class_id)
            VALUES (CONCAT('S', LPAD(i, 3, '0')), val_aircraft_id, 1);
            SET i = i + 1;
        END WHILE;
        
        -- Insert platinum seats
        SET i = 1;
        WHILE i <= platinum_seats DO
            INSERT INTO Aircraft_Seat (seat_id, aircraft_id, seat_class_id)
            VALUES (CONCAT('S', LPAD(i, 3, '0')), val_aircraft_id, 2);
            SET i = i + 1;
        END WHILE;
        
        -- Insert business seats
        SET i = 1;
        WHILE i <= business_seats DO
            INSERT INTO Aircraft_Seat (seat_id, aircraft_id, seat_class_id)
            VALUES (CONCAT('S', LPAD(i, 3, '0')), val_aircraft_id, 3);
            SET i = i + 1;
        END WHILE;
    END;
    |
    DELIMITER ;

DROP TRIGGER if exists aircraft_insert_trigger;
    DELIMITER |

    CREATE TRIGGER aircraft_insert_trigger
    AFTER INSERT ON Aircraft
    FOR EACH ROW
    BEGIN
        CALL InsertAircraftSeats(NEW.aircraft_id, NEW.model_id);
    END;
    |
    DELIMITER ;

DROP TRIGGER if exists update_user_category_trigger;
    DELIMITER |
    CREATE TRIGGER update_user_category_trigger
    AFTER INSERT ON User_Booking
    FOR EACH ROW
    BEGIN
        DECLARE u_state ENUM('guest','registered');
        DECLARE booking_count INT;
        DECLARE user_category VARCHAR(20);
        
        block: BEGIN
        SELECT user_state INTO u_state
        FROM User
        WHERE user_id = NEW.user_id;
        
        -- Check if user state is 'guest'
        IF u_state = 'guest' THEN
            -- Exit the trigger with LEAVE
            LEAVE block;
        END IF;

        -- Get the booking count for the user
        SELECT COUNT(*) INTO booking_count
        FROM User_Booking
        WHERE user_id = NEW.user_id;
        
        -- Get the user category based on the booking count
        SELECT category_name INTO user_category
        FROM User_Category
        WHERE booking_count >= min_booking_count
        ORDER BY min_booking_count DESC
        LIMIT 1;
        
        -- Update the user category
        UPDATE Registered_User
        SET category = user_category
        WHERE user_id = NEW.user_id;
        end block;
    END;
    |

    DELIMITER ;

--a trigger to automatically update a registered user from General to Frequent after 10 bookings they have booked with B airways and to Gold after they have made 50 bookings
DROP TRIGGER IF EXISTS update_user_category;

    DELIMITER | 
    CREATE TRIGGER update_user_category
    AFTER INSERT ON User_Booking
    FOR EACH ROW
    BEGIN
        DECLARE num_user_booking INT;
        DECLARE user_category ENUM('General', 'Frequent', 'Gold');

        SELECT COUNT(*) INTO num_user_booking
        FROM User_Booking
        WHERE user_id = NEW.user_id AND IsRegisteredUser(NEW.user_id) = 1;

        IF num_user_booking >= 50 THEN
            SET user_category = 'Gold';
        ELSEIF num_user_booking >= 10 THEN
            SET user_category = 'Frequent';
        ELSE
            SET user_category = 'General';
        END IF;

        UPDATE Registered_User
        SET registered_user_category = user_category
        WHERE user_id = NEW.user_id;

    END;

    |
    DELIMITER ;



