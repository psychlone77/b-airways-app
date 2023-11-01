import { NextResponse } from "next/server";
import pool from "@/database/db";

export async function GET(request) {
  try {
    //const pool = require("@/database/db");
    const schedule_id = request.nextUrl.searchParams.get("schedule_id");
    const sclass = request.nextUrl.searchParams.get("class");
    const query = "SELECT get_seating_capacity_by_class(?,?) as seats;";
    const values = [schedule_id, sclass];

    // query database
    const [rows] = await pool.execute(query, values);
    //console.log(rows);
    return NextResponse.json(rows[0]);
  } catch (error) {
    return NextResponse.json({ error });
  }
}