import { NextResponse } from "next/server";
import pool from "@/database/db";

export async function GET(request) {
  try {
    //const pool = require("@/database/db");
    const member_level = request.nextUrl.searchParams.get("schedule_id");
    const sclass = request.nextUrl.searchParams.get("class");

    let class_id;
    if(sclass === 'Economy'){class_id = 3;}
    else if(sclass === 'Business'){class_id = 2;}
    else{class_id = 1;}

    const query = "select price from scheduled_flight join seat_class_price using(route_id) where schedule_id = ? and seat_class_id = ?;";
    const values = [schedule_id, class_id];

    // query database
    const [rows] = await pool.execute(query, values);
    //console.log(rows);
    return NextResponse.json(rows[0]);
  } catch (error) {
    return NextResponse.json({ error });
  }
}