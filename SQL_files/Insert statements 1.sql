-- pls add some comments where you change 

-- organizational info
INSERT INTO Organizational_Info VALUES('B Airways','+9411123456','customersupport@bairways.com','No1, Colombo, Sri Lanka','123456789');

-- user category final********
INSERT INTO user_category VALUES ('General','0','0');
INSERT INTO user_category VALUES ('Gold','0.05','10');
INSERT INTO user_category VALUES ('Frequent','0.09','50');

-- 10 entries for the user category table
INSERT INTO User VALUES (1,'registered');
INSERT INTO User VALUES (2,'guest');
INSERT INTO User VALUES (3,'registered');
INSERT INTO User VALUES (4,'registered');
INSERT INTO User VALUES (5,'guest');
INSERT INTO User VALUES (6,'guest');
INSERT INTO User VALUES (7,'registered');
INSERT INTO User VALUES (8,'registered');
INSERT INTO User VALUES (9,'registered');
INSERT INTO User VALUES (10,'guest');

-- 6 entries for the registered users table
-- make sure to add the necessary count of bookings for each user
INSERT INTO Registered_User VALUES (1, 'General', 'user1@example.com', 'password1', 'John', 'Doe', '1990-01-15', 'Male', '123456789', '123 Main St, City, Country', NOW());
INSERT INTO Registered_User VALUES (3, 'General', 'user3@example.com', 'password3', 'Jane', 'Smith', '1985-05-20', 'Female', '987654321', '456 Elm St, Town, Country', NOW());
INSERT INTO Registered_User VALUES (4, 'General', 'user4@example.com', 'password4', 'Michael', 'Johnson', '1978-11-10', 'Male', '234567890', '789 Oak St, Village, Country', NOW());
INSERT INTO Registered_User VALUES (7, 'General', 'user7@example.com', 'password7', 'Sarah', 'Williams', '1995-03-25', 'Female', '456789012', '567 Pine St, Suburb, Country', NOW());
INSERT INTO Registered_User VALUES (8, 'General', 'user8@example.com', 'password8', 'Robert', 'Brown', '1980-08-02', 'Male', '345678901', '890 Cedar St, Town, Country', NOW());
INSERT INTO Registered_User VALUES (9, 'General', 'user9@example.com', 'password9', 'Emily', 'Davis', '1987-07-15', 'Female', '567890123', '123 Oak St, City, Country', NOW());
-- 4 entries for the 4 guest users
INSERT INTO Guest_User VALUES (2, 'Guest User 2', '123 Main St, City, Country', '1995-01-01', 'Male', 'G12345678', 'guest2@example.com');
INSERT INTO Guest_User VALUES (5, 'Guest User 5', '456 Elm St, Town, Country', '1990-05-05', 'Female', 'G23456789', 'guest5@example.com');
INSERT INTO Guest_User VALUES (6, 'Guest User 6', '789 Oak St, Village, Country', '1985-10-10', 'Other', 'G34567890', 'guest6@example.com');
INSERT INTO Guest_User VALUES (10, 'Guest User 10', '123 Oak St, City, Country', '1998-12-31', 'Male', 'G78901234', 'guest10@example.com');

-- Insert contact numbers (11) for 10 users
INSERT INTO Contact_No VALUES (1, '1234567890');
INSERT INTO Contact_No VALUES (1, '0987654321');
INSERT INTO Contact_No VALUES (2, '5555555555');
INSERT INTO Contact_No VALUES (3, '1111111111');
INSERT INTO Contact_No VALUES (4, '2222222222');
INSERT INTO Contact_No VALUES (5, '3333333333');
INSERT INTO Contact_No VALUES (6, '4444444444');
INSERT INTO Contact_No VALUES (7, '7777777777');
INSERT INTO Contact_No VALUES (8, '8888888888');
INSERT INTO Contact_No VALUES (9, '9999999999');
INSERT INTO Contact_No VALUES (10, '1234567894');

-- add 1 dummy admin_name when expanding the database add enums to admin admin_role
INSERT INTO Administrator VALUES (1, 'Supervisor', 'johnDoe', 'adminpass');

-- changed for the given locations
-- locations
-- countries
INSERT INTO Location VALUES (1, NULL, 'Indonesia');
INSERT INTO Location VALUES (2, NULL, 'Sri Lanka');
INSERT INTO Location VALUES (3, NULL, 'India');
INSERT INTO Location VALUES (4, NULL, 'Thailand');
INSERT INTO Location VALUES (5, NULL, 'Singapore');
-- cities
INSERT INTO Location VALUES (6, 1, 'Jakarta');
INSERT INTO Location VALUES (7, 1, 'Bali');
INSERT INTO Location VALUES (8, 2, 'Katunayaka');
INSERT INTO Location VALUES (9, 2, 'Hambantota');
INSERT INTO Location VALUES (10, 3, 'NewDelhi');
INSERT INTO Location VALUES (11, 3, 'Mumbai');
INSERT INTO Location VALUES (12, 3, 'Chennai');
INSERT INTO Location VALUES (13, 4, 'Bangphli');
INSERT INTO Location VALUES (14, 4, 'Don Mueang');
INSERT INTO Location VALUES (15, 5, 'Singapore');

-- Insert airports for the 10 cities
INSERT INTO Airport VALUES ('CGK', 6,'Soekarno-Hatta International Airport');
INSERT INTO Airport VALUES ('DPS', 7, 'Ngurah Rai International Airport');
INSERT INTO Airport VALUES ('BIA', 8, 'Bandaranaike International Airport');
INSERT INTO Airport VALUES ('HRI', 9, 'Mattala Rajapaksa International Airport');
INSERT INTO Airport VALUES ('DEL', 10, 'Indira Gandhi International Airport');
INSERT INTO Airport VALUES ('BOM', 11, 'Chhatrapati Mahraj International Airport');
INSERT INTO Airport VALUES ('MAA', 12, 'Chennai International Airport');
INSERT INTO Airport VALUES ('BKK', 13, 'Suvarnabhumi Airport'),
INSERT INTO Airport VALUES ('DMK', 14, 'Don Mueang International Airport');
INSERT INTO Airport VALUES ('SIN', 15, 'Changi Airport');


-- ///////////////////////////changed for the given models
-- Insert statements for Aircraft_Model
INSERT INTO Aircraft_Model VALUES ('A320', 'Airbus A380', 'Airbus', 150, 12, 4);
INSERT INTO Aircraft_Model VALUES ('B737', 'Boeing 737', 'Boeing', 160, 10, 6);
INSERT INTO Aircraft_Model VALUES ('B787', 'Boeing 757', 'Boeing', 240, 20, 8);

-- given no of aircrafts for the above models
INSERT INTO Aircraft VALUES ('B737-001', 'B737', NULL);
INSERT INTO Aircraft VALUES ('B737-002', 'B737', NULL);
INSERT INTO Aircraft VALUES ('B737-003', 'B737', NULL);
INSERT INTO Aircraft VALUES ('B757-001', 'B757', NULL);
INSERT INTO Aircraft VALUES ('B757-002', 'B757', NULL);
INSERT INTO Aircraft VALUES ('B757-003', 'B757', NULL);
INSERT INTO Aircraft VALUES ('B757-004', 'B757', NULL);
INSERT INTO Aircraft VALUES ('A380-001', 'A380', NULL);

-- 3 seating classes
INSERT INTO Seating_Class VALUES (1, 'Platinum');
INSERT INTO Seating_Class VALUES (2, 'Business');
INSERT INTO Seating_Class VALUES (3, 'Economy');



-- Insert 30 scheduled flights
INSERT INTO Route (route_id, route_origin, route_destination, route_duration)
VALUES 
('R001', 'CGK', 'DPS', '01:00:00'), -- return 3
('R002', 'CGK', 'BIA', '02:00:00'), -- return 5
('R003', 'DPS', 'CGK', '01:00:00'), -- return 1
('R004', 'DPS', 'BIA', '03:00:00'), -- return 6
('R005', 'BIA', 'CGK', '02:00:00'), -- return 2
('R006', 'BIA', 'DPS', '03:00:00'), -- return 4
('R007', 'HRI', 'DEL', '01:30:00'), -- return 9
('R008', 'HRI', 'BOM', '02:30:00'), -- return 11
('R009', 'DEL', 'HRI', '01:30:00'), -- return 7
('R010', 'DEL', 'BOM', '02:00:00'), -- return 12
('R011', 'BOM', 'HRI', '02:30:00'), -- return 8
('R012', 'BOM', 'DEL', '02:00:00'), -- return 10
('R013', 'MAA', 'BKK', '03:00:00'), -- return 15
('R014', 'MAA', 'DMK', '03:30:00'), -- return 17
('R015', 'BKK', 'MAA', '03:00:00'), -- return 13
('R016', 'BKK', 'DMK', '01:00:00'), -- return 18
('R017', 'DMK', 'MAA', '03:30:00'), -- return 14
('R018', 'DMK', 'BKK', '01:00:00'), -- return 16
('R019', 'SIN', 'BKK', '02:30:00'), -- return 34 
('R020', 'SIN', 'BIA', '02:00:00'), -- return 23
('R021', 'HRI', 'MAA', '01:30:00'), -- return 28
('R022', 'BIA', 'MAA', '02:30:00'), -- return 27
('R023', 'BIA', 'SIN', '04:00:00'), -- return 20
('R024', 'HRI', 'BKK', '03:00:00'), -- return 32
('R025', 'HRI', 'DMK', '03:30:00'), -- return 35
('R026', 'HRI', 'SIN', '05:00:00'), -- return 39
('R027', 'MAA', 'BIA', '02:30:00'), -- return 22
('R028', 'MAA', 'HRI', '03:00:00'), -- return 21
('R029', 'MAA', 'BKK', '03:30:00'), -- return 33
('R030', 'MAA', 'DMK', '04:00:00'), -- return 36
('R031', 'MAA', 'SIN', '04:30:00'), -- return 40
('R032', 'BKK', 'HRI', '03:00:00'), -- return 24
('R033', 'BKK', 'MAA', '03:30:00'), -- return 29
('R034', 'BKK', 'SIN', '02:30:00'), -- return 19
('R035', 'DMK', 'HRI', '03:30:00'), -- return 25
('R036', 'DMK', 'MAA', '04:00:00'), -- return 30
('R037', 'DMK', 'SIN', '02:00:00'), -- return 38
('R038', 'SIN', 'DMK', '04:00:00'), -- return 37
('R039', 'SIN', 'HRI', '05:00:00'), -- return 26
('R040', 'SIN', 'MAA', '04:30:00'); -- return 31

INSERT INTO Scheduled_Flight (aircraft_id, route_id, scheduled_departure)
VALUES 
-- JFK departures
('ACFT1', 'R001', '2023-11-01 06:10:00'), -- JFK to LAX
('ACFT2', 'R002', '2023-11-01 06:35:00'), -- JFK to SFO
('ACFT3', 'R003', '2023-11-01 07:00:00'), -- JFK to LHR
('ACFT4', 'R004', '2023-11-01 10:30:00'), -- JFK to CMB

-- LAX departures
('ACFT5', 'R005', '2023-11-01 05:25:00'), -- LAX to JFK
('ACFT1', 'R006', '2023-11-01 01:25:00'), -- LAX to SFO
('ACFT2', 'R007', '2023-11-01 10:25:00'), -- LAX to LHR
('ACFT3', 'R008', '2023-11-01 21:10:00'), -- LAX to CMB

-- LHR departures
('ACFT4', 'R009', '2023-11-01 08:05:00'), -- LHR to JFK
('ACFT5', 'R010', '2023-11-01 05:30:00'), -- LHR to LAX
('ACFT1', 'R011', '2023-11-01 11:20:00'), -- LHR to SFO
('ACFT2', 'R012', '2023-11-01 03:45:00'), -- LHR to CMB

-- CMB departures
('ACFT3', 'R013', '2023-11-01 14:05:00'), -- CMB to JFK
('ACFT4', 'R014', '2023-11-01 16:15:00'), -- CMB to LAX
('ACFT5', 'R015', '2023-11-01 15:45:00'), -- CMB to SFO

-- Return flights
-- LAX to JFK
('ACFT1', 'R005', '2023-11-02 05:25:00'),
('ACFT2', 'R005', '2023-11-02 06:00:00'),
-- SFO to JFK
('ACFT3', 'R002', '2023-11-02 06:35:00'),
('ACFT4', 'R002', '2023-11-02 07:00:00'),
-- LHR to JFK
('ACFT5', 'R001', '2023-11-02 06:10:00'),
('ACFT1', 'R001', '2023-11-02 06:45:00'),
-- CMB to JFK
('ACFT2', 'R001', '2023-11-02 07:20:00'),
('ACFT3', 'R001', '2023-11-02 07:55:00'),

-- JFK departures
('ACFT4', 'R003', '2023-11-02 07:30:00'), -- JFK to LHR
('ACFT5', 'R012', '2023-11-02 10:00:00'), -- JFK to CMB

-- LAX departures
('ACFT1', 'R007', '2023-11-02 12:15:00'), -- LAX to LHR
('ACFT2', 'R008', '2023-11-02 18:00:00'), -- LAX to CMB

-- LHR departures
('ACFT3', 'R011', '2023-11-02 14:30:00'), -- LHR to SFO
('ACFT4', 'R012', '2023-11-02 16:45:00'), -- LHR to CMB

-- CMB departures
('ACFT5', 'R013', '2023-11-02 20:00:00'); -- CMB to JFK

