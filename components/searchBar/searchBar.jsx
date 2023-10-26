"use client";
import React from "react";
import {useState} from 'react'
import Select from "react-select";
import { useRouter } from 'next/navigation';

function getDefaults(searchParam) {
  if (searchParam == null) {
    return "Select...";
  } else {
    return searchParam;
  }
}

export default function SearchBar(props) {
  const router = useRouter();
  const classes = [{value:'Platinum', label: 'Platinum'},{value:'Platinum', label: 'Platinum'},{value:'Platinum', label: 'Platinum'}]
  var airportsList = [];
  console.log(props.options.rows);
  if (props.options.rows && Array.isArray(props.options.rows)) {
    airportsList = props.options.rows.map((row) => ({
      value: row.airport_code,
      label: row.airport_code,
    }));
  } else {
    airportsList = ["Unavailable"];
    console.error("Error calling database");
  }
  console.log(props.from);

  const from = props.from;
  const to = getDefaults(props.to);
  const className = getDefaults(props.class);
  const date = getDefaults(props.date);

  const [selectedFrom, setSelectedFrom] = useState(props.from)
  const [selectedTo, setSelectedTo] = useState(props.to)
  const [selectedDate, setSelectedDate] = useState(props.date)
  const [selectedSeats, setSelectedSeats] = useState(props.seats)
  const [selectedClass, setSelectedClass] = useState(props.class)

  const handleFromChange = (selectedOption) => {
    setSelectedFrom(selectedOption); // Set the selected option in state
  };

  const handleToChange = (selectedOption) => {
    setSelectedTo(selectedOption); // Set the selected option in state
  };

  const handleClassChange = (selectedOption) => {
    setSelectedClass(selectedOption); // Set the selected option in state
  };

  const handleDateChange = (event) => {
    setSelectedDate(event.target.value);
  };

  const handleSeatChange = (event) => {
    setSelectedSeats(event.target.value);
  };

  const handleSearch = () => {
    const fromValue = selectedFrom ? selectedFrom.value : '';
    const toValue = selectedTo ? selectedTo.value : '';
    const classValue = selectedClass ? selectedClass.value : '';
    router.push(`/search?from=${fromValue}&to=${toValue}&date=${selectedDate}&class=${classValue}&seats=${selectedSeats}`);
  };


  return (
    <div>
      <div className="p-5 flex flex-wrap flex-row justify-center gap-12 rounded-md bg-primary border border-gray-400 font-nunito shadow-sm shadow-gray-400">
        <div className="flex flex-row gap-2 items-center">
          <h2 className="text-white">From</h2>
          <Select
            className="w-32"
            options={airportsList}
            value={selectedFrom}
            onChange={handleFromChange}
            defaultValue={{ value: from, label: from }}
          />
        </div>
        <div className="flex flex-row gap-2 items-center">
          <h2 className="text-white">To</h2>
          <Select
            className="w-32"
            options={airportsList}
            value={selectedTo}
            onChange={handleToChange}
            defaultValue={{ value: to, label: to }}
          />
        </div>
        <div className="flex flex-row gap-2 items-center">
          <h2 className="text-white">Departure</h2>
          <input
            className="border border-gray-400 p-2 rounded-md w-44 h-10"
            type="date"
            name="date"
            required
            onChange={handleDateChange}
            value={selectedDate}
            defaultValue={props.date}
          />
        </div>
        <div className="flex flex-row gap-2 items-center">
          <h2 className="text-white">Class</h2>
          <Select
            className="w-44"
            options={classes}
            value={selectedClass}
            onChange={handleClassChange}
            defaultValue={{ value: className, label: className }}
          />
        </div>
        <div className="flex flex-row gap-2 items-center">
          <h2 className="text-white">Seats</h2>
          <input
            className="border border-gray-400 p-2 rounded-md w-20 h-10"
            type="number"
            name="seats"
            required
            onChange={handleSeatChange}
            value={selectedSeats}
            defaultValue={props.seats}
          />
        </div>
        <div className="flex flex-row justify-center">
            <button
              type="submit"
              onClick={handleSearch}
              className="w-fit text-primary border border-transparent shadow-purple-800 bg-white font-nunito font-bold rounded-2xl hover:shadow-xl  py-2 px-10 transition duration-300 ease-in-out"
            >
              Search
            </button>
        </div>
      </div>
    </div>
  );
}
