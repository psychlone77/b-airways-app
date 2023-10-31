-- All reports are yet to be checked

-- Report 1
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
            WHERE schedule_id = s_id AND calculateAge(birth_date) >= 18);
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


-- Report 2
-- Given a date range, number of passengers travelling to a given destination

DROP PROCEDURE IF EXISTS get_passengers_travelling_to_a_destination;
    DELIMITER |
    CREATE PROCEDURE get_passengers_travelling_to_a_destination(IN from_date DATETIME, IN to_date DATETIME, IN destination VARCHAR(4))
    BEGIN
        SELECT SUM(ub.seat_id) AS no_of_passengers
        FROM User_Booking ub INNER JOIN Scheduled_Flight sf ON ub.schedule_id = sf.schedule_id
                             INNER JOIN Route r ON sf.route_id = r.route_id
        WHERE from_date <= sf.scheduled_depature <= to_date AND
              r.route_destination = destination;        
    |
    DELIMITER ;

	
-- Report 3
-- Given a date range, number of bookings by each passenger type

DROP PROCEDURE IF EXISTS get_bookings_by_passenger_type;
    DELIMITER |
    CREATE PROCEDURE get_bookings_by_passenger_type(IN from_date DATETIME, IN to_date DATETIME, IN passenger_type int)
    BEGIN
        SELECT SUM(ub.seat_id) AS no_of_bookings
        FROM User_Booking ub INNER JOIN Scheduled_Flight sf ON ub.schedule_id = sf.schedule_id
                             INNER JOIN Aircraft_Seat ase ON ub.seat_id = ase.seat_id
        WHERE from_date <= sf.scheduled_depature <= to_date AND
              ase.seat_class_id = passenger_type;       
    |
    DELIMITER ;


-- Report 4
-- Given origin and destination, all past flights, states, passenger counts data

DROP PROCEDURE IF EXISTS get_past_flights;
    DELIMITER |
    CREATE PROCEDURE get_past_flights(IN origin VARCHAR(4), IN destination VARCHAR(4))
    BEGIN
        SELECT DISTINCT sf.schedule_id AS flight, 
               DISTINCT sf.flight_status AS state, 
               SUM(ub.seat_id) AS no_of_passengers
        FROM User_Booking ub INNER JOIN Scheduled_Flight sf ON ub.schedule_id = sf.schedule_id
                             INNER JOIN Route r ON sf.route_id = r.route_id                  
        WHERE r.route_origin = origin AND 
              r.route_destination = destination;      
    |
    DELIMITER ;
     
     	
-- Report 5
-- Total revenue generated by each Aircraft type

DROP PROCEDURE IF EXISTS get_revenue_by_aircraft_type;
    DELIMITER |
    CREATE PROCEDURE get_revenue_by_aircraft_type(IN aircraft_model VARCHAR(4))
    BEGIN
        SELECT SUM(ub.final_price) AS revenue
        FROM User_Booking ub INNER JOIN Scheduled_Flight sf ON ub.schedule_id = sf.schedule_id
                             INNER JOIN Aircraft a ON sf.aircraft_id = a.aircraft_id
        WHERE a.model_id = aircraft_model;   
    |
    DELIMITER ;