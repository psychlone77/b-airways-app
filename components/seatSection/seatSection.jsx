import React from "react";

export default function SeatSection(props) {
  const seatsPerRow = Array.from({ length: props.seatsPerRow });
  const seats = Array.from({ length: props.seatRows });
  const bookedSeats = props.bookedSeats;
  const selectedSeats = props.selectedSeats;

  const handleButtonClick = (seatNumber) => {
    props.onButtonClick(seatNumber);
  };

  const isDisabled = selectedSeats.length === props.count;

  return (
    <div>
      <div className="flex flex-col items-center bg-white font-nunito rounded-3xl p-5">
        <h1 className="text-center">{props.title}</h1>
        <div className="mt-3 flex flex-col gap-3">
          {seats.map((_, i) => (
            <div key={i} className="flex flex-row gap-3">
              {seatsPerRow.map((_, j) => {
                const seatNumber = i * props.seatsPerRow + j + 1;
                const isBooked = bookedSeats.includes(seatNumber);
                const isSelected = selectedSeats.includes(seatNumber);
                return (
                  <button onClick={() => handleButtonClick(seatNumber)}
                  className={`${
                    isBooked ? "bg-gray-400" : isSelected ? " bg-pink-400" : "bg-primary"
                  } w-8 h-8 rounded-md text-sm text-white text-center align-middle ${
                    isDisabled ? "" : "hover:bg-secondary"
                  }`}
                    key={j}
                    disabled={isBooked} // Disable the button for booked seats and when isDisabled is true
                  >
                    {seatNumber}
                  </button>
                );
              })}
            </div>
          ))}
        </div>
      </div>
    </div>
  );
}
