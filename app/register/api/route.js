import { NextResponse } from "next/server";

export async function POST(request) {
    try {
        const { firstName, lastName, dateOfBirth, gender, passport, address, email, password } = await request.json();
        const query = "CALL add_new_user(?, ?, ?, ?, ?, ?, ?, ?)";
        const values = [firstName, lastName, dateOfBirth, gender, passport, address, email, password];
        const pool = require('../../../database/db');

        // query database
        const [result] = await pool.execute(query, values);
        const insertedId = result.insertId;
        console.log(`User with ID ${insertedId} has been inserted into the database.`);
        return NextResponse.json({ insertedId });
    } catch (error) {
        console.error(error);
        return NextResponse.json({ error: 'Database Server Error' }, { status: 400 });
    }
}