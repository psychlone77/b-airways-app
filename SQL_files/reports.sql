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

