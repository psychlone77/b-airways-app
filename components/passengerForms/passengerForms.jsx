"use client";

import React, { useEffect, useState } from "react";
import { experimental_useFormState as useFormState } from 'react-dom'
import { experimental_useFormStatus as useFormStatus } from 'react-dom'
import {AddPassengers} from '@/app/actions'

const initialState = {
  message: null,
}

function PassengerForm(props) {
  const [autoFill, setAutoFill] = useState(false);
  const [userdata, setUserData] = useState(props.userdata);
  const [formData, setFormData] = useState({
    name: props.userdata.first_name,
    dob: props.userdata.birth_date,
    passportno: props.userdata.passport_no,
  });

  useEffect(() => {
    setUserData(props.userdata);
    setFormData({
      name: props.userdata.first_name,
      dob: props.userdata.birth_date,
      passportno: props.userdata.passport_no,
    });
  }, [props.userdata]);

  const handleInputChange = (e) => {
    const { name, value } = e.target;
    setFormData({ ...formData, [name]: value });
    console.log(userdata);
    // console.log(autoFill);
  };

  const handleCheckboxChange = () => {
    setAutoFill(!autoFill); // Toggle the checkbox status
  };

  return (
    <div className="flex flex-wrap flex-col p-5 rounded-xl border border-gray-400 font-nunito shadow-sm shadow-gray-400 mb-5">
      <h3 className="mb-5 text-gray-700">Passenger {props.count}</h3>
      {props.count === 1 ? (
        <div className="mb-2">
          <label className="font-sans text-sm text-gray-800">
            <input
              type="checkbox"
              checked={autoFill} // Bind the checked property to the state variable
              onChange={handleCheckboxChange} // Handle checkbox change event
            />{" "}
            auto-fill
          </label>
        </div>
      ) : null}
        <div className="flex flex-row gap-6 text-gray-700">
          <div className="flex flex-row gap-6 flex-wrap justify-start">
            <input
              className="border border-gray-400 p-2 rounded-md h-10"
              type="text"
              name={`name${props.count}`}
              required
              placeholder={"Name*"}
              value={autoFill ? userdata.first_name : formData.name}
              readOnly={autoFill}
              onChange={handleInputChange}
            />
          </div>
          <div className="flex">
            <input
              className="flex border border-gray-400 p-2 rounded-md h-10"
              type="date"
              name="dob"
              required
              placeholder={"Date of Birth*"}
              value={autoFill ? userdata.birth_date : formData.dob}
              readOnly={autoFill}
              onChange={handleInputChange}
            />
          </div>
          <div className="flex">
            <input
              className="flex border border-gray-400 p-2 rounded-md h-10"
              type="text"
              name="passportno"
              required
              placeholder={"Passport No.*"}
              value={autoFill ? userdata.passport_no : formData.passportno}
              readOnly={autoFill}
              onChange={handleInputChange}
            />
          </div>
        </div>
    </div>
  );
}

export default function PassengerForms(props) {

  const [state, formaction] = useFormState(AddPassengers, initialState)
  
  return (
    <div>
      <form action={formaction}>
        {Array.from({ length: props.count }).map((_, index) => (
          <PassengerForm
            key={index}
            count={index + 1}
            userdata={props.userdata}
          />
        ))}
        <div className="flex justify-center">
          <button type="submit" className="w-60 text-white border border-transparent bg-primary font-nunito font-bold rounded-full hover:shadow-secondary hover:shadow-md hover:bg-white hover:border-primary hover:text-primary py-2 px-6 transition duration-300 ease-in-out">
            Save
          </button>
        </div>
      </form>
    </div>
  );
}
