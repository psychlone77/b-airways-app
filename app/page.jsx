"use client";
import React from "react";
import { SessionProvider, useSession } from "next-auth/react";
import NavBar from "@/components/navbar/navbar";

export default function Home(props) {
  return (
    <SessionProvider session={props.session}>
      <HomeContent />
    </SessionProvider>
  );
}

function HomeContent() {
  const { data: session } = useSession();
  return (
    <div className="bg-[url('/airplane.jpg')] bg-cover bg-center h-screen flex flex-col items-center">
      <div className="w-full mb-10">
        <NavBar session={session}/>
      </div>
      <h1 className="font-nunito font-bold text-center text-3xl text-transparent bg-clip-text bg-gradient-to-r from-primary via-purple-500 to-pink-400 ">
        Welcome to
      </h1>
      <h1 className="font-nunito font-bold text-center text-8xl text-transparent bg-clip-text bg-gradient-to-r from-primary via-purple-500 to-pink-400 ">
        B Airways
      </h1>
    </div>
  );
}
