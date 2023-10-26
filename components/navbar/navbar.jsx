import React from "react";
import Link from "next/link";
import Image from "next/image";
import { useSession, SessionProvider, signOut } from "next-auth/react";

export default function NavBar(props) {
  const session = props.session;
  const buttons = session ? (
    <div className="flex flex-row items-center gap-3">
      <div className="flex flex-row gap-3 text-md" onClick={signOut}>
        Hello {session.user.first_name}
      </div>
      {/* <button
        onClick={signOut}
        className="font-semibold text-white border border-transparent shadow-secondary shadow-md bg-primary font-nunito rounded-xl hover:shadow-secondary hover:shadow-md hover:bg-white hover:border-primary hover:text-primary py-2 px-6 transition duration-300 ease-in-out"
      >
        LOGOUT
      </button> */}
        <Link href="/profile">
          <svg
            className="fill-current text-primary"
            xmlns="http://www.w3.org/2000/svg"
            height="45"
            viewBox="0 -960 960 960"
            width="45"
          >
            <path d="M234-276q51-39 114-61.5T480-360q69 0 132 22.5T726-276q35-41 54.5-93T800-480q0-133-93.5-226.5T480-800q-133 0-226.5 93.5T160-480q0 59 19.5 111t54.5 93Zm246-164q-59 0-99.5-40.5T340-580q0-59 40.5-99.5T480-720q59 0 99.5 40.5T620-580q0 59-40.5 99.5T480-440Zm0 360q-83 0-156-31.5T197-197q-54-54-85.5-127T80-480q0-83 31.5-156T197-763q54-54 127-85.5T480-880q83 0 156 31.5T763-763q54 54 85.5 127T880-480q0 83-31.5 156T763-197q-54 54-127 85.5T480-80Zm0-80q53 0 100-15.5t86-44.5q-39-29-86-44.5T480-280q-53 0-100 15.5T294-220q39 29 86 44.5T480-160Zm0-360q26 0 43-17t17-43q0-26-17-43t-43-17q-26 0-43 17t-17 43q0 26 17 43t43 17Zm0-60Zm0 360Z" />
          </svg>
        </Link>
    </div>
  ) : (
    <>
      <Link href="/login">
        <button
          disabled={false}
          className="font-semibold text-white border border-transparent shadow-secondary shadow-md bg-primary font-nunito rounded-xl hover:shadow-secondary hover:shadow-md hover:bg-white hover:border-primary hover:text-primary py-2 px-6 transition duration-300 ease-in-out"
        >
          LOGIN
        </button>
      </Link>
      <Link href="/register">
        <button className="font-semibold text-white border border-transparent shadow-secondary shadow-md bg-primary font-nunito rounded-xl hover:shadow-secondary hover:shadow-md hover:bg-white hover:border-primary hover:text-primary py-2 px-6 transition duration-300 ease-in-out">
          REGISTER
        </button>
      </Link>
    </>
  );

  return (
    <nav className="flex flex-row justify-center items-center p-5 bg-transparent">
      <div className="flex mr-auto">
        <p className=" text-4xl font-museo font-bold text-primary">
          <Link href="/">B AIRWAYS</Link>
        </p>
      </div>
      <div className="absolute flex flex-row gap-10 font-nunito">
        <Link href="/search">
          <span>SEARCH</span>
        </Link>
        <Link href="/aboutUs">
          <span>ABOUT US</span>
        </Link>
      </div>
      <div className="flex flex-row gap-2 font-nunito ml-auto">
        {buttons}
      </div>
    </nav>
  );
}
