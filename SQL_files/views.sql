-- Create a view to get registered user details without password
DROP VIEW IF EXISTS Registered_User_Details;
    CREATE VIEW Registered_User_Details AS
    SELECT 
        user_id,
        registered_user_category,
        email,
        first_name,
        last_name,
        birth_date,
        gender,
        passport_no,
        address,
        joined_datetime
    FROM Registered_User;

-- Create the view for registered users and guest users
DROP VIEW IF EXISTS passenger_info;
    CREATE VIEW passenger_info AS
    SELECT user_id, passport_no, CONCAT(first_name, ' ',last_name) AS name, birth_date
    FROM Registered_User
    UNION
    SELECT user_id, passport_no, name, birth_date
    FROM Guest_User;