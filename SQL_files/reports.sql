-- Given a flight no, all passengers travelling in it (next immediate flight) below age 18, above age 18 
-- passenger_name,passport_no,birth_date
-- passenger_info view is created for this

-- Create the procedure to get passengers above 18 in a flight
DROP PROCEDURE IF EXISTS get_passengers_above_18_in_flight;
    DELIMITER |
    CREATE PROCEDURE get_passengers_above_18_in_flight(IN val_route_id VARCHAR(10))
    BEGIN
        DECLARE s_id INT;
        DECLARE birth_date DATE;
        
        -- Find the next immediate flight for the given route
        SELECT schedule_id INTO s_id
        FROM Scheduled_Flight
        WHERE route_id = val_route_id AND scheduled_departure > NOW()
        ORDER BY scheduled_departure ASC
        LIMIT 1;
        
        SELECT * from passenger_info
        where user_id 
        in (
            SELECT user_id
            FROM User_Booking
            WHERE schedule_id = s_id AND calculateAge(birth_date) > 18);
    END 
    |
    DELIMITER ;

-- Create the procedure to get passengers below 18 in a flight
DROP PROCEDURE IF EXISTS get_passengers_below_18_in_flight;
    DELIMITER |
    CREATE PROCEDURE get_passengers_below_18_in_flight(IN val_route_id VARCHAR(10))
    BEGIN
        DECLARE s_id INT;
        DECLARE birth_date DATE;
        
        -- Find the next immediate flight for the given route
        SELECT schedule_id INTO s_id
        FROM Scheduled_Flight
        WHERE route_id = val_route_id AND scheduled_departure > NOW()
        ORDER BY scheduled_departure ASC
        LIMIT 1;
        
        SELECT * from passenger_info
        where user_id 
        in (
            SELECT user_id
            FROM User_Booking
            WHERE schedule_id = s_id AND calculateAge(birth_date) < 18);
    END 
    |
    DELIMITER ;





-- Report 1 (not 100% sure, have to check)

SELECT u.user_id AS passengers_above_18, 
	   IF (u.user_state = 'registered', printf(ru.first_name + ru.last_name), gu.name) AS name,
       IF (u.user_state = 'registered', ru.passport_no, gu.passport_no) AS passport_no
FROM User_Booking ub INNER JOIN User u ON ub.user_id = u.user_id
					 LEFT OUTER JOIN Registered_User ru ON u.user_id = ru.user_id
                     LEFT OUTER JOIN Guest_User gu ON u.user_id = gu.user_id
WHERE ub.schedule_id = 'given_flight_no' AND
	  IF (u.user_state = 'registered', calculateAge(ru.birth_date), calculateAge(gu.birth_date)) >= 18;


SELECT u.user_id AS passengers_below_18, 
	   IF (u.user_state = 'registered', printf(ru.first_name + ru.last_name), gu.name) AS name,
       IF (u.user_state = 'registered', ru.passport_no, gu.passport_no) AS passport_no
FROM User_Booking ub INNER JOIN User u ON ub.user_id = u.user_id
					 LEFT OUTER JOIN Registered_User ru ON u.user_id = ru.user_id
                     LEFT OUTER JOIN Guest_User gu ON u.user_id = gu.user_id
WHERE ub.schedule_id = 'given_flight_no' AND
	  IF (u.user_state = 'registered', calculateAge(ru.birth_date), calculateAge(gu.birth_date)) < 18;


-- Report 2

SELECT SUM(ub.seat_id) AS no_of_passengers
FROM User_Booking ub INNER JOIN Scheduled_Flight sf ON ub.schedule_id = sf.schedule_id
                     INNER JOIN Route r ON sf.route_id = r.route_id
WHERE 'given_starting_date' <= sf.scheduled_depature <= 'given_ending_date' AND
	  r.route_destination = 'given destination';

	
-- Report 3

SELECT SUM(ub.seat_id) AS no_of_bookings
FROM User_Booking ub INNER JOIN Scheduled_Flight sf ON ub.schedule_id = sf.schedule_id
                     INNER JOIN Aircraft_Seat ase ON ub.seat_id = ase.seat_id
WHERE 'given_starting_date' <= sf.scheduled_depature <= 'given_ending_date' AND
	  ase.seat_class_id = 'passenger_type';


-- Report 4

SELECT sf.schedule_id AS flight, 
	   sf.flight_status AS state, 
       SUM(ub.seat_id) AS no_of_passengers
FROM User_Booking ub INNER JOIN Scheduled_Flight sf ON ub.schedule_id = sf.schedule_id
                     INNER JOIN Route r ON sf.route_id = r.route_id                  
WHERE r.route_origin = 'given_origin' AND 
	  r.route_destination = 'given_destination';
     
     	
-- Report 5

SELECT SUM(ub.final_price) AS revenue
FROM User_Booking ub INNER JOIN Scheduled_Flight sf ON ub.schedule_id = sf.schedule_id
					 INNER JOIN Aircraft a ON sf.aircraft_id = a.aircraft_id
WHERE a.model_id = 'aircraft type';