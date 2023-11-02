import { NextResponse } from "next/server";

export async function POST(request) {
    try {
        const { schedule_id, seat_id, seat_class_id, user_id, final_price } = await request.json();
        const query = "INSERT INTO user_booking(schedule_id, seat_id, seat_class_id, user_id, final_price, date_of_booking) VALUES (?, ?, ?, ?, ?, NOW());";  // insert_booking
        const values = [schedule_id, seat_id, seat_class_id, user_id, final_price];
        const pool = require('@/database/db');

        // query database
        const [result] = await pool.execute(query, values);
        const insertedId = result.insertId;
        console.log("Booking Created");
        return NextResponse.json({ insertedId });
    } catch (error) {
        //console.error(error);
        return NextResponse.json({ error : error.sqlMessage}, { status: 400 });
    }
}