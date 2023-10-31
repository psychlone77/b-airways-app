'use client'
import { useState, useEffect } from "react";
import FlightDetails from "@/components/flightDetails/flightDetails";
import MultiStepForm from "../../../components/multiStepForm/multiStepForm";
import { useSearchParams } from "next/navigation";

export default function Form(){
    const params = useSearchParams();
    const schedule_id = params.get("schedule_id");
    const [flight, setFlight] = useState({});

    useEffect(() => {
        const getFlight = async () => {
            const response = await fetch(`http://localhost:3000/api/getFlight?schedule_id=${schedule_id}`);
            const flight = await response.json();
            setFlight(flight);
        };
        getFlight();
    }, []);

    return (
        <div className="flex flex-row justify-between p-5 flex-wrap-reverse">
            <MultiStepForm count={1}/>
            <FlightDetails flight={flight}/>
        </div>
    )
}