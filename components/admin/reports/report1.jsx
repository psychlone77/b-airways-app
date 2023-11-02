'use client';
import Select from "react-select";
import {useState, useEffect, use} from 'react';

export default function Report1() {
  const [routes, setRoutes] = useState([]);
  const [selectedRoute, setSelectedRoute] = useState(null);
  const [reports, setReports] = useState([]);

  useEffect(() => {
    const getRoutes = async () => {
      const response = await fetch(`http://localhost:3000/search/api?field=route_id&table=route`);
      const routes = await response.json();
      const formattedRoutes = routes.rows.map(route => ({value: route.route_id, label: route.route_id}));
      setRoutes(formattedRoutes);
    };
    getRoutes();
  }, []);

  const handleRouteChange = (selectedOption) => {
    setSelectedRoute(selectedOption);
  }

  const handleGetReport = async(e) => {
      e.preventDefault();
      const response = await fetch(`http://localhost:3000/api/reports/1?route_id=${selectedRoute.value}`);
      const reports = await response.json();
      setReports(reports);
    console.log(selectedRoute);
    // handle report generation logic here
  }

  return (
    <div className="font-nunito flex flex-col gap-2">
      <h1 className="text-xl">Given a flight no, all passengers travelling in it (next immediate flight) below age 18, 
above age 18</h1>
      <form onSubmit={handleGetReport} >
        <div className="flex flex-row gap-4 justify-center items-center mt-4 mb-4">
          <label>Route</label>
          <Select
            options={routes}
            value={selectedRoute}
            onChange={handleRouteChange}
            required
          />
          <button type="submit" className="bg-slate-600 text-white rounded-md px-6 py-2 ml-5" >Get Report</button>
        </div>
      </form>
      <table className="table-auto">
        <thead>
          <tr>
            <th className="px-4 py-2">Name</th>
            <th className="px-4 py-2">Passport No</th>
            <th className="px-4 py-2">Age Group</th>
          </tr>
        </thead>
        <tbody>
          {reports.length === 0 ? (
            <tr>
              <td colSpan="3" className="border px-4 py-2 text-center">
                No results found
              </td>
            </tr>
          ) : (
            reports.map((report, index) => (
              <tr key={index}>
                <td className="border px-4 py-2">{report.name}</td>
                <td className="border px-4 py-2">{report.passport_no}</td>
                <td className="border px-4 py-2">{report.age_group}</td>
              </tr>
            ))
          )}
        </tbody>
      </table>
    </div>
  );
}