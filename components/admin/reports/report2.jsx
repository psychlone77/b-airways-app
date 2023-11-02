import { useState, useEffect } from "react";
import Select from "react-select";

export default function Report2() {
  const [fromDate, setFromDate] = useState("");
  const [toDate, setToDate] = useState("");
  const [selectedAirport, setSelectedAirport] = useState(null);
  const [airports, setAirports] = useState([]);
  const [report, setReport] = useState([]);

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

  const handleAirportChange = (selectedOption) => {
    setSelectedAirport(selectedOption);
  };

  const handleGetReport = async (e) => {
    e.preventDefault();
    const response = await fetch(
      `http://localhost:3000/api/reports/2?from=${fromDate}&to=${toDate}&destination=${selectedAirport.value}`
    );
    const report = await response.json();
    console.log(fromDate, toDate, selectedAirport.value);
    console.log(report);
    setReport(report);
    // handle report generation logic here
  };

  return (
    <div className="font-nunito">
      <h1 className="text-xl mb-5">
        Given a date range, number of passengers travelling to a given
        destination{" "}
      </h1>
      <div className="flex flex-col gap-5 items-center">
        <form
          className="flex flex-row items-center gap-10"
          onSubmit={handleGetReport}
        >
          <div>
            <label className="mr-2">From</label>
            <input
                className="border border-gray-300 rounded-md px-2 py-1"
              required
              type="date"
              value={fromDate}
              onChange={(e) => setFromDate(e.target.value)}
            />
          </div>
          <div>
            <label className="mr-2">To</label>
            <input
                className="border border-gray-300 rounded-md px-2 py-1"
              required
              type="date"
              value={toDate}
              onChange={(e) => setToDate(e.target.value)}
            />
          </div>
          <div className="flex flex-row gap-2 items-center">
            <label className="mr-2">Destination</label>
            <Select
              options={airports}
              value={selectedAirport}
              onChange={handleAirportChange}
              required
            />
          </div>
          <button
          type="submit"
            className="bg-slate-600 text-white rounded-md px-6 py-2"
          >
            Get Report
          </button>
        </form>
        <table className="table-auto">
          <thead>
            <tr>
              <th className="px-4 py-2">Number of Passengers</th>
            </tr>
          </thead>
          <tbody>
            {report.length === 0 ? (
              <tr>
                <td colSpan="3" className="border px-4 py-2 text-center">
                  No results found
                </td>
              </tr>
            ) : (
              <tr>
                <td className="border px-4 py-2">
                  {report[0].no_of_passengers}
                </td>
              </tr>
            )}
          </tbody>
        </table>
      </div>
    </div>
  );
}
