import React, { useEffect, useState } from "react";

export default function PassengerForm(props) {
    const { index, formData, setFormData, user } = props;
    const [localData, setLocalData] = useState(formData.passengers[index]);
    
    useEffect(() => {
        // Update local state when formData changes
        setLocalData(formData.passengers[index] || {});
    }, [formData, index]);

    const handleChange = (e) => {
        const { name, value } = e.target;

        // Update the local state
        setLocalData((prevData) => ({
            ...prevData,
            [name]: value,
        }));

        // Clone the passengers array from formData and update the specific passenger object based on the index
        const updatedPassengers = formData.passengers;
        updatedPassengers[index] = { ...localData, [name]: value };

        // Clone the formData object and update the passengers property
        console.log(formData)
        setFormData(() => ({
            ...formData,
            passengers: updatedPassengers,
        }));
    };

    return (
        <div className="border border-primary rounded-md p-5 flex flex-col gap-3 font-nunito shadow-sm shadow-gray-500">
            <h2 className="text-xl">Passenger {index + 1}</h2>
            <div className="flex flex-row gap-3 flex-wrap">
                    <input
                        className="w-fit border border-gray-400 rounded-md p-1"
                        placeholder="Name*"
                        type="text"
                        id={`name-${index}`}
                        name={`name`}
                        value={localData.name}
                        onChange={handleChange}
                        required
                    />
                    <input
                        className="w-fit border border-gray-400 rounded-md p-1"
                        type="date"
                        id={`dob-${index}`}
                        name={`dob`}
                        value={localData.dob}
                        onChange={handleChange}
                        required
                    />
                    <input
                        className="w-fit border border-gray-400 rounded-md p-1"
                        placeholder="Passport No.*"
                        type="text"
                        id={`passport-${index}`}
                        name={`passport_no`}
                        value={localData.passport_no}
                        onChange={handleChange}
                        required
                    />
            </div>
        </div>
    );
}
