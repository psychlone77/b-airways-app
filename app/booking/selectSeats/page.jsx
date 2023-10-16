import React from "react";
import SeatSection from "@/components/seatSection/seatSection";

export default function SelectSeats() {
  return (
    <div className="flex flex-row justify-around">
      <div className="bg-secondary flex flex-col gap-5 justify-center rounded-md max-w-fit p-5 self-center">
        <SeatSection title={"Platinum"} seatCount={3} />
        <SeatSection title={"Business"} />
        <SeatSection title={"Economy"} />
      </div>
    </div>
  );
}
