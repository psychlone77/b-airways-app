import React, { useState, useEffect, use } from 'react';
import PassengerForm from './passengerForm';

export default function PassengerForms(props) {
    const { count, formData, setFormData, nextStep } = props;
    const [passengerForms, setPassengerForms] = useState([]);

    useEffect(() => {
        if (props.user && props.user.birth_date) {
            let dob = new Date(props.user.birth_date);
            if (!isNaN(dob)) { // check if dob is a valid date
                let formattedDob = dob.toISOString().substring(0, 10);
                const p = {
                    name: `${props.user.first_name} ${props.user.last_name}`, 
                    dob: formattedDob, 
                    passport_no: props.user.passport_no,
                    email: props.user.email,
                    address: props.user.address}
                setFormData(prevFormData => ({...prevFormData, passengers: [p]}))
            }
        }
    }, [formData, props.user]);
    //console.log(props.user)
    useEffect(() => {
        const forms = [];
        for (let i = 0; i < count; i++) {
        forms.push(
            <PassengerForm
            user={props.user}
            key={i}
            index={i}
            formData={formData}
            setFormData={setFormData}
            />
        );
        }
        setPassengerForms(forms);
    }, [count, props.user]);
    
    const handleSubmit = (e) => {
        e.preventDefault();
        nextStep();
    };
    
    return (
        <div>
        <h1 className='text-2xl text-primary font-nunito font-semibold mb-5'>Passenger Details</h1>
        <form className='flex flex-col gap-5 items-center' onSubmit={handleSubmit}>
            {passengerForms.map((form) => form)}
            <button class="w-60 text-white border border-transparent bg-primary font-nunito rounded-full py-2 px-6 transition duration-300 ease-in-out hover:shadow-secondary hover:shadow-md hover:bg-white hover:border-primary hover:text-primary" type="submit">Next</button>
        </form>
        </div>
    );
    }