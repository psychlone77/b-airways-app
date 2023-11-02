import Select from "react-select";
import { useState, useEffect } from "react";

export default function Report4() {
    const [airports, setAirports] = useState([]);
    const [origin, setOrigin] = useState(null);
    const [destination, setDestination] = useState(null);
    const [reports, setReports] = useState([]);

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
    const handleOriginChange = (selectedOption) => {
        setOrigin(selectedOption);
    };

    const handleDestinationChange = (selectedOption) => {   
        setDestination(selectedOption);
    };

    const handleGetReport = async (e) => {
        e.preventDefault();
        const response = await fetch(
            `http://localhost:3000/api/reports/4?origin=${origin.value}&destination=${destination.value}`
        );
        const reports = await response.json();
        setReports(reports);
    };

    return (
        <div className="font-nunito">
            <h1 className="text-xl mb-5">
                Given origin and destination, all past flights, states, passenger counts
                data
            </h1>
            <div className="flex flex-col gap-5 items-center">
                <form onSubmit={handleGetReport}>
                    <div className="flex flex-row gap-5 items-center">
                        <label>Origin</label>
                        <Select
                            options={airports}
                            onChange={handleOriginChange}
                            value={origin}
                            required
                        />
                        <label>Destination</label>
                        <Select
                            options={airports}
                            onChange={handleDestinationChange}
                            value={destination}
                            required
                        />
                        <button
                            type="submit"
                            className="bg-slate-600 text-white rounded-md px-6 py-2"
                        >
                            Get Report
                        </button>
                    </div>
                </form>
                {reports.length > 0 ? (
                    <table className="table-auto w-full">
                        <thead>
                            <tr>
                                <th className="px-4 py-2">Flight</th>
                                <th className="px-4 py-2">Aircraft ID</th>
                                <th className="px-4 py-2">State</th>
                                <th className="px-4 py-2">No. of Passengers</th>
                            </tr>
                        </thead>
                        <tbody>
                            {reports.map((report) => (
                                <tr key={report.flight} className="text-center">
                                    <td className="border px-4 py-2">{report.flight}</td>
                                    <td className="border px-4 py-2">{report.aircraft_id}</td>
                                    <td className="border px-4 py-2">{report.state}</td>
                                    <td className="border px-4 py-2">{report.no_of_passengers}</td>
                                </tr>
                            ))}
                        </tbody>
                    </table>
                ) : (
                    <>
                        <table className="table-auto w-full">
                            <thead>
                                <tr>
                                    <th className="px-4 py-2">Flight</th>
                                    <th className="px-4 py-2">Aircraft ID</th>
                                    <th className="px-4 py-2">State</th>
                                    <th className="px-4 py-2">No. of Passengers</th>
                                </tr>
                            </thead>
                        </table>
                        <p>No Results Found</p>
                    </>
                )}
            </div>
        </div>
    );
}
