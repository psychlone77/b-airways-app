import React from "react";
import './page.css'

export default function Login() {
  return (
    <div className="home-container">
      <div className="home-container1">
        <h1 className="home-text10">Search Flights</h1>
        <div className="home-container2">
          <form className="home-form">
            <div className="home-container3">
              <div className="home-container4">
                <label className="home-text11">Origin</label>
                <input
                  type="text"
                  placeholder="Search"
                  className="home-textinput input"
                />
              </div>
              <div className="home-container5">
                <label className="home-text12">Destination</label>
                <input
                  type="text"
                  placeholder="Search"
                  className="home-textinput1 input"
                />
              </div>
              <div className="home-container6">
                <label className="home-text13">Date</label>
                <input
                  type="date"
                  placeholder="Search"
                  className="home-textinput2 input"
                />
              </div>
            </div>
          </form>
        </div>
        <div className="home-container7">
          <button type="button" className="home-button button">
            Search
          </button>
        </div>
      </div>
    </div>
  );
}
