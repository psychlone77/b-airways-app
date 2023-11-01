import { useState } from "react";

export default function Report3() {
    const [fromDate, setFromDate] = useState("");
    const [toDate, setToDate] = useState("");

    const handleGetReport = () => {
        // TODO: Implement function to handle getting report
        console.log(`From: ${fromDate}, To: ${toDate}`);
    };

    return (
        <div className="font-nunito">
            <h1 className="text-xl mb-5">
                Given a date range, number of bookings by each passenger type
            </h1>
            <div className="flex flex-row gap-20 items-center">
                <label>From</label>
                <input type="date" value={fromDate} onChange={(e) => setFromDate(e.target.value)} />
                <label>To</label>
                <input type="date" value={toDate} onChange={(e) => setToDate(e.target.value)} />
                <button className="bg-slate-600 text-white rounded-md px-6 py-2" onClick={handleGetReport}>
                    Get Report
                </button>
            </div>
        </div>
    );
}
