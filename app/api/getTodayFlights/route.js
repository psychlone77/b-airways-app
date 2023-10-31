import { NextResponse } from "next/server";

export async function GET(request) {
  try {
    const query = "SELECT * FROM scheduled_flight left join route using (route_id) WHERE DATE(scheduled_departure) = CURDATE();";
    const values = [];
    const pool = require("@/database/db");

    // query database
    const [rows] = await pool.execute(query, values);
    //console.log(rows);
    return NextResponse.json(rows);
  } catch (error) {
    return NextResponse.json({ error });
  }
}
