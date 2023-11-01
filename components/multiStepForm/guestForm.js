import React, { useState } from "react";

export default function GuestForm(props) {
    const { formData, setFormData } = props;
    const [localData, setLocalData] = useState(formData.passengers[0] || {});

    const handleChange = (e) => {
        const { name, value } = e.target;

        // Update the local state
        setLocalData((prevData) => ({
            ...prevData,
            [name]: value,
        }));

        const updatedPassengers = formData.passengers;
        updatedPassengers[0] = { ...localData, [name]: value };
        // Update the formData object
        setFormData(() => ({
            ...formData,
            passengers: updatedPassengers,
        }));
        console.log(formData)
    };

    return (
        <div className="border border-primary rounded-md p-5 flex flex-col gap-3 font-nunito shadow-sm shadow-gray-500">
            <h2 className="text-xl">Guest Information</h2>
            <div className="flex flex-col gap-3 flex-wrap w-96">
                <input
                    className="w-fit border border-gray-400 rounded-md p-1"
                    placeholder="Name*"
                    type="text"
                    id="name"
                    name="name"
                    value={localData.name}
                    onChange={handleChange}
                    required
                />
                <input
                    className="w-fit border border-gray-400 rounded-md p-1"
                    placeholder="Email*"
                    type="email"
                    id="email"
                    name="email"
                    value={localData.email}
                    onChange={handleChange}
                    required
                />
                <input
                    className="w-fit border border-gray-400 rounded-md p-1"
                    type="date"
                    id="dob"
                    name="dob"
                    value={localData.dob}
                    onChange={handleChange}
                    required
                />
                <input
                    className="w-full border border-gray-400 rounded-md p-1"
                    placeholder="Address*"
                    type="text"
                    id="address"
                    name="address"
                    value={localData.address}
                    onChange={handleChange}
                    required
                />
                <input
                    className="w-fit border border-gray-400 rounded-md p-1"
                    placeholder="Passport No.*"
                    type="text"
                    id="passport_no"
                    name="passport_no"
                    value={localData.passport_no}
                    onChange={handleChange}
                    required
                />
            </div>
            <button onClick={props.nextStep}>Next Step</button>
        </div>
    );
}