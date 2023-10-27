"use client";
import React from "react";
import { SessionProvider, useSession } from "next-auth/react";
import Image from "next/image";
import NavBar from "@/components/navbar/navbar";
import LoadingPage from "@/components/loading/loadingPage";

export default function Home(props) {
  return (
    <SessionProvider session={props.session}>
      <HomeContent />
    </SessionProvider>
  );
}

function HomeContent() {
  const { status,data: session } = useSession();
  if (status === "loading") {
    return <LoadingPage />;
  }
  return (
    <div className="h-[calc(100vh-170px)] flex flex-col items-center">
      <div style={{ position: "fixed", top: 0, left: 0, zIndex: -1 }}>
        <img src='/airplane.jpg'/>
      </div>
      <div className="w-full mb-10">
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
