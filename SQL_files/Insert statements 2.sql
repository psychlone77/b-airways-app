-- Insert routes
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
    ('BA020', 'BKK', 'SIN', '02:30:00'), -- return 19
    ('BA021', 'CGK', 'DEL', '02:30:00'), -- return 22
    ('BA022', 'DEL', 'CGK', '02:00:00'), -- return 21
    ('BA023', 'BOM', 'MAA', '02:00:00'), -- return 24
    ('BA024', 'MAA', 'BOM', '02:00:00'), -- return 23
    ('BA025', 'HRI', 'BKK', '02:00:00'), -- return 25
    ('BA026', 'BKK', 'HRI', '02:00:00'); -- return 26

-- changed the schedule so that no two flights are landing or departing at the same airport at the same time
-- insert scheduled flights
    -- aircraft_1
        CALL insert_scheduled_flight('BA002', 'A001', '2023-10-30 05:00:00'); -- 1
        CALL insert_scheduled_flight('BA005', 'A001', '2023-10-31 05:00:00'); -- 2
        CALL insert_scheduled_flight('BA021', 'A001', '2023-11-02 08:00:00'); -- 3
        CALL insert_scheduled_flight('BA022', 'A001', '2023-11-03 09:00:00'); -- 4

    -- aircraft_2
        CALL insert_scheduled_flight('BA006', 'A002', '2023-11-01 05:00:00'); -- 5
        CALL insert_scheduled_flight('BA004', 'A002', '2023-11-02 10:00:00'); -- 6
        CALL insert_scheduled_flight('BA006', 'A002', '2023-11-04 05:00:00'); -- 7
        CALL insert_scheduled_flight('BA004', 'A002', '2023-11-05 10:00:00'); -- 8

    -- aircraft_3
        CALL insert_scheduled_flight('BA015', 'A003', '2023-10-30 05:00:00'); -- 9
        CALL insert_scheduled_flight('BA014', 'A003', '2023-11-01 05:00:00'); -- 10
        CALL insert_scheduled_flight('BA018', 'A003', '2023-11-04 06:00:00'); -- 11

    -- aircraft_4
        CALL insert_scheduled_flight('BA009', 'A004', '2023-10-30 05:00:00'); -- 12
        CALL insert_scheduled_flight('BA008', 'A004', '2023-10-31 07:00:00'); -- 13 
        CALL insert_scheduled_flight('BA011', 'A004', '2023-11-01 07:00:00'); -- 14
        CALL insert_scheduled_flight('BA007', 'A004', '2023-11-02 05:00:00'); -- 15

    -- aircraft_5
        CALL insert_scheduled_flight('BA019', 'A005', '2023-10-31 05:00:00'); -- 16
        CALL insert_scheduled_flight('BA020', 'A005', '2023-11-02 05:00:00'); -- 17
        CALL insert_scheduled_flight('BA019', 'A005', '2023-11-03 05:00:00'); -- 18
        CALL insert_scheduled_flight('BA020', 'A005', '2023-11-05 05:00:00'); -- 19

    -- aircraft_6 (6 is entirely within indonesia)
        CALL insert_scheduled_flight('BA003', 'A006', '2023-10-31 08:00:00'); -- 20
        CALL insert_scheduled_flight('BA001', 'A006', '2023-11-01 10:00:00'); -- 21
        CALL insert_scheduled_flight('BA003', 'A006', '2023-11-02 08:00:00'); -- 22 
        CALL insert_scheduled_flight('BA001', 'A006', '2023-11-03 10:00:00'); -- 23

    -- aircraft_7
        CALL insert_scheduled_flight('BA025', 'A007', '2023-11-01 07:00:00'); -- 24
        CALL insert_scheduled_flight('BA026', 'A007', '2023-11-02 07:00:00'); -- 25
        CALL insert_scheduled_flight('BA025', 'A007', '2023-11-04 07:00:00'); -- 26
        CALL insert_scheduled_flight('BA026', 'A007', '2023-11-05 07:00:00'); -- 27

    -- aircraft_8
        CALL insert_scheduled_flight('BA010', 'A008', '2023-10-31 05:00:00'); -- 28
        CALL insert_scheduled_flight('BA023', 'A008', '2023-11-03 05:00:00'); -- 29
        CALL insert_scheduled_flight('BA024', 'A008', '2023-11-04 05:00:00'); -- 30
        CALL insert_scheduled_flight('BA012', 'A008', '2023-11-05 05:00:00'); -- 31

-- Platinum class prices
    INSERT INTO Seat_Class_Price (route_id, seat_class_id, price)
    VALUES 
    ('BA001', 1, 400000),
    ('BA002', 1, 450000),
    ('BA003', 1, 400000),
    ('BA004', 1, 450000),
    ('BA005', 1, 400000),
    ('BA006', 1, 450000),
    ('BA007', 1, 350000),
    ('BA008', 1, 400000),
    ('BA009', 1, 350000),
    ('BA010', 1, 400000),
    ('BA011', 1, 350000),
    ('BA012', 1, 400000),
    ('BA013', 1, 500000),
    ('BA014', 1, 500000),
    ('BA015', 1, 500000),
    ('BA016', 1, 300000),
    ('BA017', 1, 500000),
    ('BA018', 1, 300000),
    ('BA019', 1, 450000),
    ('BA020', 1, 450000),
    ('BA021', 1, 400000),
    ('BA022', 1, 400000),
    ('BA023', 1, 400000),
    ('BA024', 1, 400000),
    ('BA025', 1, 450000),
    ('BA026', 1, 450000);

-- Business class prices
    INSERT INTO Seat_Class_Price (route_id, seat_class_id, price)
    VALUES 
    ('BA001', 2, 250000),
    ('BA002', 2, 250000),
    ('BA003', 2, 250000),
    ('BA004', 2, 250000),
    ('BA005', 2, 250000),
    ('BA006', 2, 250000),
    ('BA007', 2, 200000),
    ('BA008', 2, 200000),
    ('BA009', 2, 200000),
    ('BA010', 2, 200000),
    ('BA011', 2, 200000),
    ('BA012', 2, 200000),
    ('BA013', 2, 250000),
    ('BA014', 2, 250000),
    ('BA015', 2, 250000),
    ('BA016', 2, 185000),
    ('BA017', 2, 250000),
    ('BA018', 2, 185000),
    ('BA019', 2, 250000),
    ('BA020', 2, 250000),
    ('BA021', 2, 250000),
    ('BA022', 2, 250000),
    ('BA023', 2, 250000),
    ('BA024', 2, 250000),
    ('BA025', 2, 250000),
    ('BA026', 2, 250000);

-- Economy class prices
    INSERT INTO Seat_Class_Price (route_id, seat_class_id, price)
    VALUES 
    ('BA001', 3, 150000),
    ('BA002', 3, 150000),
    ('BA003', 3, 150000),
    ('BA004', 3, 150000),
    ('BA005', 3, 150000),
    ('BA006', 3, 150000),
    ('BA007', 3, 120000),
    ('BA008', 3, 120000),
    ('BA009', 3, 120000),
    ('BA010', 3, 120000),
    ('BA011', 3, 120000),
    ('BA012', 3, 120000),
    ('BA013', 3, 150000),
    ('BA014', 3, 150000),
    ('BA015', 3, 150000),
    ('BA016', 3, 100000),
    ('BA017', 3, 150000),
    ('BA018', 3, 100000),
    ('BA019', 3, 150000),
    ('BA020', 3, 150000),
    ('BA021', 3, 150000),
    ('BA022', 3, 150000),
    ('BA023', 3, 150000),
    ('BA024', 3, 150000),
    ('BA025', 3, 150000),
    ('BA026', 3, 150000);
