'use client'
import React, { useState } from "react";
import { signIn } from "next-auth/react";


export default function AdminLoginPage(){
    const [name, setName] = useState("");
    const [password, setPassword] = useState("");
  
    const handleNameChange = (event) => {
      setName(event.target.value);
    };
  
    const handlePasswordChange = (event) => {
      setPassword(event.target.value);
    };
  
    const handleSubmit = (event) => {
      event.preventDefault();
      console.log("Name: ", name);
      console.log("Password: ", password);
      signIn("credentials", {
        email: name,
        password: password,
        role: "admin",
        callbackUrl: "http://localhost:3000/admin",
      });
      // Add logic to handle form submission here
    };
  
    return (
      <div className="flex flex-col justify-center items-center m- h-[calc(100vh-170px)]">
        <form
          onSubmit={handleSubmit}
          className="w-1/3 h-fit font-nunito flex flex-col gap-10 items-start bg-gradient-to-br from-black via-gray-700 to-black rounded-md p-10 shadow-md shadow-gray-500"
        >
          <h1 className=" font-nunito font-bold text-5xl text-white">Login</h1>
          <input
            className=" w-full border border-gray-400 p-2 rounded-md h-10"
            type="text"
            name={"name"}
            required
            placeholder={"Name"}
            value={name}
            onChange={handleNameChange}
          />
          <input
            className="w-full border border-gray-400 p-2 rounded-md h-10"
            type="password"
            name={"password"}
            required
            placeholder={"Password"}
            value={password}
            onChange={handlePasswordChange}
          />
          <div className="w-full flex flex-col justify-center items-center gap-2">
            <button
              type="submit"
              className="w-60 text-black bg-white font-nunito font-bold rounded-full shadow-sm hover:shadow-md shadow-gray-400 hover:shadow-gray-400 py-2 px-6 transition duration-300 ease-in-out"
            >
              Login
            </button>
          </div>
        </form>
      </div>
    );
}