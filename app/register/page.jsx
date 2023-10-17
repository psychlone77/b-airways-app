"use client";
import React, { useState } from "react";

export default function Register() {
  const [gender, setGender] = useState(""); // State to hold the selected gender

  const handleGenderChange = (e) => {
    setGender(e.target.value); // Update the gender state when the dropdown value changes
  };

  return (
    <div className="flex justify-center items-center m-5">
      <div className="h-fit font-nunito flex flex-col gap-10 items-start bg-secondary rounded-md p-10 shadow-md shadow-secondary">
        <h1 className=" font-nunito font-bold text-5xl text-white">
          Register
        </h1>
        <div className="flex flex-row gap-3">
          <input
            className="border border-gray-400 p-2 rounded-md h-10"
            type="text"
            name={"firstName"}
            required
            placeholder={"First Name"}
          />
          <input
            className="border border-gray-400 p-2 rounded-md h-10"
            type="text"
            name={"lastName"}
            required
            placeholder={"Last Name"}
          />
        </div>
        <div className="flex flex-col gap-2 justify-start">
          <p className="text-white flex flex-row items-center">Date of Birth</p>
          <input
            className="border border-gray-400 p-2 rounded-md h-10"
            type="date"
            name={"firstName"}
            required
          />
        </div>
        <select className="pr-5 pl-2 rounded-md h-10" id="gender" value={gender} onChange={handleGenderChange}>
          <option value="" disabled>Select Gender</option>
          <option value="male">Male</option>
          <option value="female">Female</option>
          <option value="other">Other</option>
        </select>
        <input
          className="border border-gray-400 p-2 rounded-md h-10 w-full"
          type="text"
          name={"passport"}
          required
          placeholder={"Passport No."}
        />
        <input
          className="border border-gray-400 p-2 rounded-md h-10 w-full"
          type="text"
          name={"address"}
          required
          placeholder={"Address"}
        />
        <input
          className="border border-gray-400 p-2 rounded-md h-10 w-full"
          type="email"
          name={"email"}
          required
          placeholder={"Email"}
        />
        <input
          className="border border-gray-400 p-2 rounded-md h-10 w-full"
          type="password"
          name={"password"}
          required
          placeholder={"Password"}
        />
        <div className="w-full flex flex-row justify-center">
          <button
            type="submit"
            className="w-60 text-white border border-primary bg-primary font-nunito font-bold rounded-full shadow-sm hover:shadow-lg shadow-primary py-2 px-6 transition duration-300 ease-in-out"
          >
            Sign Up
          </button>
        </div>
      </div>
    </div>
  );
}
