"use client";
import React from "react";
import { useState, useEffect } from "react";
import SeatSection from "@/components/seatSection/seatSection";
import FlightDetails from "@/components/flightDetails/flightDetails";

export default function SeatSelection(props) {
    const {formData, setFormData, nextStep, prevStep} = props;
    const [selectedSeats, setSelectedSeats] = useState(formData.bookedSeats);
    const [seats, setSeats] = useState([]);
    const [bookedSeats, setBookedSeats] = useState([]);
    //console.log(props);
    useEffect(() => {
        const getSeats = async () => {
            const response = await fetch(`/api/getSeats?schedule_id=${props.schedule_id}&class=${props.class}`);
            const data = await response.json();
            setSeats(data.seats);
            //console.log(data);
        }
        getSeats();
    }, []);

    useEffect(() => {
        const getBookedSeats = async () => {
            const response = await fetch(`/api/getSeats/Booked?schedule_id=${props.schedule_id}&class=${props.class}`);
            const data = await response.json();
            console.log(data);
            const bookedSeatsArray = data[0].Booked_Seats.split(",").map(seat => parseInt(seat.replace("S", "")));
            setBookedSeats(bookedSeatsArray);
        }
        getBookedSeats();
    }, []);
    //console.log(selectedSeats);
    const handleClick = () => {
        if (selectedSeats.length < props.count) {
            alert("Please select needed seats");
        }
        else{
            setFormData(() => ({
                ...formData,
                bookedSeats: selectedSeats,
            }));
            nextStep();
        }

    };

    async function seatClick(seatNumber) {
        if (selectedSeats.includes(seatNumber)) {
            setSelectedSeats(selectedSeats.filter((seat) => seat !== seatNumber));
        } else {
            if (selectedSeats.length < props.count) {
                setSelectedSeats([...selectedSeats, seatNumber]);
            }
        }
    }
    
    let seatsPerRow;

    if(props.class === 'Economy'){
        seatsPerRow = 8;
    }
    else if(props.class === 'Business'){
        seatsPerRow = 4;
    }
    else{
        seatsPerRow = 2;
    }
    

    let seatSection;
        seatSection = (
            <SeatSection
                onButtonClick={seatClick}
                title={props.class}
                seatsPerRow={seatsPerRow}
                seatRows={seats/seatsPerRow}
                bookedSeats={bookedSeats}
                selectedSeats={selectedSeats}
                count={props.count}
            />
        );

    return (
        <div className="mt-10 w-fit flex flex-row gap-10 justify-center">
            <div className="bg-secondary flex flex-col gap-8 justify-center rounded-2xl max-w-fit p-5 self-center shadow-secondary shadow-xl mb-3">
                {seatSection}
            </div>
            <div>
                <div className="flex flex-wrap flex-col p-5 rounded-xl border border-gray-400 font-nunito shadow-md shadow-secondary mb-5 bg-primary text-white">
                    <div className="flex flex-col gap-3">
                        <h2 className="font-semibold">Selected Seats</h2>
                        <div className="flex flex-row flex-wrap gap-2 items-center">
                            <h2 className="font-semibold:">{props.class}:</h2>
                            {selectedSeats.map((_, i) => {
                                return (
                                    <button
                                        className="w-8 h-8 rounded-md text-sm text-primary text-center align-middle bg-white"
                                        key={i}
                                        disabled={true}
                                    >
                                        {_}
                                    </button>
                                );
                            })}
                        </div>
                    </div>
                </div>
                <div className="flex flex-col gap-2 items-center">
                    <button onClick={prevStep}
                        className="w-3/4 text-white border border-transparent bg-tertiary font-nunito rounded-full py-2 px-6 transition duration-300 ease-in-out hover:shadow-secondary hover:shadow-md hover:bg-white hover:border-tertiary hover:text-tertiary"
                    >
                        Go Back
                    </button>
                    <button onClick={handleClick}
                        className="w-full text-white border border-transparent bg-primary font-nunito rounded-full py-2 px-6 transition duration-300 ease-in-out hover:shadow-secondary hover:shadow-md hover:bg-white hover:border-primary hover:text-primary"
                    >
                        Book Seats
                    </button>
                </div>
            </div>
        </div>
    );
}
