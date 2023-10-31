import Link from "next/link";
import Image from "next/image";

export default function FlightChip(props) {
  const flight = props.flight;
  const departureDate = new Date(flight.scheduled_departure).toLocaleDateString('en-GB');
  const departureTime = new Date(flight.scheduled_departure).toLocaleTimeString('en-US', {hour: '2-digit', minute:'2-digit'});
  
  console.log(flight);
  return (
    <div className="mb-8">
      <Link href={{pathname: "/form", query:{schedule_id: flight.schedule_id, class:props.sclass}}}>
          <div className="border border-secondary shadow-sm shadow-tertiary hover:shadow-md hover:shadow-tertiary flex flex-row items-center flex-wrap gap-16 p-5 rounded-lg font-nunito justify-around  transition duration-300 ease-in-out">
            <Image src="/travel.svg" height={30} width={30}/>
            <div className="flex flex-col gap-1">
              <h1 className="text-2xl text-primary"> {flight.route_id} </h1>
              <h2 className="text-sm"> {flight.route_origin} - {flight.route_destination}</h2>
            </div>
            <div className="font-nunito font-thin text-gray-500 text-sm">
              <h1> From {flight.airport_origin} </h1>
              <h1> To {flight.airport_dest} </h1>
            </div>
            <div className="flex flex-col gap-1">
              <h1> {departureDate} </h1>
              <h2> {departureTime}</h2>
            </div>
            <div className="flex flex-col gap-1">
              <h2 className="text-xl text-pink-600"> LKR {flight.price * props.count}</h2>
              <h1 className="text-sm"> LKR {flight.price} </h1>
            </div>
            <div className="text-3xl text-purple-600">
                →
            </div>
          </div>
      </Link>
    </div>
  );
}
