'use client';
import Select from "react-select";
import {useState, useEffect, use} from 'react';

export default function Report1() {
  const [routes, setRoutes] = useState([]);
  const [selectedRoute, setSelectedRoute] = useState(null);

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

  const handleGetReport = () => {
    console.log(selectedRoute);
    // handle report generation logic here
  }

  return (
    <div className="font-nunito flex flex-col gap-2">
      <h1 className="text-xl">Given a flight no, all passengers travelling in it (next immediate flight) below age 18, 
above age 18</h1>
      <div className="flex flex-row gap-3">
        <Select 
          options={routes}
          value={selectedRoute}
          onChange={handleRouteChange}
          required
        />
        <button className="bg-slate-600 text-white rounded-md px-6 py-2" onClick={handleGetReport}>Get Report</button>
      </div>
    </div>
  );
}