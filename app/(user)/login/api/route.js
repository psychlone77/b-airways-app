import { NextResponse } from "next/server";

export async function GET() {
  let res = NextResponse.next()
    try {
      const query = "SELECT * from registered_user where user_id = 1";
      const values = [];
      const pool = require('../../../database/db')
  
      // query database
      const [rows] = await pool.execute(query, values);
      //console.log(rows);
      return res.json({rows});
    } catch (error) {
      return res.json({ error });
    }
  }

  