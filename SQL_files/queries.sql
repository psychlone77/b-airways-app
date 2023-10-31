-- SQL query to get the booked seats of an airplane for a specfic flight
SELECT ub.seat_id
FROM User_Booking ub
INNER JOIN Scheduled_Flight sf ON ub.schedule_id = sf.schedule_id
INNER JOIN Route r ON sf.route_id = r.route_id
INNER JOIN Seat_Class_Price scp ON r.route_id = scp.route_id
INNER JOIN Seating_Class sc ON scp.seat_class_id = sc.class_id
WHERE sc.class_name = 'ClassName' 
AND ub.booking_status = 'Booked'; 


-- SQL insert statement to add passengers info into booking seats table (should be a prepared statement)
INSERT INTO Booking_Seat (passenger_name, passenger_passport_no, birth_date) VALUES (?, ?, ?);

