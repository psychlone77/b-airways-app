"use client";
import React, { useState } from "react";

export default function Register() {
  const [gender, setGender] = useState(""); // State to hold the selected gender

  const handleGenderChange = (e) => {
    setGender(e.target.value); // Update the gender state when the dropdown value changes
  };

  const handleSignUp = (event) => {
    event.preventDefault();
    const form = event.target;
    const data = {
      firstName: form.firstName.value,
      lastName: form.lastName.value,
      dateOfBirth: form.dob.value,
      gender: gender,
      passport: form.passport.value,
      address: form.address.value,
      email: form.email.value,
      contact: form.contact.value, // Add the new field to the data object
      password: form.password.value,
    };
    //console.log(data);
    fetch("/register/api", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify(data),
    })
      .then(async(response) => {
        if (!response.ok) {
          const res = await response.json();
          console.log(res)
          throw new Error(res.error);
        }
        return response.json();
      })
      .then((data) => {
        console.log("Success:", data);
        window.location.href = "/login"; // Redirect to home page upon successful registration
      })
      .catch((error) => {
        alert(error);
        console.log(error);
      });
  };

  return (
    <div className="flex justify-center items-center m-5">
      <form onSubmit={handleSignUp}>
        <div className="h-fit font-nunito flex flex-col gap-10 items-start bg-gradient-to-br from-primary to-pink-400 rounded-lg p-10 shadow-md shadow-secondary">
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
            <p className="text-white flex flex-row items-center">
              Date of Birth
            </p>
            <input
              className="border border-gray-400 p-2 rounded-md h-10"
              type="date"
              name={"dob"}
              required
            />
          </div>
          <select
            className="pr-5 pl-2 rounded-md h-10"
            id="gender"
            value={gender}
            onChange={handleGenderChange}
          >
            <option value="" disabled>
              Select Gender
            </option>
            <option value="male">Male</option>
            <option value="female">Female</option>
            <option value="other">Other</option>
          </select>
          <input
            className="border border-gray-400 p-2 rounded-md h-10 w-fit"
            type="text"
            name={"contact"}
            required
            placeholder={"Contact No."}
          />
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
              className="w-60 text-white bg-primary font-nunito font-bold rounded-full shadow-sm shadow-primary hover:shadow-lg  hover:shadow-primary py-2 px-6 transition duration-300 ease-in-out"
            >
              Sign Up
            </button>
          </div>
        </div>
      </form>
    </div>
  );
}
