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