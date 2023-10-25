import { NextResponse } from "next/server";

export async function GET() {

    try {
        const query = "SELECT airport_code FROM airport";
        const values = [];
        const pool = require('../../../database/db')

        // query database
        const [rows] = await pool.execute(query, values);
        // const airports = rows[0].map(row => ({
        //     value: row.airport_code,
        //     label: row.airport_code
        // }));
        //console.log(rows)
        return NextResponse.json({rows});
    } 
    
    catch (error) {
      return NextResponse.json({ error: 'Database Server Error' });
    }
}

// async function getAirports(){
//     try {
//       const query = "SELECT airport_code FROM airport";
//       const values = [];
//       const pool = require('../../database/db')
  
//       // query database
//       const [rows] = await pool.execute(query, values);
//       const airports = rows.map(row => ({
//         value: row.airport_code,
//         label: row.airport_code
//       }));
//       //console.log(airports);
//       return airports;
//     } catch (error) {
//       return error;
//     }
//   }