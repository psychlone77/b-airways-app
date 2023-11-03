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
-- changed the final_price equation
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
    SET isRegistered = isRegisteredUser(val_user_id); -- shouldn't this be isRegisteredUser??
    IF isRegistered = 1 THEN
        SELECT registered_user_category into val_registered_user_category FROM Registered_User where user_id = val_user_id;
        SELECT discount_percentage into discount FROM User_Category WHERE registered_user_category= val_registered_user_category;
        SET final_price = val_price*(1 - discount);
    ELSE
        SET final_price = val_price;
    END IF;
    RETURN final_price;
    END;
    |
    DELIMITER ;

--  check this trigger
DROP TRIGGER IF EXISTS insert_before_booking;
    DELIMITER |
    CREATE TRIGGER insert_before_booking
    BEFORE INSERT ON User_Booking
    FOR EACH ROW
    BEGIN
        SET NEW.final_price = calculateTotalPrice(
            (select route_id from scheduled_flight where schedule_id= NEW.schedule_id),
            NEW.seat_class_id, NEW.user_id);
        SET NEW.date_of_booking = CURDATE();
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
        IN class_type VARCHAR(15),
        IN seat_count INT
        )
    BEGIN
        CASE class_type
		WHEN 'Platinum' THEN
			SELECT
				subquery.schedule_id,
				subquery.route_id,
				subquery.scheduled_departure,
				subquery.scheduled_arrival,
				subquery.route_origin,
				subquery.route_destination,
				scp.price,
				origin.airport_name as airport_origin,
				dest.airport_name as airport_dest
			FROM (
				SELECT 
					sf.schedule_id, 
					r.route_id, 
					sf.scheduled_departure, 
					sf.scheduled_arrival, 
					r.route_origin, 
					r.route_destination
				FROM Scheduled_Flight sf
				JOIN Aircraft a ON sf.aircraft_id = a.aircraft_id
				JOIN Aircraft_Model am ON a.model_id = am.model_id
				JOIN Route r ON sf.route_id = r.route_id
				WHERE
					r.route_origin = origin_code
					AND r.route_destination = destination_code
					AND DATE(sf.scheduled_departure) = DATE(departure_time)
					AND DATE(sf.scheduled_departure) >= NOW()
			) AS subquery
			LEFT JOIN Seat_Class_Price scp ON subquery.route_id = scp.route_id AND seat_class_id = 1
			JOIN airport as origin on origin.airport_code = subquery.route_origin
			JOIN airport as dest on dest.airport_code = subquery.route_destination; 
                    
		WHEN 'Business' THEN
			SELECT
				subquery.schedule_id,
				subquery.route_id,
				subquery.scheduled_departure,
				subquery.scheduled_arrival,
				subquery.route_origin,
				subquery.route_destination,
				scp.price,
				origin.airport_name as airport_origin,
				dest.airport_name as airport_dest
			FROM (
				SELECT 
					sf.schedule_id, 
					r.route_id, 
					sf.scheduled_departure, 
					sf.scheduled_arrival, 
					r.route_origin, 
					r.route_destination
				FROM Scheduled_Flight sf
				JOIN Aircraft a ON sf.aircraft_id = a.aircraft_id
				JOIN Aircraft_Model am ON a.model_id = am.model_id
				JOIN Route r ON sf.route_id = r.route_id
				WHERE
					r.route_origin = origin_code
					AND r.route_destination = destination_code
					AND DATE(sf.scheduled_departure) = DATE(departure_time)
					AND DATE(sf.scheduled_departure) >= NOW()
			) AS subquery
			LEFT JOIN Seat_Class_Price scp ON subquery.route_id = scp.route_id AND seat_class_id = 2
			JOIN airport as origin on origin.airport_code = subquery.route_origin
			JOIN airport as dest on dest.airport_code = subquery.route_destination; 
                        
		WHEN 'Economy' THEN
			SELECT
				subquery.schedule_id,
				subquery.route_id,
				subquery.scheduled_departure,
				subquery.scheduled_arrival,
				subquery.route_origin,
				subquery.route_destination,
				scp.price,
				origin.airport_name as airport_origin,
				dest.airport_name as airport_dest
			FROM (
				SELECT 
					sf.schedule_id, 
					r.route_id, 
					sf.scheduled_departure, 
					sf.scheduled_arrival, 
					r.route_origin, 
					r.route_destination
				FROM Scheduled_Flight sf
				JOIN Aircraft a ON sf.aircraft_id = a.aircraft_id
				JOIN Aircraft_Model am ON a.model_id = am.model_id
				JOIN Route r ON sf.route_id = r.route_id
				WHERE
					r.route_origin = origin_code
					AND r.route_destination = destination_code
					AND DATE(sf.scheduled_departure) = DATE(departure_time)
					AND DATE(sf.scheduled_departure) >= NOW()
			) AS subquery
			LEFT JOIN Seat_Class_Price scp ON subquery.route_id = scp.route_id AND seat_class_id = 3
			JOIN airport as origin on origin.airport_code = subquery.route_origin
			JOIN airport as dest on dest.airport_code = subquery.route_destination;
		END CASE;
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
        email VARCHAR(50),
        sch_id INT,
        seat_id VARCHAR(5),
        sc_id INT
    )
    BEGIN
        DECLARE new_user_id INT;
		DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
            BEGIN
                -- Rollback the transaction if any query fails
                ROLLBACK;
                RESIGNAL;
            END;

        -- here the data are not checked for uniqueness, a user can run in user state multiple times

        -- create the user first
        INSERT INTO User (user_state)
        VALUES ("Guest");
        
        SET new_user_id = LAST_INSERT_ID();
        
        -- create the guest user
        INSERT INTO Guest_User (user_id, name, address, birth_date, gender, passport_no, email) 
        VALUES (new_user_id, name, address, dob, gender, passport, email);
        
        INSERT INTO user_booking(schedule_id, seat_id, seat_class_id, user_id)
        VALUES (sch_id, seat_id, sc_id, new_user_id);
        COMMIT;
    END;
    |
    DELIMITER ;

DROP PROCEDURE if exists InsertAircraftSeats;
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

-- changed the field_names to existing ones
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
        SELECT registered_user_category INTO user_category
        FROM User_Category
        WHERE booking_count >= min_bookings
        ORDER BY min_bookings DESC
        LIMIT 1;
        
        -- Update the user category
        UPDATE Registered_User
        SET registered_user_category = user_category
        WHERE user_id = NEW.user_id;
        end block;
    END;
    |

    DELIMITER ;

DROP FUNCTION IF EXISTS get_seating_capacity_by_class;
    DELIMITER |
    CREATE FUNCTION get_seating_capacity_by_class(scheduleID INT, seat_class_name varchar(15))
    RETURNS INT
    BEGIN
        DECLARE aircraftID VARCHAR(20);
        DECLARE seating_capacity INT;
        
        SELECT aircraft_id INTO aircraftID 
        FROM Scheduled_Flight
        WHERE schedule_id = scheduleID;
        
        SELECT
            CASE
                WHEN seat_class_name = 'Economy' THEN economy_seats
                WHEN seat_class_name = 'Business' THEN business_seats
                WHEN seat_class_name = 'Platinum' THEN platinum_seats
                ELSE 0
            END INTO seating_capacity
        FROM Aircraft_Model am
        JOIN Aircraft a ON am.model_id = a.model_id
        WHERE a.aircraft_id = aircraftID;
        RETURN seating_capacity;
    END;
    |
    DELIMITER ;

DROP PROCEDURE IF EXISTS get_booked_seat_info_by_class;
    DELIMITER |
    CREATE PROCEDURE get_booked_seat_info_by_class(
        IN scheduleID INT,
        IN className varchar(15)
    )
    BEGIN
        DECLARE aircraftID VARCHAR(20);
        DECLARE seatInfo VARCHAR(255);
        
        SELECT aircraft_id INTO aircraftID
        FROM Scheduled_Flight
        WHERE schedule_id = scheduleID;
        
        SELECT GROUP_CONCAT(DISTINCT ab.seat_id) INTO seatInfo
        FROM User_Booking ub
        JOIN Aircraft_Seat ab ON ub.seat_id = ab.seat_id
        JOIN Seating_Class sc ON ub.seat_class_id = sc.class_id
        WHERE ub.schedule_id = scheduleID AND sc.class_name = className;
        
        SELECT seatInfo AS 'Booked_Seats';
    END;
    |
    DELIMITER ;

DELIMITER //