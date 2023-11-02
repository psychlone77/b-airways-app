import { NextResponse } from "next/server";
import pool from "@/database/db";

export async function GET(request) {
  try {
    //const pool = require("@/database/db");
    const from = request.nextUrl.searchParams.get("from");
    const to = request.nextUrl.searchParams.get("to");
    const destination = request.nextUrl.searchParams.get("destination");
    const query = "call get_passengers_travelling_to_a_destination(?, ?, ?)";
    const values = [from, to, destination];

    // query database
    const [rows] = await pool.execute(query, values);
    //console.log(rows);
    return NextResponse.json(rows[0]);
  } catch (error) {
    return NextResponse.json({ error });
  }
}
