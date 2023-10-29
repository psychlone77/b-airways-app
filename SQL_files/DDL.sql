-- pls add some comments where you change 
-- schedule_arrival now can be set null
-- removed booking seat table
-- added 2 fields to User_Booking table


drop database ars;
create database ars;
use ars;
DROP TABLE IF EXISTS Organizational_Info;
DROP TABLE IF EXISTS User CASCADE;
DROP TABLE IF EXISTS Contact_No CASCADE;
DROP TABLE IF EXISTS Registered_User CASCADE;
DROP TABLE IF EXISTS User_Category CASCADE;
DROP TABLE IF EXISTS Guest_User CASCADE;
DROP TABLE IF EXISTS Administrator CASCADE;
DROP TABLE IF EXISTS Location CASCADE;
DROP TABLE IF EXISTS Aircraft_Model CASCADE;
DROP TABLE IF EXISTS Airport CASCADE;
DROP TABLE IF EXISTS Aircraft CASCADE;
DROP TABLE IF EXISTS Seating_Class CASCADE;
DROP TABLE IF EXISTS Aircraft_Seat CASCADE;
DROP TABLE IF EXISTS Route CASCADE;
DROP TABLE IF EXISTS Seat_Class_Price CASCADE;
DROP TABLE IF EXISTS Scheduled_Flight CASCADE;
DROP TABLE IF EXISTS User_Booking CASCADE;
DROP TABLE IF EXISTS Booking_Seat CASCADE;

CREATE TABLE Organizational_Info (
  airline_name varchar(30) NOT NULL,
  airline_hotline varchar(20) NOT NULL,
  airline_email varchar(50) NOT NULL,
  address varchar(100) NOT NULL,
  airline_account_no varchar(30) NOT NULL,
  PRIMARY KEY (airline_name)
);

CREATE TABLE User (
  user_id int auto_increment,
  user_state ENUM('guest','registered') NOT NULL,
  PRIMARY KEY (user_id)
);

CREATE TABLE User_Category (
  registered_user_category ENUM('General','Frequent','Gold'),
  discount_percentage NUMERIC(4,2) NOT NULL,
  min_bookings SMALLINT NOT NULL,
  PRIMARY KEY (registered_user_category)
);

CREATE TABLE Registered_User (
  user_id int,
  registered_user_category ENUM('General','Frequent','Gold') NOT NULL DEFAULT 'General', -- Default no category
  email VARCHAR(100) NOT NULL UNIQUE,
  password varchar(72) NOT NULL, --changed the var length , to accept a hashed password
  first_name VARCHAR(30) NOT NULL,
  last_name VARCHAR(30) NOT NULL,
  birth_date DATE NOT NULL,
  gender ENUM('Male','Female','Other'), 
  passport_no VARCHAR(9) NOT NULL unique, -- per the standard
  address varchar(255) NOT NULL,
  joined_datetime datetime DEFAULT NOW() NOT NULL,
  PRIMARY KEY (user_id),
  FOREIGN KEY(user_id) REFERENCES user(user_id) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY(registered_user_category) REFERENCES User_Category(registered_user_category) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Contact_No (
    user_id INT,
    contact_no VARCHAR(15), -- do we need unique
    PRIMARY KEY (user_id , contact_no),
    FOREIGN KEY (user_id)
        REFERENCES user (user_id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Guest_User(
  user_id int,
  name VARCHAR(50) NOT NULL,
  address varchar(255) NOT NULL,
  birth_date DATE NOT NULL,
  gender ENUM('Male','Female','Other'),
  passport_no VARCHAR(9) NOT NULL,
  -- mobile VARCHAR(15) NOT NULL, -- remvoed this and added mobile no to contact_no table
  email VARCHAR(254) NOT NULL,   -- email and passport no can repeat, a user can continue in guest mode for multiple times
  PRIMARY KEY (user_id),
  FOREIGN KEY(user_id) REFERENCES User(user_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Administrator (
  user_id int,
  admin_role varchar(20) NOT NULL,
  admin_name varchar(20) NOT NULL,
  password varchar(255) NOT NULL,
  PRIMARY KEY (user_id)
);

CREATE TABLE Location (
  location_id int auto_increment,
  parent_id int,
  location_name varchar(50) NOT NULL,
  PRIMARY KEY (location_id),
  FOREIGN KEY(parent_id) REFERENCES Location(location_id)
);

CREATE TABLE Aircraft_Model (
  model_id varchar(4),
  model_name varchar(30) NOT NULL,
  manufacturer_name varchar(30) NOT NULL,
  economy_seats int NOT NULL,
  business_seats int NOT NULL,
  platinum_seats int NOT NULL,
  PRIMARY KEY (model_id)
);

CREATE TABLE Airport (
  airport_code varchar(4),
  location_id int NOT NULL,
  airport_name varchar(100),
  PRIMARY KEY (airport_code),
  FOREIGN KEY(location_id) REFERENCES Location(location_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Aircraft (
  aircraft_id varchar(20),
  model_id varchar(4),
  curr_airport_code varchar(4),
  PRIMARY KEY (aircraft_id),
  FOREIGN KEY(model_id) REFERENCES Aircraft_model(model_id) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY(curr_airport_code) REFERENCES Airport(airport_code) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Seating_Class (
  class_id int auto_increment,
  class_name varchar(15),
  PRIMARY KEY (class_id)
);

CREATE TABLE Aircraft_Seat (
  seat_id varchar(5),
  aircraft_id varchar(20),
  seat_class_id int,
  PRIMARY KEY (seat_id), 
  FOREIGN KEY(aircraft_id) REFERENCES Aircraft(aircraft_id) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY(seat_class_id) REFERENCES Seating_class(class_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Route (
  route_id varchar(10),
  route_origin varchar(4),
  route_destination varchar(4),
  route_duration time,
  PRIMARY KEY (route_id), 
  FOREIGN KEY(route_origin) REFERENCES Airport(airport_code) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY(route_destination) REFERENCES Airport(airport_code) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Seat_Class_Price(
  route_id varchar(10),
  seat_class_id int,
  price numeric (10,2),
  PRIMARY KEY(route_id, seat_class_id),
  FOREIGN KEY(route_id) REFERENCES Route(route_id) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY(seat_class_id) REFERENCES Seating_class(class_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Scheduled_Flight (
  schedule_id int auto_increment,
  aircraft_id varchar(20) NOT NULL,
  route_id VARCHAR(10) NOT NULL ,
  scheduled_departure datetime NOT NULL,
  scheduled_arrival datetime,
  true_departure datetime ,
  true_arrival datetime,
  flight_status ENUM('Scheduled','Departed-On-Time', 'Delayed-Departure', 'Landed','Cancelled') NOT NULL DEFAULT 'Scheduled',  -- change this
  PRIMARY KEY (schedule_id),
  FOREIGN KEY(route_id) REFERENCES Route(route_id) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY(aircraft_id) REFERENCES Aircraft(aircraft_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE User_Booking(
  booking_id int auto_increment,
  schedule_id int,
  seat_id varchar(5),
  user_id int,
  final_price numeric(10,2),
  booking_status varchar(10),
  date_of_booking datetime,
  PRIMARY KEY(booking_id),
  FOREIGN KEY(user_id) REFERENCES User(user_id) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY(schedule_id) REFERENCES Scheduled_Flight(schedule_id) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY(seat_id) REFERENCES Aircraft_Seat(seat_id) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY(class_id) REFERENCES Seating_Class(class_id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- CREATE TABLE Booking_Seat(
--   booking_id int,
--   seat_id varchar(5),
--   price numeric(10,2),
--   passenger_name varchar(100),
--   passenger_passport_no varchar(9),
--   birth_date date,
--   PRIMARY KEY(booking_id, seat_id),
--   FOREIGN KEY(booking_id) REFERENCES User_Booking(booking_id) ON DELETE CASCADE ON UPDATE CASCADE,
--   FOREIGN KEY(seat_id) REFERENCES Aircraft_Seat(seat_id) ON DELETE CASCADE ON UPDATE CASCADE
-- );