import "./navbar.css";
import React from "react";
import Link from "next/link";

export interface NavbarProps {
  className?: string;
}

export const Navbar: React.FC<NavbarProps> = ({ className = "" }) => (
  <nav className="nav">
    <p className="navbartitle">
      <Link href="/">B AIRWAYS</Link>
    </p>
    <div className="Links">
    <Link href="/search">
        <span>SEARCH</span>
      </Link>
      <Link href="/aboutUs">
        <span>ABOUT US</span>
      </Link>
    </div>
    <div className="navbuttons">
      <Link href="/login">
        <button disabled={false} className="button">
          LOGIN
        </button>
      </Link>
      <Link href="/register">
        <button className="button buttonHover">REGISTER</button>
      </Link>
    </div>
  </nav>
);
