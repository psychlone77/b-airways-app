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
-- password is not hashed because of the manual insert statements
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
INSERT INTO Airport VALUES ('BKK', 13, 'Suvarnabhumi Airport');
INSERT INTO Airport VALUES ('DMK', 14, 'Don Mueang International Airport');
INSERT INTO Airport VALUES ('SIN', 15, 'Changi Airport');


-- ///////////////////////////changed for the given models
-- Insert statements for Aircraft_Model
INSERT INTO Aircraft_Model VALUES ('A320', 'Airbus A380', 'Airbus', 150, 12, 4);
INSERT INTO Aircraft_Model VALUES ('B737', 'Boeing 737', 'Boeing', 160, 10, 6);
INSERT INTO Aircraft_Model VALUES ('B787', 'Boeing 757', 'Boeing', 240, 20, 8);

-- given no of aircrafts for the above models
INSERT INTO Aircraft (aircraft_id, model_id, curr_airport_code) VALUES 
-- change the airport_code to initial value
('A001', 'B737', "CGK"),
('A002', 'B737', "BIA"),
('A003', 'B737', "BKK"),
('A004', 'B757', "DEL"),
('A005', 'B757', "SIN"),
('A006', 'B757', "DPS"),
('A007', 'B757', "HRI"),
('A008', 'A380', "DEL");

-- 3 seating classes
INSERT INTO Seating_Class VALUES (1, 'Platinum');
INSERT INTO Seating_Class VALUES (2, 'Business');
INSERT INTO Seating_Class VALUES (3, 'Economy');



-- Insert 30 scheduled flights
INSERT INTO Route (route_id, route_origin, route_destination, route_duration)
VALUES 
('BA001', 'CGK', 'DPS', '01:00:00'), -- return 3
('BA002', 'CGK', 'BIA', '02:00:00'), -- return 5
('BA003', 'DPS', 'CGK', '01:00:00'), -- return 1
('BA004', 'DPS', 'BIA', '03:00:00'), -- return 6
('BA005', 'BIA', 'CGK', '02:00:00'), -- return 2
('BA006', 'BIA', 'DPS', '03:00:00'), -- return 4
('BA007', 'HRI', 'DEL', '01:30:00'), -- return 9
('BA008', 'HRI', 'BOM', '02:30:00'), -- return 11
('BA009', 'DEL', 'HRI', '01:30:00'), -- return 7
('BA010', 'DEL', 'BOM', '02:00:00'), -- return 12
('BA011', 'BOM', 'HRI', '02:30:00'), -- return 8
('BA012', 'BOM', 'DEL', '02:00:00'), -- return 10
('BA013', 'MAA', 'BKK', '03:00:00'), -- return 15
('BA014', 'MAA', 'DMK', '03:30:00'), -- return 17
('BA015', 'BKK', 'MAA', '03:00:00'), -- return 13
('BA016', 'BKK', 'DMK', '01:00:00'), -- return 18
('BA017', 'DMK', 'MAA', '03:30:00'), -- return 14
('BA018', 'DMK', 'BKK', '01:00:00'), -- return 16
('BA019', 'SIN', 'BKK', '02:30:00'), -- return 20 
('BA020', 'BKK', 'SIN', '02:00:00'), -- return 19
('BA021', 'CGK', 'DEL', '02:30:00'), -- return 22
('BA022', 'DEL', 'CGK', '02:00:00'), -- return 21
('BA023', 'BOM', 'MAA', '02:00:00'), -- return 24
('BA024', 'MAA', 'BOM', '02:00:00') -- return 23

-- insert scheduled flights

-- CALL insert_scheduled_flight('BA002', 'A001', '2023-10-30 05:00:00');
