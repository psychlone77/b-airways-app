import React from 'react';

export default function FlightDetails(props) {
  const departureDate = new Date(props.flight.scheduled_departure).toLocaleDateString('en-GB');
  const departureTime = new Date(props.flight.scheduled_departure).toLocaleTimeString('en-US', {hour: '2-digit', minute:'2-digit'});
  return (
    <div className=" max-h-fit flex flex-wrap flex-col p-5 rounded-xl border border-gray-400 font-nunito shadow-md shadow-secondary mb-5 bg-primary text-white">
      <div>Flight Number: {props.flight.route_id}</div>
      <div>Departure Time: {departureTime}</div>
      <div>Departure Date: {departureDate}</div>
    </div>
  );
}
