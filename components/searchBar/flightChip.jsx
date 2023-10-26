export default function FlightChip(props) {
  return (
    <div>
      <div className="border border-gray-700 shadow-md shadow-secondary flex flex-row items-center flex-wrap gap-24 p-5 rounded-lg font-nunito justify-around">
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
    </div>
  );
}
