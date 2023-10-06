CREATE TYPE flight_state AS ENUM(
'Scheduled',
'Departed-On-Time',
'Delayed-Departure',
'Landed',
'Cancelled'
);

 CREATE TYPE aircraft_state AS ENUM( 
 'On-Ground',
 'In-Air');  

CREATE TYPE booking_state AS ENUM(
'Not paid',
'Paid'); 

CREATE TYPE gender AS ENUM(
'Male',
'Female',
'Other'); 

CREATE TYPE user AS ENUM(
'Guest',
'Registered'
);

CREATE TYPE registered_user_category AS ENUM(
'General',
'Frequent',
'Gold'
);

CREATE TYPE staff_category AS ENUM(
'admin',
'manager',
'general'
);

CREATE TYPE staff_account_state AS ENUM(
'verified',
'unverified'
);


-- Optional Table
CREATE TABLE Organizational_Info (
  airline_name  varchar(30) NOT NULL,
  airline_hotline varchar(20) NOT NULL,
  airline_email varchar(50) NOT NULL,
  address_1 varchar(100) NOT NULL,
  address_2 varchar(100) NOT NULL,
  address_3 varchar(100) NOT NULL,
  airline_account_no varchar(30) NOT NULL,
  PRIMARY KEY (airline_name)
);


CREATE TABLE User_Category (
  cat_name registered_user_category,
  discount_percentage NUMERIC(4,2) NOT NULL,
  min_bookings SMALLINT NOT NULL,
  PRIMARY KEY (cat_name)
);


CREATE TABLE User (
  user_id uuid4 DEFAULT generate_uuid4 (),
  type user_state NOT NULL,
  PRIMARY KEY (user_id)
);


CREATE TABLE Registered_User (
  user_id uuid4,
  email VARCHAR(127) NOT NULL UNIQUE,
  password varchar(255) NOT NULL,
  first_name VARCHAR(30) NOT NULL,
  last_name VARCHAR(30) NOT NULL,
  category  registered_user_category NOT NULL DEFAULT 'General', --Default no category
  birth_date DATE NOT NULL,
  gender gender_enum,
  contact_no VARCHAR(15) NOT NULL,
  passport_no VARCHAR(20) NOT NULL,
  address varchar(255) NOT NULL,
  no_of_bookings int NOT NULL DEFAULT 0,
  joined_timestamp TIMESTAMP DEFAULT NOW() NOT NULL,
  PRIMARY KEY (user_id),
  FOREIGN KEY(user_id) REFERENCES User(user_id) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY(category) REFERENCES User_Category(cat_name) ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE Seating_Class (
  class_id SERIAL,
  class_name varchar(10) NOT NULL UNIQUE,
  PRIMARY KEY (class_id)
);


CREATE TABLE Location (
  location_id SERIAL,
  location_name varchar(50) NOT NULL,
  parent_id int,
  PRIMARY KEY (location_id),
  FOREIGN KEY(parent_id) REFERENCES Location(location_id) ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE Airport (
  airport_code varchar(10),
  location_id int NOT NULL,
  destination_image text,
  PRIMARY KEY (airport_code),
  FOREIGN KEY(location_id) REFERENCES Location(location_id) ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE Aircraft_Model (
  model_id SERIAL,
  model_name varchar(30) NOT NULL,
  variant varchar(15) NOT NULL,
  manufacturer_name varchar(30) NOT NULL,
  economy_seat_capacity int NOT NULL,
  business_seat_capacity int NOT NULL,
  platinum_seat_capacity int NOT NULL,
  economy_seats_per_row int NOT NULL,
  business_seats_per_row int NOT NULL,
  platinum_seats_per_row int NOT NULL,
  max_load numeric(10,2), 
  fuel_capacity numeric(10,2),
  avg_airspeed int,
  image_link text,
  PRIMARY KEY (model_id)
);


CREATE TABLE Aircraft (
  aircraft_id SERIAL,
  model_id int NOT NULL,
  kilometers_flown int DEFAULT 0,
  PRIMARY KEY (aircraft_id),
  FOREIGN KEY (model_id) REFERENCES Aircraft_Model(model_id) on DELETE CASCADE on UPDATE CASCADE
);


CREATE TABLE Aircraft_Seat (
  aircraft_id int NOT NULL,
  seat_id varchar(10) NOT NULL,
  traveller_class_id int NOT NULL,
  PRIMARY KEY (aircraft_id,seat_id),
  FOREIGN KEY(aircraft_id) REFERENCES Aircraft(aircraft_id) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY(traveller_class_id) REFERENCES Seating_Class(class_id)  ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE Aircraft_Instance (
  aircraft_instance_id SERIAL,
  aircraft_id int NOT NULL,
  airport_code varchar(10),
  aircraft_state aircraft_state_enum NOT NULL,
  PRIMARY KEY (aircraft_instance_id),
  FOREIGN KEY(aircraft_id) REFERENCES Aircraft(aircraft_id) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY(airport_code) REFERENCES Airport(airport_code) ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE Route (
  route_id VARCHAR(10),
  route_origin varchar(10) NOT NULL,
  route_destination varchar(10) NOT NULL,
  duration interval NOT NULL,
  PRIMARY KEY (route_id),
  FOREIGN KEY(route_origin) REFERENCES Airport(airport_code) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY(route_destination) REFERENCES Airport(airport_code) ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE Scheduled_Flight (
  schedule_id SERIAL,
  route_id VARCHAR(10) NOT NULL ,
  aircraft_instance_id int NOT NULL,
  departure_date date NOT NULL,
  departure_time_utc time NOT NULL,
  arrival_date date generated always as (get_arrival(route_id,get_timestamp(departure_date,departure_time_utc))::DATE) stored NOT NULL,
  arrival_time_utc time generated always as (get_arrival(route_id,get_timestamp(departure_date,departure_time_utc))::TIME) stored NOT NULL,
  actual_departed TIMESTAMP,
  actual_arrival TIMESTAMP,
  flight_state flight_state_enum NOT NULL DEFAULT 'Scheduled',
  PRIMARY KEY (schedule_id),
  FOREIGN KEY(route_id) REFERENCES Route(route_id) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY(aircraft_instance_id) REFERENCES Aircraft_Instance(aircraft_instance_id) ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE Seat_Class_Price (
  route_id VARCHAR(10) NOT NULL,
  traveler_class_id int NOT NULL,
  price numeric(10,2) NOT NULL,
  PRIMARY KEY(route_id,traveler_class_id),
  FOREIGN KEY(route_id) REFERENCES Route(route_id) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY(traveler_class_id) REFERENCES Seating_Class(class_id) ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE User_Booking (
  booking_id SERIAL,
  user_id varchar(36) NOT NULL,
  schedule_id int NOT NULL,
  price_before_discount numeric(10,2) NOT NULL,
  final_price numeric(10,2) NOT NULL,
  state booking_state_enum NOT NULL,
  date_of_booking DATE NOT NULL DEFAULT NOW()::DATE,
  PRIMARY KEY (booking_id),
  FOREIGN KEY(user_id) REFERENCES User(user_id) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY(schedule_id) REFERENCES Scheduled_Flight(schedule_id) ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE Booking_Seat(
    booking_id int,
    aircraft_id int,
    seat_id varchar(10),
    price numeric(10, 2), 
    name varchar(100) NOT NULL,
    passport_no varchar(20) NOT NULL,
    birth_date date NOT NULL,
    PRIMARY KEY (booking_id, aircraft_id, seat_id),
    FOREIGN KEY(booking_id) REFERENCES User_Booking(booking_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY(aircraft_id,seat_id) REFERENCES Aircraft_Seat(aircraft_id,seat_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Staff (
  emp_id char(6) PRIMARY KEY, --Bxxxxx
  category staff_category NOT NULL,
  password varchar(255) NOT NULL,
  first_name varchar(127) NOT NULL,
  last_name varchar(127) NOT NULL,
  contact_no varchar(15) NOT NULL,
  email varchar(70) NOT NULL UNIQUE,
  birth_date date NOT NULL,
  gender gender_enum NOT NULL,
  country varchar(30) NOT NULL,
  assigned_airport varchar(10),
  account_state staff_account_state NOT NULL DEFAULT 'unverified',
  FOREIGN KEY(assigned_airport) REFERENCES Airport(airport_code) ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE Guest_User(
  user_id uuid4,
  name VARCHAR(50) NOT NULL,
  address varchar(255) NOT NULL,
  birth_date DATE NOT NULL,
  gender gender_enum,
  passport_no VARCHAR(20) NOT NULL,
  mobile VARCHAR(15) NOT NULL,
  email VARCHAR(127) NOT NULL,
  PRIMARY KEY (user_id),
  FOREIGN KEY(user_id) REFERENCES User(user_id) ON DELETE CASCADE ON UPDATE CASCADE
);
