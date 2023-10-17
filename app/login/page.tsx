import React from "react";
import Link from "next/link";

export default function Login() {
  return (
    <div className="flex justify-center items-start m- h-screen">
      <div className="w-1/3 h-fit font-nunito flex flex-col gap-10 items-start bg-secondary rounded-md p-10 shadow-md shadow-secondary">
        <h1 className=" font-nunito font-bold text-5xl text-white">Login</h1>
        <input
          className=" w-full border border-gray-400 p-2 rounded-md h-10"
          type="email"
          name={"email"}
          required
          placeholder={"Email"}
        />
        <input
          className="w-full border border-gray-400 p-2 rounded-md h-10"
          type="password"
          name={"password"}
          required
          placeholder={"Password"}
        />
        <div className="w-full flex flex-col justify-center items-center gap-2">
          <button
            type="submit"
            className="w-60 text-white border border-primary bg-primary font-nunito font-bold rounded-full shadow-sm hover:shadow-lg shadow-primary py-2 px-6 transition duration-300 ease-in-out"
          >
            Login
          </button>
          <Link href="/register">
            <span className="text-white hover:text-gray-200">
              <u>Register Now</u>
            </span>
          </Link>
        </div>
      </div>
    </div>
  );
}
