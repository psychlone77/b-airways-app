import React from "react";

async function getAirports() {
  try {
    const query = "SELECT airport_code FROM airport";
    const values = [];
    const pool = require("../database/db");

    // query database
    const [rows] = await pool.execute(query, values);
    const airports = rows.map((row) => ({
      value: row.airport_code,
      label: row.airport_code,
    }));
    console.log(airports);
    return airports;
  } catch (error) {
    return { error };
  }
}

export default async function Home() {
  const airports = await getAirports();
  //console.log(airports)
  return (
    <div>
      <div className="h-screen flex flex-col items-center">
        <h1 className="font-nunito font-bold text-center text-3xl text-transparent bg-clip-text bg-gradient-to-r from-primary via-purple-500 to-pink-400 ">
          Welcome to
        </h1>
        <h1 className="font-nunito font-bold text-center text-8xl text-transparent bg-clip-text bg-gradient-to-r from-primary via-purple-500 to-pink-400 ">
          B Airways
        </h1>
      </div>
    </div>
  );
}
