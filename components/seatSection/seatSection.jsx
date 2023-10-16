import React from 'react';

export default function SeatSection(props) {
    const seatsArray = Array.from({ length: props.seatCount });
  return (
    <div>
      <div className='bg-white font-nunito rounded-md p-5'>
      {props.title}
      <div>
      {seatsArray.map((_, index) => (
            <button key={index}>Seat {index + 1}</button>
          ))}
      </div>
      </div>
    </div>
  );
}