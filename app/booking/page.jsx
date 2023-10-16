import React from "react";
import PassengerForms from "@/components/passengerForms/passengerForms";
import FlightDetails from "@/components/flightDetails/flightDetails";

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
    count = 2,
  } = props;

  return (
    <div className="flex flex-row justify-between pt-10">
      <div className="mb-5 flex flex-col flex-start px-10">
        <h1 className="text-2xl text-primary font-nunito font-bold">
          Passenger Information
        </h1>
        <div className="text-gray-400 font-nunito">
          <h2 className="mb-6">Enter details about each passenger</h2>
        </div>
        <PassengerForms userdata={userdata} count={count} />
      </div>
      <div className="pr-10">
        <h3 className="text-2xl text-primary font-nunito font-bold mb-5 text-right">
          Selected Flight
        </h3>
        <FlightDetails/>
      </div>
    </div>
  );
}