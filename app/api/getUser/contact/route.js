import { NextResponse } from "next/server";

export async function GET(request) {
  try {
    const user_id = request.nextUrl.searchParams.get("user_id");
    const query = "SELECT contact_no from contact_no where user_id = ?";
    const values = [user_id];
    const pool = require("../../../../database/db");

    // query database
    const [rows] = await pool.execute(query, values);
    //console.log(rows);
    return NextResponse.json(rows);
  } catch (error) {
    return NextResponse.json({ error });
  }
}