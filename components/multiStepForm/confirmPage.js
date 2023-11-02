export default function ConfirmPage(props) {
    const passenger = props.formData.passengers[0];
    return (
        <div className="flex flex-col items-center gap-2 bg-white font-nunito border border-primary rounded-md shadow-sm shadow-secondary p-5">
            <div className="flex flex-col items-start gap-2">
                <h1 className="text-xl text-primary font-semibold">Confirm Page</h1>
                <p>First Name: {passenger.name}</p>
                <p>Email: {passenger.email}</p>
                <p>Address: {passenger.address}</p>
                <p>Class: {props.class}</p>
                <p>Seat Number: {props.formData.bookedSeats}</p>
                <p>Member Level: {props.formData.user_category}</p>
                <p>Discount: {props.formData.discount*100}%</p>
                <p>Price: LKR.{props.formData.price}</p>
            </div>
            <div className="flex flex-col items-center gap-2 w-1/2">
                <button
                className="w-3/4 text-white border border-transparent bg-tertiary font-nunito rounded-full py-2 px-6 transition duration-300 ease-in-out hover:shadow-secondary hover:shadow-md hover:bg-white hover:border-tertiary hover:text-tertiary"
                onClick={props.prevStep}>Back</button>
                <button
                                        className="w-full text-white border border-transparent bg-primary font-nunito rounded-full py-2 px-6 transition duration-300 ease-in-out hover:shadow-secondary hover:shadow-md hover:bg-white hover:border-primary hover:text-primary"
                onClick={props.handleSubmit}>Submit</button>
            </div>
        </div>
    );
}