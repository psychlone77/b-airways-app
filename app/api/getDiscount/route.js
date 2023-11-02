import { NextResponse } from "next/server";
import pool from "@/database/db";

export async function GET(request) {
  try {
    //const pool = require("@/database/db");
    const user_id = request.nextUrl.searchParams.get("user_id");
    const query = "SELECT registered_user_category, discount_percentage FROM registered_user r JOIN user_category USING(registered_user_category) WHERE user_id = ?;";
    const values = [user_id];

    // query database
    const [rows] = await pool.execute(query, values);
    //console.log(rows);
    return NextResponse.json(rows[0]);
  } catch (error) {
    return NextResponse.json({ error });
  }
}
