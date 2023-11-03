import { NextResponse } from "next/server";

export async function POST(request) {
    try {
        const { name, dob, address, gender, passport_no, mobile_no, email, sch_id, seat_id, sc_id } = await request.json();
        const query = "CALL add_new_guest_user(?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";  // insert_booking
        const values = [name, ,dob, gender, passport_no, address, mobile_no, email, sch_id, seat_id, sc_id];
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