import Select from "react-select";
import { useState, useEffect } from "react";

export default function Report4() {
    const [airports, setAirports] = useState([]);
    const [origin, setOrigin] = useState(null);
    const [destination, setDestination] = useState(null);

    useEffect(() => {
        const getAirports = async () => {
            const response = await fetch(
                `http://localhost:3000/search/api?field=airport_code&table=airport`
            );
            const airports = await response.json();
            const formattedAirports = airports.rows.map((airport) => ({
                value: airport.airport_code,
                label: airport.airport_code,
            }));
            setAirports(formattedAirports);
        };
        getAirports();
    }, []);

    const handleGetReport = () => {
        console.log(origin, destination);
        if (origin && destination) {
            // TODO: handle get report with origin and destination
        }
    };

    return (
        <div className="font-nunito flex flex-col gap-2">
            <h1 className="text-xl">
                Given origin and destination, all past flights, states, passenger counts
                data
            </h1>
            <div className="flex flex-row gap-5 items-center">
                <label>Origin</label>
                <Select options={airports} onChange={setOrigin} value={origin} required />
                <label>Destination</label>
                <Select options={airports} onChange={setDestination} value={destination} required />
                <button className="bg-slate-600 text-white rounded-md px-6 py-2" onClick={handleGetReport}>
                    Get Report
                </button>
            </div>
        </div>
    );
}
