"use client";
import React, { use } from "react";
import { useSession, SessionProvider } from "next-auth/react";
import { useSearchParams } from "next/navigation";
import { useState, useEffect } from "react";
import Link from "next/link";

import PassengerForms from "./passengerForms";
import SeatSelection from "./seatSelection";
import ConfirmPage from "./confirmPage";
import LoadingPage from "../loading/loadingPage";
import GuestForm from "./guestForm";

function MultiStepForm(props) {
  const params = useSearchParams();
  const schedule_id = params.get("schedule_id");
  const sclass = params.get("class");
  const { status, data: session } = useSession();
  const [seatPrice, setSeatPrice] = useState(0);
  const [discount, setDiscount] = useState({discount_percentage: 0, registered_user_category: 'General'});

  //console.log('this is form user',user);
  const [step, setStep] = useState(1);
  const [formData, setFormData] = useState({
    class: sclass,
    seatCount: props.count,
    passengers: Array.from({ length: props.count }, () => ({
      name: "",
      dob: "",
      passport_no: "",
    })),
    bookedSeats: [],
    price: seatPrice,
  });

  useEffect(() => {
    const getSeatPrice = async () => {
      const response = await fetch(
        `/api/getSeats/getSeatPrice?schedule_id=${schedule_id}&class=${sclass}`
      );
      const data = await response.json();
      setSeatPrice(data.price);
      console.log(data);
    };
    getSeatPrice();
  }, []);

  const [user, setUser] = useState(null);
  useEffect(() => {
    const getUser = async () => {
      const response = await fetch(
        `/api/getUser?user_id=${session?.user.user_id}`
      );
      const data = await response.json();
      setUser(data);
      //console.log('this is form data',data);
    };
    getUser();
  }, [session]);

  useEffect(() => {
    const getDiscount = async () => {
      const response = await fetch(
        `/api/getDiscount?user_id=${session?.user.user_id}`
      );
      const data = await response.json();
      setDiscount(data);
      //console.log('this is form data',data);
    };
    getDiscount();
  }, [session]);

  useEffect(() => {
    console.log(discount);
    setFormData(() => ({
      ...formData,
      user_category: discount.registered_user_category || 'Guest',
      discount: discount.discount_percentage || 0,
      price: seatPrice * (1-(discount.discount_percentage || 0)),
    }));
  }, [seatPrice, discount]);

  const nextStep = () => {
    setStep(step + 1);
  };

  const next3Step = () => {
    setStep(step + 3);
  };

  const prevStep = () => {
    setStep(step - 1);
  };

  const submitForm = () => {
      console.log('this is form',formData);
      let class_id;
      if (sclass == "Economy") {
        class_id = 3;
      } else if (sclass == "Business") {
        class_id = 2;
      } else {
        class_id = 1;
      }

      if(!session){
        const g = formData.passengers[0];
        const guest = {
          name: g.name,
          email: g.email,
          dob: g.dob,
          mobile_no: '0770929349',
          gender: 'Male',
          passport_no: g.passport_no,
          address: g.address,
          sch_id: schedule_id,
          seat_id: `S${formData.bookedSeats[0].toString().padStart(3, "0")}`,
          sc_id: class_id,
        }
        console.log(guest);
        fetch("/api/insertGuest", {
          method: "POST",
          headers: {
            "Content-Type": "application/json",
          },
          body: JSON.stringify(guest),
        })
          .then(async (response) => {
            if (!response.ok) {
              const res = await response.json();
              console.log(res);
              throw new Error(res.error);
            }
            return response.json();
          })
          .then((data) => {
            console.log("Success:", data);
            nextStep();
          })
          .catch((error) => {
            alert(error);
            console.log(error);
          });
      }
      else{
      const data = {
        schedule_id: schedule_id,
        seat_id: `S${formData.bookedSeats[0].toString().padStart(3, "0")}`,
        seat_class_id: class_id,
        user_id: session?.user.user_id,
        final_price: formData.price,
      };

      console.log("this is data", data);
      fetch("/api/insertBooking", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify(data),
      })
        .then(async (response) => {
          if (!response.ok) {
            const res = await response.json();
            console.log(res);
            throw new Error(res.error);
          }
          return response.json();
        })
        .then((data) => {
          console.log("Success:", data);
          nextStep();
        })
        .catch((error) => {
          alert(error);
          console.log(error);
        });
      }
    };

  if (status === "loading") return <LoadingPage />;
  else {
    switch (step) {
      case 1:
        return session ? (
          <PassengerForms
            user={user}
            count={props.count}
            formData={formData}
            setFormData={setFormData}
            nextStep={next3Step}
          />
        ) : (
          <div className="h-[calc(100vh-170px)] flex flex-col justify-center items-center font-nunito gap-4">
            <Link
              className="text-2xl font-nunito bg-primary text-white rounded-md py-5 px-20"
              href="/login"
            >
              Login
            </Link>
            <div onClick={nextStep} className="hover:cursor-pointer">
              Continue as Guest
            </div>
          </div>
        );
      case 2:
        return (
          <GuestForm
            formData={formData}
            setFormData={setFormData}
            nextStep={nextStep}
          />
        );
      case 3:
        return (
          <PassengerForms
            count={props.count}
            formData={formData}
            setFormData={setFormData}
            nextStep={nextStep}
          />
        );
      case 4:
        return (
          <SeatSelection
            schedule_id={schedule_id}
            count={props.count}
            class={sclass}
            formData={formData}
            setFormData={setFormData}
            nextStep={nextStep}
            prevStep={prevStep}
            submitForm={submitForm}
          />
        );
      case 5:
        return (
          <ConfirmPage
            formData={formData}
            prevStep={prevStep}
            handleSubmit={submitForm}
            class={sclass}
          />
        );
      case 6:
        return (
          <div className="flex flex-col gap-10 items-center">
            <h1 className="bg-fuchsia-600 text-white p-5 font-nunito text-xl rounded-md ">
              Booking Successful!
            </h1>
            <Link href='/'>
              <button className="w-full text-white text-center border border-transparent bg-primary font-nunito rounded-full py-2 px-6 transition duration-300 ease-in-out hover:shadow-secondary hover:shadow-md hover:bg-white hover:border-primary hover:text-primary">
                {" "}
                Go back home
              </button>
            </Link>
          </div>
        );
      default:
        return null;
    }
  }
}

export default function WrappedMultiStepForm(props) {
  return (
    <SessionProvider session={props.session}>
      <MultiStepForm {...props} />
    </SessionProvider>
  );
}
