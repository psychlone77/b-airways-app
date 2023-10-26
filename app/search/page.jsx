"use client";
import React from "react";
import { useState, useEffect } from "react";
import { useSearchParams } from "next/navigation";
import SearchBar from "@/components/searchBar/searchBar";
import FLightChip from "@/components/searchBar/flightChip";

export default function SearchPage() {
  const searchParams = useSearchParams();
  const from = searchParams.get("from");
  const to = searchParams.get("to");
  const date = searchParams.get("date");
  const className = searchParams.get("class");
  const seats = searchParams.get("seats");
  const [airports, setAirports] = useState([]);
  
  useEffect(() => {
    const getAirports = async () => {
      const response = await fetch("http://localhost:3000/search/api?field=airport_code&table=airport");
      const airports = await response.json();
      setAirports(airports);
    };
    getAirports();
  }, []);

  return (
    <div className="">
      <div className="flex flex-col items-center">
        <SearchBar
          options={airports}
          link="/search"
          from={from}
          to={to}
          date={date}
          class={className}
          seats={seats}
        />
      </div>
      <div className="flex flex-col items-center mt-8">
        {Array.from({ length: 3 }).map((_, index) => (
          <FLightChip />
        ))}
      </div>
    </div>
  );
}
