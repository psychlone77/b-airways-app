'use client'
import React, { useState } from 'react';
import PassengerForms from './passengerForms';
import SeatSelection from './seatSelection';

export default function MultiStepForm(props){
    const [step, setStep] = useState(1);
    const [formData, setFormData] = useState({
        passengers: Array.from({ length: props.count }, () => ({ name: '', age: '', passport_no: '' })),
        bookedSeats: Array.from({ length: props.count }, () => '')
    });

    const nextStep = () => {
        setStep(step + 1);
    };

    const prevStep = () => {
        setStep(step - 1);
    };

    const submitForm = () => {
        // Handle form submission, e.g., send data to the server
        console.log('Form submitted:', formData);
    };

    switch (step) {
        case 1:
            return <PassengerForms count={props.count} formData={formData} setFormData={setFormData} nextStep={nextStep} />;
        case 2:
            return <SeatSelection count={props.count} class={props.class} formData={formData} setFormData={setFormData} nextStep={nextStep} prevStep={prevStep} submitForm={submitForm} />;
        case 3:
            return <div>Welcome {console.log(formData)}</div>
        default:
            return null;
    }
};
