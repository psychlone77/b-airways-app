import Link from "next/link";
import Image from "next/image";

export default function FlightChip(props) {
  return (
    <div className="mb-8">
      <Link href={{pathname: "/search/redirect", query:{schedule_id: '01'}}}>
          <div className="border border-secondary shadow-sm shadow-tertiary hover:shadow-md hover:shadow-tertiary flex flex-row items-center flex-wrap gap-24 p-5 rounded-lg font-nunito justify-around  transition duration-300 ease-in-out">
            <Image src="/travel.svg" height={30} width={30}/>
            <div className="flex flex-col gap-1">
              <h1 className="text-2xl text-primary"> R001 </h1>
              <h2 className="text-sm"> FROM - TO</h2>
            </div>
            <div className="flex flex-col gap-1">
              <h1> Departure Date </h1>
              <h2> Departure Time</h2>
            </div>
            <div>
              <h1> Class </h1>
            </div>
            <div className="flex flex-col gap-1">
              <h2 className="text-xl text-pink-600"> Full Price</h2>
              <h1 className="text-sm"> Seat Price </h1>
            </div>
            <div className="text-3xl text-purple-600">
                →
            </div>
          </div>
      </Link>
    </div>
  );
}
