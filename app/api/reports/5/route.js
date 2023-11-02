import { NextResponse } from "next/server";
import pool from "@/database/db";

export async function GET(request) {
  try {
    //const pool = require("@/database/db");
    const model = request.nextUrl.searchParams.get("model");
    const query = "call get_revenue_by_aircraft_type(?)";
    const values = [model];

    // query database
    const [rows] = await pool.execute(query, values);
    //console.log(rows);
    return NextResponse.json(rows[0]);
  } catch (error) {
    return NextResponse.json({ error });
  }
}