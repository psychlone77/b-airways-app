"use client";
import React from "react";
import { useState, useEffect } from "react";
import { useSearchParams } from "next/navigation";
import SearchBar from "@/components/searchBar/searchBar";
import FLightChip from "@/components/searchBar/flightChip";
import NavBar from "@/components/navbar/navbar";

export default function SearchPage() {
  const searchParams = useSearchParams();
  const from = searchParams.get("from");
  const to = searchParams.get("to");
  const date = searchParams.get("date");
  const className = searchParams.get("class");
  const seats = searchParams.get("seats");
  const [airports, setAirports] = useState([]);
  const [flights, setFlights] = useState({rows:[{id:'none', flight_number:'none'}]});
  
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
      const response = await fetch("http://localhost:3000/search/flights/api");
      const flights = await response.json();
      //console.log(flights);
      setFlights(flights);
    };
    getFlights();
  }, []);

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
        {flights.rows.map((flight) => (
          <FLightChip key={flight.schedule_id} flight={flight} />
        ))}
      </div>
    </div>
  );
}