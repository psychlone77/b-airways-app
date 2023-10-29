export default function ConfirmPage(props) {
    
    return (
        <div>
            <h1>Confirm Page</h1>
            <p>First Name: {props.formData.firstName}</p>
            <p>Last Name: {props.formData.lastName}</p>
            <p>Email: {props.formData.email}</p>
            <p>Phone Number: {props.formData.phoneNumber}</p>
            <p>Flight Number: {props.formData.flightNumber}</p>
            <p>Departure Date: {props.formData.departureDate}</p>
            <p>Departure Time: {props.formData.departureTime}</p>
            <p>Departure Airport: {props.formData.departureAirport}</p>
            <p>Arrival Airport: {props.formData.arrivalAirport}</p>
            <p>Class: {props.formData.class}</p>
            <p>Booked Seats: {props.formData.bookedSeats}</p>
            <p>Price: {props.formData.price}</p>
            <button onClick={props.prevStep}>Back</button>
            <button onClick={props.handleSubmit}>Submit</button>
        </div>
    );
}