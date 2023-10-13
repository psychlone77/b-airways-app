"use client"

import React, { useState } from "react";
import PassengerForm from "@/components/passengerForms/passengerForm";

export default function PassengerForms(props) {
    return (
      <div>
        {Array.from({ length: props.count }).map((_, index) => (
          <PassengerForm
            key={index}
            count={index + 1}
            userdata={props.userdata}
          />
        ))}
      </div>
    );
  }