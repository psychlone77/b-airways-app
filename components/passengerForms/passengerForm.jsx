import React, { useState } from "react";


export default function PassengerForm(props) {
  const [autoFill, setAutoFill] = useState(false);
  const ud = props.userdata;
  var curr = new Date(ud.dob);
  var date = curr.toISOString().substring(0, 10);

  const handleCheckboxChange = () => {
    setAutoFill(!autoFill); // Toggle the checkbox status
  };

  return (
    <div className="p-2 mb-5">
      <div className="p-5 rounded-3xl border border-gray-400 font-sans shadow-sm shadow-gray-400">
        <h3 className="mb-5 text-gray-700">Passenger {props.count}</h3>
        {props.count === 1 ? (
          <div className="mb-2">
            <label className="font-sans text-sm text-gray-800">
              <input
                type="checkbox"
                checked={autoFill} // Bind the checked property to the state variable
                onChange={handleCheckboxChange} // Handle checkbox change event
              />{" "}
              auto-fill
            </label>
          </div>
        ) : null}
        <form>
          <div className="flex flex-col gap-10">
            <div className="flex grid-cols-2 gap-3">
              <input
                className="flex-1 border border-gray-400 p-2 rounded-md h-10"
                type="text"
                placeholder={"First Name*"}
                defaultValue={autoFill ? ud.firstName : ""}
                readOnly={autoFill}
              />
              <input
                className="flex-1 border border-gray-400 p-2 rounded-md h-10"
                type="text"
                placeholder={"Middle Name"}
                defaultValue={autoFill ? ud.middlename : ""}
                readOnly={autoFill}
              />
              <input
                className="flex-1 border border-gray-400 p-2 rounded-md h-10"
                type="text"
                placeholder={"Last Name*"}
                defaultValue={autoFill ? ud.lastname : ""}
                readOnly={autoFill}
              />
            </div>
            <div className="w-1/4 flex grid-col-1 gap-3">
              <input
                className="flex-1 border border-gray-400 p-2 rounded-md h-10"
                type="date"
                placeholder={"Date of Birth*"}
                defaultValue={autoFill ? date : ""}
                readOnly={autoFill}
              />
            </div>
            <div className="w-1/2 flex grid-col-1 gap-3">
              <input
                className="flex-1 border border-gray-400 p-2 rounded-md h-10"
                type="email"
                placeholder={"Passport No.*"}
                defaultValue={autoFill ? ud.passportno : ""}
                readOnly={autoFill}
              />
            </div>
            <div className="flex grid-col-1 gap-3">
              <input
                className="flex-1 border border-gray-400 p-2 rounded-md h-10"
                type="text"
                placeholder={"Address*"}
                defaultValue={autoFill ? ud.address : ""}
                readOnly={autoFill}
              />
            </div>
          </div>
        </form>
      </div>
    </div>
  );
}
