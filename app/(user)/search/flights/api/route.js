import { NextResponse } from "next/server";

export async function GET() {
  try {
    const query =
      "SELECT * FROM scheduled_flight left join route using (route_id);";
    const values = [];
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
