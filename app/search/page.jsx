'use client'
import React from "react";
import {useState, useEffect} from 'react'
import { useSearchParams } from 'next/navigation'
import SearchBar from "@/components/searchBar/searchBar";


export default function SearchPage() {
  const searchParams = useSearchParams()
  const from = searchParams.get('from')
  const to = searchParams.get('to')
  const date = searchParams.get('date')
  const seats = searchParams.get('seats')
  const [airports, setAirports] = useState([]);

  useEffect(() => {
    const getAirports = async() => {
      const response = await fetch('http://localhost:3000/search/api');
      const airports = await response.json()
      setAirports(airports);
    }
    getAirports();
  },[])

  return (
    <div className="">
     <div className="flex flex-col items-center">
       <SearchBar options={airports} link="/search" from={from} to={to} date={date} seats={seats}/>
     </div>
     <div>

     </div>
    </div>
  );
}