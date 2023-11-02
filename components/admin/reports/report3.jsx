import { useState } from "react";

export default function Report3() {
  const [fromDate, setFromDate] = useState("");
  const [toDate, setToDate] = useState("");
  const [report, setReport] = useState([]);

  const handleGetReport = async (e) => {
    e.preventDefault();
    const response = await fetch(
      `http://localhost:3000/api/reports/3?from=${fromDate}&to=${toDate}`
    );
    const report = await response.json();
    // console.log(fromDate, toDate, selectedAirport.value);
    // console.log(report);
    setReport(report);
    // handle report generation logic here
    //console.log(`From: ${fromDate}, To: ${toDate}`);
  };

  return (
    <div className="font-nunito">
      <h1 className="text-xl mb-5">
        Given a date range, number of bookings by each passenger type
      </h1>
      <div className="flex flex-col gap-5 items-center">
        <form
          className="flex flex-row items-center gap-10"
          onSubmit={handleGetReport}
        >
          <label>From</label>
          <input
            className="border border-gray-300 rounded-md px-2 py-1"
            required
            type="date"
            value={fromDate}
            onChange={(e) => setFromDate(e.target.value)}
          />
          <label>To</label>
          <input
            className="border border-gray-300 rounded-md px-2 py-1"
            required
            type="date"
            value={toDate}
            onChange={(e) => setToDate(e.target.value)}
          />
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
              <th className="px-4 py-2">Class Name</th>
              <th className="px-4 py-2">No. of Bookings</th>
            </tr>
          </thead>
        <tbody>
            {report.length === 0 ? (
                <tr>
                    <td colSpan="2" className="text-center">
                        No results found
                    </td>
                </tr>
            ) : (
                report.map((item) => (
                    <tr key={item.class_name} className="text-center">
                        <td className="border px-4 py-2">{item.class_name}</td>
                        <td className="border px-4 py-2">{item.no_of_bookings}</td>
                    </tr>
                ))
            )}
        </tbody>
        </table>
      </div>
    </div>
  );
}
