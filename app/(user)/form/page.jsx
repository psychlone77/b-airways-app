import FlightDetails from "@/components/flightDetails/flightDetails";
import MultiStepForm from "../../../components/multiStepForm/multiStepForm";

export default function Form(){
    return (
        <div className="flex flex-row justify-between p-5 flex-wrap-reverse">
            <MultiStepForm count={1} class='business'/>
            <FlightDetails/>
        </div>
    )
}