import { NextResponse } from "next/server";
import pool from "@/database/db";

export async function GET(request) {
  try {
    //const pool = require("@/database/db");
    const from = request.nextUrl.searchParams.get("from");
    const to = request.nextUrl.searchParams.get("to");
    const query = "call get_bookings_by_passenger_type(?, ?)";
    const values = [from, to];

    // query database
    const [rows] = await pool.execute(query, values);
    //console.log(rows);
    return NextResponse.json(rows[0]);
  } catch (error) {
    return NextResponse.json({ error });
  }
}