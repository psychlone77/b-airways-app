'use client'
import React, { useState } from "react";
import { signIn } from "next-auth/react";
import Link from "next/link";

export default function Login() {
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");

  const handleEmailChange = (event) => {
    setEmail(event.target.value);
  };

  const handlePasswordChange = (event) => {
    setPassword(event.target.value);
  };

  const handleSubmit = (event) => {
    event.preventDefault();
    console.log("Email: ", email);
    console.log("Password: ", password);
    signIn("credentials", {
      email: email,
      password: password,
      role: "user",
      callbackUrl: "http://localhost:3000/",
    });
    // Add logic to handle form submission here
  };

  return (
    <div className="flex flex-col justify-center items-center m- h-[calc(100vh-160px)]">
      <form
        onSubmit={handleSubmit}
        className="w-1/3 h-fit font-nunito flex flex-col gap-10 items-start bg-gradient-to-br from-primary to-pink-400 rounded-md p-10 shadow-md shadow-secondary"
      >
        <h1 className=" font-nunito font-bold text-5xl text-white">Login</h1>
        <input
          className=" w-full border border-gray-400 p-2 rounded-md h-10"
          type="email"
          name={"email"}
          required
          placeholder={"Email"}
          value={email}
          onChange={handleEmailChange}
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
            className="w-60 text-white bg-primary font-nunito font-bold rounded-full shadow-sm hover:shadow-lg shadow-primary hover:shadow-primary py-2 px-6 transition duration-300 ease-in-out"
          >
            Login
          </button>
          <Link href="/register">
            <span className="text-white hover:text-gray-200">
              <u>Register Now</u>
            </span>
          </Link>
        </div>
      </form>
    </div>
  );
}
