-- Report 1
-- Given a flight no, all passengers travelling in it (next immediate flight) below age 18, above age 18 

-- passenger_name,passport_no,birth_date
-- passenger_info view is created for this

DROP PROCEDURE IF EXISTS get_passengers_in_flight;
    DELIMITER |
    CREATE PROCEDURE get_passengers_in_flight(IN val_route_id VARCHAR(10))
    BEGIN
        DECLARE s_id INT;
        DECLARE birth_date DATE;
        
        -- Find the next immediate flight for the given route
        SELECT schedule_id INTO s_id
        FROM Scheduled_Flight
        WHERE route_id = val_route_id AND scheduled_departure > NOW()
        ORDER BY scheduled_departure ASC
        LIMIT 1;
        
        SELECT name, passport_no,
        CASE
           WHEN calculateAge(passenger_info.birth_date) >= 18 THEN 'Above 18'
           ELSE 'Below 18'
        END AS age_group
        FROM passenger_info
        LEFT JOIN User_Booking ON passenger_info.user_id = User_Booking.user_id
        WHERE User_Booking.schedule_id = s_id
        order by age_group desc;
    END 
    |
    DELIMITER ;


-- Report 2
-- Given a date range, number of passengers travelling to a given destination

DROP PROCEDURE IF EXISTS get_passengers_travelling_to_a_destination;
    DELIMITER |
    CREATE PROCEDURE get_passengers_travelling_to_a_destination(IN from_date DATETIME, IN to_date DATETIME, IN destination VARCHAR(4))
    BEGIN
        SELECT COUNT(DISTINCT ub.booking_id) AS no_of_passengers
        FROM User_Booking ub INNER JOIN Scheduled_Flight sf ON ub.schedule_id = sf.schedule_id
                             INNER JOIN Route r ON sf.route_id = r.route_id
		WHERE (sf.scheduled_departure BETWEEN from_date AND to_date) AND
              r.route_destination = destination;        
    END
    |
    DELIMITER ;

	
-- Report 3
-- Given a date range, number of bookings by each passenger type

DROP PROCEDURE IF EXISTS get_bookings_by_passenger_type;
    DELIMITER |
    CREATE PROCEDURE get_bookings_by_passenger_type(IN from_date DATETIME, IN to_date DATETIME)
    BEGIN
		SELECT 
		sc.class_name,
		COUNT(DISTINCT ub.booking_id) 
		AS no_of_bookings
				FROM User_Booking AS ub
				JOIN seating_class AS sc on sc.class_id = ub.seat_class_id
				WHERE (ub.date_of_booking BETWEEN from_date AND to_date)
		GROUP BY seat_class_id;  
    END
    |
    DELIMITER ;


-- Report 4
-- Given origin and destination, all past flights, states, passenger counts data

DROP PROCEDURE IF EXISTS get_past_flights;
    DELIMITER |
    CREATE PROCEDURE get_past_flights(IN origin VARCHAR(4), IN destination VARCHAR(4))
    BEGIN
        SELECT DISTINCT sf.schedule_id AS flight, 
			   sf.aircraft_id,
               sf.flight_status AS state,
               COUNT(ub.booking_id) AS no_of_passengers
        FROM User_Booking ub INNER JOIN Scheduled_Flight sf ON ub.schedule_id = sf.schedule_id
                             INNER JOIN Route r ON sf.route_id = r.route_id                  
        WHERE r.route_origin = origin AND 
              r.route_destination = destination AND
              sf.scheduled_departure < NOW()
		GROUP BY sf.schedule_id, sf.flight_status;
    END
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
    END
    |
    DELIMITER ;