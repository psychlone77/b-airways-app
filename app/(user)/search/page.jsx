"use client";
import React from "react";
import { useState, useEffect } from "react";
import { useSearchParams } from "next/navigation";
import SearchBar from "@/components/searchBar/searchBar";
import FlightChip from "@/components/searchBar/flightChip";
import TFlightChip from "@/components/searchBar/tFlightChip";
import { revalidatePath } from 'next/cache'

export default function SearchPage() {
  const searchParams = useSearchParams();
  const from = searchParams.get("from");
  const to = searchParams.get("to");
  const date = searchParams.get("date");
  const className = searchParams.get("class");
  const seats = searchParams.get("seats");
  const [airports, setAirports] = useState([]);
  const [flights, setFlights] = useState([{id:'none', flight_number:'none'}]);
  
  useEffect(() => {
    const getAirports = async () => {
      const response = await fetch("http://localhost:3000/search/api?field=airport_code&table=airport");
      const airports = await response.json();
      setAirports(airports);
    };
    getAirports();
  }, []);

  useEffect(() => {
    const getFlights = async () => {
      if (from && to && date && className && seats) {
        const response = await fetch(`http://localhost:3000/search/flights/api?origin=${from}&dest=${to}&date=${date}&sclass=${className}&seatCount=${seats}`);
        const res = await response.json();
        const flights = res.rows[0];
        //console.log(flights);
        setFlights(flights);
      }
      else {
        const response = await fetch(`http://localhost:3000/api/getFutureFlights`);
        const flights = await response.json();
        //console.log(flights);
        setFlights(flights);
      }
    };
    getFlights();
  }, [from, to, date, className, seats]);

  return (
    <div className="">
      <div className="flex flex-col items-center">
        <SearchBar
          options={airports}
          from={from}
          to={to}
          date={date}
          class={className}
          seats={seats}
        />
      </div>
      <div className="flex flex-col items-center mt-8">
        {(from && to && date && className && seats) ? (flights.length === 0 ? (
          <h1 className="text-3xl font-nunito text-primary ">
            No Flights Found
          </h1>
        ) : (
          flights.map((flight) => (
            <FlightChip key={flight.schedule_id} flight={flight} count={seats} sclass={className}/>
          ))
        )) : (
          <div>
            <h1 className="text-3xl font-nunito text-primary">Upcoming Flights</h1>
            <h1 className="text-md font-nunito text-gray-500 mb-4">Limited to 10</h1>
            {flights.map((flight) => (
              <TFlightChip key={flight.id} flight={flight} />
            ))}
          </div>
        )}
        {console.log(flights)}  
      </div>
    </div>
  );
}