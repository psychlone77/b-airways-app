import { NextResponse } from "next/server";
import pool from "@/database/db";

export async function GET(request) {
  try {
    //const pool = require("@/database/db");
    const origin = request.nextUrl.searchParams.get("origin");
    const destination = request.nextUrl.searchParams.get("destination");
    const query = "call get_past_flights(?, ?)";
    const values = [origin, destination];

    // query database
    const [rows] = await pool.execute(query, values);
    //console.log(rows);
    return NextResponse.json(rows[0]);
  } catch (error) {
    return NextResponse.json({ error });
  }
}