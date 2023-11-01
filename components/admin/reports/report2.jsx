import { useState } from 'react';

export default function Report2() {
    const [fromDate, setFromDate] = useState('');
    const [toDate, setToDate] = useState('');

    const handleGetReport = () => {
        console.log(fromDate, toDate);
        // write your code to get report here
    }

    return(
        <div className="font-nunito">
            <h1 className="text-xl mb-5">Given a date range, number of passengers travelling to a given destination </h1>
            <div className="flex flex-row gap-20 items-center">
                <label>From</label>
                <input type="date" value={fromDate} onChange={(e) => setFromDate(e.target.value)} />
                <label>To</label>
                <input type="date" value={toDate} onChange={(e) => setToDate(e.target.value)} />
                <button className="bg-slate-600 text-white rounded-md px-6 py-2" onClick={handleGetReport}>Get Report</button>
            </div>
        </div>
    )
}