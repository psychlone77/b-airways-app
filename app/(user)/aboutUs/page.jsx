import React from "react";

async function getData() {
  try {
    const query = "SELECT * from organizational_info";
    const values = [];
    const pool = require('@/database/db')

    // query database
    const [rows] = await pool.execute(query, values);
    //console.log(rows[0]);
    return {rows};
  } catch (error) {
    return error;
  }
}

export default async function AboutUs() {
  const res = await getData();
  const data = res.rows[0];
  return (
    <div className="">
      <div className="h-screen flex flex-col items-center">
        <h1 className="font-nunito font-bold text-center text-3xl text-transparent bg-clip-text bg-gradient-to-r from-primary via-purple-500 to-pink-500 ">
          Welcome to
        </h1>
        <h1 className="font-nunito font-bold text-center text-8xl text-transparent bg-clip-text bg-gradient-to-r from-primary via-purple-500 to-pink-500 ">
          B Airways
        </h1>
        <div className="p-10 flex flex-col items-start gap-5 mt-10 text-white font-semibold font-nunito bg-gradient-to-r from-primary to-purple-500 rounded-lg shadow-primary shadow-sm">
          <div className="">
            <span>Email: </span>
            <span>{data.airline_email}</span>
          </div>
          <div className="">
            <span>Contact Us: </span>
            <span>{data.airline_hotline}</span>
          </div>
          <div className="">
            <span>Address: </span>
            <span>{data.address}</span>
          </div>
        </div>
      </div>
    </div>
  );
}
