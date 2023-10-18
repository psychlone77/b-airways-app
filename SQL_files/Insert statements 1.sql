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
INSERT INTO Guest_User VALUES (2, 'Guest User 2', '123 Main St, City, Country', '1995-01-01', 'Male', 'G12345678', '1234567890', 'guest2@example.com');
INSERT INTO Guest_User VALUES (5, 'Guest User 5', '456 Elm St, Town, Country', '1990-05-05', 'Female', 'G23456789', '0987654321', 'guest5@example.com');
INSERT INTO Guest_User VALUES (6, 'Guest User 6', '789 Oak St, Village, Country', '1985-10-10', 'Other', 'G34567890', '5555555555', 'guest6@example.com');
INSERT INTO Guest_User VALUES (10, 'Guest User 10', '123 Oak St, City, Country', '1998-12-31', 'Male', 'G78901234', '7777777777', 'guest10@example.com');

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
INSERT INTO Administrator VALUES (1, 'John Doe', 'Superviser', 'adminpassword1');

-- locations
INSERT INTO Location VALUES (1, NULL, 'United States');
INSERT INTO Location VALUES (2, 1, 'New York');
INSERT INTO Location VALUES (3, 1, 'California');
INSERT INTO Location VALUES (4, 2, 'New York City');
INSERT INTO Location VALUES (5, 3, 'Los Angeles');
INSERT INTO Location VALUES (6, 3, 'San Francisco');
INSERT INTO Location VALUES (7, NULL, 'United Kingdom');
INSERT INTO Location VALUES (8, 7, 'London');
INSERT INTO Location VALUES (9, 8, 'Manchester');
INSERT INTO Location VALUES (10, 8, 'Birmingham');

-- airports for newyorkcity, los angeles, san francisco and london are added
INSERT INTO Airport VALUES ('JFK', 4, 'John F. Kennedy International Airport');
INSERT INTO Airport VALUES ('LGA', 4, 'LaGuardia Airport');
INSERT INTO Airport VALUES ('LAX', 5, 'Los Angeles International Airport');
INSERT INTO Airport VALUES ('SFO', 6, 'San Francisco International Airport');
INSERT INTO Airport VALUES ('LHR', 8, 'Heathrow Airport');

-- Insert statements for Aircraft_Model
INSERT INTO Aircraft_Model VALUES ('A320', 'Airbus A320', 'Airbus', 150, 12, 4);
INSERT INTO Aircraft_Model VALUES ('B737', 'Boeing 737', 'Boeing', 160, 10, 6);
INSERT INTO Aircraft_Model VALUES ('B787', 'Boeing 787', 'Boeing', 240, 20, 8);

-- 5 aircrafts for the above models
INSERT INTO Aircraft VALUES ('ACFT1', 'A320');
INSERT INTO Aircraft VALUES ('ACFT2', 'A320');
INSERT INTO Aircraft VALUES ('ACFT3', 'B737');
INSERT INTO Aircraft VALUES ('ACFT4', 'B787');
INSERT INTO Aircraft VALUES ('ACFT5', 'B787');

-- 3 seating classes
INSERT INTO Seating_Class VALUES (1, 'First_Class');
INSERT INTO Seating_Class VALUES (2, 'Business');
INSERT INTO Seating_Class VALUES (3, 'Economy');

-- 3 routes
INSERT INTO Route VALUES ('R001', 'JFK', 'LAX', '05:30:00');
INSERT INTO Route VALUES ('R002', 'LAX', 'SFO', '01:30:00');
INSERT INTO Route VALUES ('R003', 'LHR', 'JFK', '07:00:00');

-- 3 aircraft instances
INSERT INTO Aircraft_Instance VALUES (NULL, 'ACFT1', 'JFK', 'On-Ground');
INSERT INTO Aircraft_Instance VALUES (NULL, 'ACFT3', 'LAX', 'On-Ground');
INSERT INTO Aircraft_Instance VALUES (NULL, 'ACFT5', 'LHR', 'On-Ground');


