"use client";
import React from "react";
import { useState } from "react";
import SeatSection from "@/components/seatSection/seatSection";
import FlightDetails from "@/components/flightDetails/flightDetails";

export default function SelectSeats(props) {
  const [platSelected, setpseats] = useState([]);
  const [busiSelected, setbseats] = useState([]);
  const [econSelected, seteseats] = useState([]);

  async function platClick(seatNumber) {
    if (platSelected.includes(seatNumber)) {
      setpseats(platSelected.filter((seat) => seat !== seatNumber));
    } else {
      setpseats([...platSelected, seatNumber]);
    }
  }

  async function busiClick(seatNumber) {
    if (busiSelected.includes(seatNumber)) {
      setbseats(busiSelected.filter((seat) => seat !== seatNumber));
    } else {
      setbseats([...busiSelected, seatNumber]);
    }
  }

  async function econClick(seatNumber) {
    if (econSelected.includes(seatNumber)) {
      seteseats(econSelected.filter((seat) => seat !== seatNumber));
    } else {
      seteseats([...econSelected, seatNumber]);
    }
  }

  const {
    platinum = {
      seatsPerRow: 3,
      seatRows: 4,
      bookedSeats: [1, 4, 5],
    },
    business = {
      seatsPerRow: 4,
      seatRows: 5,
      bookedSeats: [3],
    },
    economy = {
      seatsPerRow: 4,
      seatRows: 8,
      bookedSeats: [7],
    },
  } = props;

  return (
    <div className="mt-10 flex flex-row justify-around">
      <div className="bg-secondary flex flex-col gap-8 justify-center rounded-2xl max-w-fit p-5 self-center shadow-secondary shadow-xl mb-3">
        <SeatSection
          onButtonClick={platClick}
          title={"Platinum"}
          seatsPerRow={platinum.seatsPerRow}
          seatRows={platinum.seatRows}
          bookedSeats={platinum.bookedSeats}
          selectedSeats={platSelected}
        />
        <SeatSection
          onButtonClick={busiClick}
          title={"Business"}
          seatsPerRow={business.seatsPerRow}
          seatRows={business.seatRows}
          bookedSeats={business.bookedSeats}
          selectedSeats={busiSelected}
        />
        <SeatSection
          onButtonClick={econClick}
          title={"Economy"}
          seatsPerRow={economy.seatsPerRow}
          seatRows={economy.seatRows}
          bookedSeats={economy.bookedSeats}
          selectedSeats={econSelected}
        />
      </div>
      <div>
        <FlightDetails />
        <div className="flex flex-wrap flex-col p-5 rounded-xl border border-gray-400 font-nunito shadow-md shadow-secondary mb-5 bg-primary text-white">
          <div className="flex flex-col gap-2">
            <h2 className="font-semibold">Selected Seats</h2>
            <div className="flex flex-row flex-wrap gap-2 items-center">
              <h2 className="font-semibold:">Platinum:</h2>
              {platSelected.map((_, i) => {
                return (
                  <button
                    className="w-8 h-8 rounded-md text-sm text-primary text-center align-middle bg-white"
                    key={i}
                    disabled={true}
                  >
                    {_}
                  </button>
                );
              })}
            </div>
            <div className="flex flex-row flex-wrap gap-2 items-center">
              <h2 className="font-semibold:">Business:</h2>
              {busiSelected.map((_, i) => {
                return (
                  <button
                    className="w-8 h-8 rounded-md text-sm text-primary text-center align-middle bg-white"
                    key={i}
                    disabled={true}
                  >
                    {_}
                  </button>
                );
              })}
            </div>
            <div className="flex flex-row flex-wrap gap-2 items-center">
              <h2 className="font-semibold:">Economy:</h2>
              {econSelected.map((_, i) => {
                return (
                  <button
                    className="w-8 h-8 rounded-md text-sm text-primary text-center align-middle bg-white"
                    key={i}
                    disabled={true}
                  >
                    {_}
                  </button>
                );
              })}
            </div>
          </div>
        </div>
        <div className="flex justify-center">
          <button className="text-white border border-transparent bg-primary font-nunito rounded-full hover:shadow-secondary hover:shadow-md hover:bg-white hover:border-primary hover:text-primary py-2 px-6 transition duration-300 ease-in-out">
            Book Seats
          </button>
        </div>
      </div>
    </div>
  );
}
