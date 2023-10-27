import { NextResponse } from "next/server";

export async function POST(request) {
    try {
        const { firstName, lastName, dateOfBirth, gender, passport, address, email, contact, password } = await request.json();
        const query = "CALL add_new_registered_user(?, ?, ?, ?, ?, ?, ?, ?, ?)";  // add_new_registered_user
        const values = [firstName, lastName, dateOfBirth, gender, passport, address, email, contact, password];
        const pool = require('../../../database/db');

        // query database
        const [result] = await pool.execute(query, values);
        const insertedId = result.insertId;
        console.log(`User with ID ${insertedId} has been inserted into the database.`);
        return NextResponse.json({ insertedId });
    } catch (error) {
        //console.error(error);
        return NextResponse.json({ error : error.sqlMessage}, { status: 400 });
    }
}