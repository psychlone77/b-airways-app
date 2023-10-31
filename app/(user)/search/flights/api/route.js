import { NextResponse } from "next/server";

export async function GET(request) {
  try {
    const origin = request.nextUrl.searchParams.get("origin");
    const dest = request.nextUrl.searchParams.get("dest");
    const date = request.nextUrl.searchParams.get("date");
    const sclass = request.nextUrl.searchParams.get("sclass");
    const seatCount = request.nextUrl.searchParams.get("seatCount");
    const query = "CALL get_aircraft_schedule(?, ?, ?, ?, ?);";
    const values = [origin, dest, date, sclass, seatCount];
    const pool = require("@/database/db");

    // query database
    const [rows] = await pool.execute(query, values);
    return NextResponse.json({ rows });
  } 
  catch (error) {
    return NextResponse.json(
      { error: "Database Server Error" },
      { status: 400 }
    );
  }
}
