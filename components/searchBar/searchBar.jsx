"use client";
import React from "react";
import {useState, useEffect} from 'react'
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
  const classes = [{value:'Platinum', label: 'Platinum'},{value:'Business', label: 'Business'},{value:'Economy', label: 'Economy'}]
  var airportsList = [];
  //console.log(props.options.rows);
  
  if (props.options.rows && Array.isArray(props.options.rows)) {
    airportsList = props.options.rows.map((row) => ({
      value: row.airport_code,
      label: row.airport_code,
    }));
  } else {
    airportsList = ["Unavailable"];
    console.error("Error calling database");
  }
  //console.log(props.from);

  const from = props.from;
  const to = props.to;
  const className = getDefaults(props.class);
  const date = getDefaults(props.date);

  const [showError, setShowError] = useState(false);
  const [selectedFrom, setSelectedFrom] = useState()
  const [selectedTo, setSelectedTo] = useState()
  const [selectedDate, setSelectedDate] = useState(props.date)
  const [selectedSeats, setSelectedSeats] = useState()
  const [selectedClass, setSelectedClass] = useState()

  // useEffect(() => {
  //   console.log(props)
  //   setSelectedFrom(props.from);
  //   setSelectedTo(props.to);
  //   setSelectedDate(props.date);
  //   setSelectedSeats(props.seats);
  //   setSelectedClass(props.class);
  //   console.log(selectedFrom);
  // }, []);

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

  const handleSearch = (event) => {
    event.preventDefault();
    const fromValue = selectedFrom ? selectedFrom.value : '';
    const toValue = selectedTo ? selectedTo.value : '';
    const classValue = selectedClass ? selectedClass.value : '';

    if (fromValue === toValue) {
      setShowError(true);
      setSelectedFrom(null);
      setSelectedTo(null);
    } else {
      setShowError(false);
      router.push(`/search?from=${fromValue}&to=${toValue}&date=${selectedDate}&class=${classValue}&seats=${selectedSeats}`);
    }
  };



  return (
    <div>
      {showError && (
        <div className="modal flex flex-row justify-center mb-5">
          <div className="modal-content rounded-3xl w-fit p-3 bg-red-700 font-nunito flex flex-row  gap-5 items-center font-bold text-white focus:ring-4 focus:outline-none focus:ring-blue-300">
            <span className="font-thin text-3xl cursor-pointer" onClick={() => setShowError(false)}>&times;</span>
            <p>You cannot select the same locations</p>
          </div>
        </div>
      )}
      <form onSubmit={handleSearch}>
        <div className="p-5 flex flex-wrap flex-row justify-center gap-12 rounded-md bg-purple-800 border border-gray-400 font-nunito shadow-sm shadow-gray-400">
          <div className="flex flex-row gap-2 items-center">
            <h2 className="text-white">From</h2>
            <Select
              className="w-32"
              options={airportsList}
              value={selectedFrom}
              onChange={handleFromChange}
              defaultValue={{ value: from, label: to }}
              required
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
              required
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
              min={new Date().toISOString().split('T')[0]}
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
              required
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
                className="w-fit text-primary shadow-purple-800 bg-white font-nunito font-bold rounded-2xl hover:shadow-xl hover:bg-gradient-to-r from-purple-700 to-pink-500 hover:text-white  py-2 px-10 transition duration-600 ease-in-out"
              >
                Search
              </button>
          </div>
        </div>
      </form>
    </div>
  );
}
