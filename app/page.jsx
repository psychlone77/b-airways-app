import React from "react";

export default async function Home() {
  //console.log(airports)
  return (
    <div>
      <div className="bg-[url('/airplane.jpg')] bg-cover bg-center h-screen flex flex-col items-center pt-10">
        <h1 className="font-nunito font-bold text-center text-3xl text-transparent bg-clip-text bg-gradient-to-r from-primary via-purple-500 to-pink-400 ">
          Welcome to
        </h1>
        <h1 className="font-nunito font-bold text-center text-8xl text-transparent bg-clip-text bg-gradient-to-r from-primary via-purple-500 to-pink-400 ">
          B Airways
        </h1>
      </div>
    </div>
  );
}
