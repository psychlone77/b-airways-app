'use client'
import React from 'react';
import { useSession, SessionProvider } from 'next-auth/react';
import { useSearchParams } from 'next/navigation';
import { useState, useEffect } from 'react';
import Link from 'next/link';

import PassengerForms from './passengerForms';
import SeatSelection from './seatSelection';
import ConfirmPage from './confirmPage';
import LoadingPage from '../loading/loadingPage';

function MultiStepForm(props){
    const params = useSearchParams();
    const schedule_id = params.get('schedule_id');
    const { status, data: session } = useSession();

    const [user, setUser] = useState(null);
    useEffect(() => {
        const getUser = async () => {
            const response = await fetch(`/api/getUser?user_id=${session?.user.user_id}`);
            const data = await response.json();
            setUser(data);
            //console.log('this is form data',data);
        };
        getUser();
    }, [session]);
    //console.log('this is form user',user);
    const [step, setStep] = useState(1);
    const [formData, setFormData] = useState({
        class: props.class,
        seatCount: props.count,
        passengers: Array.from({ length: props.count }, () => ({ name: '', dob: '', passport_no: '' })),
        bookedSeats: []
    });

    const nextStep = () => {
        setStep(step + 1);
    };

    const next2Step = () => {
        setStep(step + 2);
    };

    const prevStep = () => {
        setStep(step - 1);
    };

    const submitForm = () => {
        // Handle form submission, e.g., send data to the server
        console.log('Form submitted:', formData);
    };
    if(status === 'loading') return <LoadingPage />;
    else{
    switch (step) {
        case 1:
            return session ? (
                <PassengerForms user={user} count={props.count} formData={formData} setFormData={setFormData} nextStep={next2Step} />
            ) : (
                <div className="h-[calc(100vh-170px)] flex flex-col justify-center items-center font-nunito gap-4">
                <Link
                  className="text-2xl font-nunito bg-primary text-white rounded-md py-5 px-20"
                  href="/login"
                >
                  Login
                </Link>
                  <div onClick={nextStep} className='hover:cursor-pointer'>
                    Continue as Guest
                  </div>
              </div>
            );
        case 2:
            return <PassengerForms count={props.count} formData={formData} setFormData={setFormData} nextStep={nextStep} />;
        case 3:
            return <SeatSelection count={props.count} class={props.class} formData={formData} setFormData={setFormData} nextStep={nextStep} prevStep={prevStep} submitForm={submitForm} />;
        case 4:
            return <ConfirmPage formData={formData} prevStep={prevStep} handleSubmit={submitForm} />;
        default:
            return null;
    }
    }
};

export default function WrappedMultiStepForm(props) {
    return (
        <SessionProvider session={props.session}>
            <MultiStepForm {...props} />
        </SessionProvider>
    );
}
