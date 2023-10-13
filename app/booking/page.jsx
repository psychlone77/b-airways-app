"use client"

import React from "react";
import PassengerForms from "@/components/passengerForms/passengerForms";

function seatCount(num) {
  if (num) {
    return num;
  } else {
    return 3;
  }
}

export default function Booking(props) {
  const {
    userdata = {
      firstName: "John",
      middlename: "Nathan",
      lastname: "Doe",
      dob: "2000-01-01",
      passportno: "693020239",
      address: "No34, Avery Street, United Kingdom",
    },
    count = 3,
  } = props;
  return (
    <div className="mb-5 flex flex-col justify-center items-center ">
      <h1 className="text-2xl text-primary font-sans font-bold">
        Passenger Information
      </h1>
      <div className="text-gray-400 font-sans">
        <h2 className="mb-6">Enter details about each passenger</h2>
      </div>
      <PassengerForms userdata={userdata} count={seatCount(props.count)}/>
      {/* <div className="w-full mt-9 flex flex-col items-center gap-6"> */}
        <button className="w-60 text-white border border-transparent bg-primary font-sans rounded-full hover:shadow-secondary hover:shadow-md hover:bg-white hover:border-primary hover:text-primary py-2 px-6 transition duration-300 ease-in-out">
          Save
        </button>
      {/* </div> */}
    </div>
  );
}