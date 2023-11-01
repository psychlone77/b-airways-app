import { useState } from 'react';
import Report1 from './report1';
import Report2 from './report2';
import Report3 from './report3';
import Report4 from './report4';
import Report5 from './report5';

export default function Navigator(){
    const [activeReport, setActiveReport] = useState(1);

    const handleReportClick = (reportNumber) => {
        setActiveReport(reportNumber);
    }

    return(
        <div>
            <div className='flex flex-row gap-2 font-nunito text-xl justify-evenly mb-10'>
                <button onClick={() => handleReportClick(1)}>Report 1</button>
                <button onClick={() => handleReportClick(2)}>Report 2</button>
                <button onClick={() => handleReportClick(3)}>Report 3</button>
                <button onClick={() => handleReportClick(4)}>Report 4</button>
                <button onClick={() => handleReportClick(5)}>Report 5</button>
            </div>
            {activeReport === 1 && <Report1 />}
            {activeReport === 2 && <Report2 />}
            {activeReport === 3 && <Report3 />}
            {activeReport === 4 && <Report4 />}
            {activeReport === 5 && <Report5 />}
        </div>
    )
}

