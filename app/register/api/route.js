import { NextResponse } from "next/server";

export async function POST(request) {

        try {
            //const { email, password, first_name, last_name, dateOfBirth, gender, passport_no, address } = await request.json();
            const { firstName, lastName, dateOfBirth, gender, passport, address, email, password } = await request.json();
            console.log(firstName);
            const query = `INSERT INTO Registered_User (email, password, first_name, last_name, birth_date, gender, passport_no, address) VALUES ('?', '?', '?', '?', '?', '?', '?', '?')`;
            const values = [email, password, firstName, lastName, dateOfBirth, gender, passport, address];
            const pool = require('../../../database/db')

            // query database
            const [result] = await pool.execute(query, values);
            const insertedId = result.insertId;
            console.log(`User with ID ${insertedId} has been inserted into the database.`);
            return NextResponse.json({ insertedId });
        } catch (error) {
            return NextResponse.json({ error: 'Database Server Error' }, { status: 400 });
        }
}