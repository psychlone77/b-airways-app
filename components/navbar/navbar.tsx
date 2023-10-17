"use client"
import "./navbar.css";
import React from "react";
import Link from "next/link";


export default function NavBar() {
  return(
    <nav className="nav">
    <p className="navbartitle font-museo font-bold">
      <Link href="/">B AIRWAYS</Link>
    </p>
    <div className="Links font-nunito">
    <Link href="/search">
        <span>SEARCH</span>
      </Link>
      <Link href="/aboutUs">
        <span>ABOUT US</span>
      </Link>
    </div>
    <div className="navbuttons font-nunito">
      <Link href="/login">
        <button disabled={false} className="font-semibold text-white border border-transparent shadow-secondary shadow-md bg-primary font-nunito rounded-xl hover:shadow-secondary hover:shadow-md hover:bg-white hover:border-primary hover:text-primary py-2 px-6 transition duration-300 ease-in-out">
          LOGIN
        </button>
      </Link>
      <Link href="/register">
        <button className="font-semibold text-white border border-transparent shadow-secondary shadow-md bg-primary font-nunito rounded-xl hover:shadow-secondary hover:shadow-md hover:bg-white hover:border-primary hover:text-primary py-2 px-6 transition duration-300 ease-in-out">REGISTER</button>
      </Link>
    </div>
  </nav>
  )
}
