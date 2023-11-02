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
    
-- 
DROP VIEW IF EXISTS discounts;    
    CREATE VIEW discounts AS
    SELECT 
        user_id,
        registered_user_category as category,
        (SELECT discount_percentage FROM user_category WHERE registered_user_category = Registered_User.registered_user_category) AS discount_percentage
    FROM Registered_User
    UNION
    SELECT 
        user_id,
        'guest' AS registered_user_category,
        0 AS discount_percentage
	FROM Guest_user;