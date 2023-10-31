"use client";
import {React, useEffect, useState} from "react";
import { SessionProvider, useSession } from "next-auth/react";
import Image from "next/image";
import NavBar from "@/components/navbar/navbar";
import TFlightChip from "@/components/searchBar/tFlightChip";
import LoadingPage from "@/components/loading/loadingPage";



export default function Home(props) {
  return (
    <SessionProvider session={props.session}>
      <HomeContent />
    </SessionProvider>
  );
}

function HomeContent() {

  const [flights, setFlights] = useState([]);
  const { status, data: session } = useSession();

  useEffect(() => {
    const getFlights = async () => {
      const response = await fetch("http://localhost:3000/api/getTodayFlights");
      const flights = await response.json();
      setFlights(flights);
      console.log(flights);
    };
    getFlights();
  }, []);

  if (status === "loading") {
    return <LoadingPage />;
  }
  return (
    <div className="flex flex-col items-center">
      <div className="fixed w-screen h-screen top-0 left-0 right-0 bg-fixed bg-[url(/airplane.jpg)] bg-cover bg-origin-border bg-center -z-50"></div>
      {/* <Image
        src='/airplane.jpg'
        alt="logo"
        fill
        //style={ background-attachment : 'fixed' }
        // sizes="100vw"
        className="bg-fixed object-cover -z-10"
      /> */}
      <div className="w-full mb-10"></div>
      <h1 className="font-nunito font-bold text-center text-3xl text-transparent bg-clip-text bg-gradient-to-r from-primary via-purple-500 to-pink-400 ">
        Welcome to
      </h1>
      <h1 className="font-nunito font-bold text-center text-8xl text-transparent bg-clip-text bg-gradient-to-r from-primary via-purple-500 to-pink-400 ">
        B Airways
      </h1>
      <div className="flex flex-col items-center mt-[450px] text-4xl text-white font-nunito animate-bounce">
        <h2 className="text-lg font-nunito">Today's Flights</h2>
        ↓
      </div>
      <div className="mt-20">
      {flights.map((flight) => (
          <TFlightChip key={flight.schedule_id} flight={flight}/>
        ))}
        </div>
    </div>
  );
}
