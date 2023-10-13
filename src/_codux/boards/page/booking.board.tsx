import React from 'react';
import { createBoard } from '@wixc3/react-board';
import Booking from '../../../../app/booking/page';

export default createBoard({
    name: 'Booking',
    Board: () => <Booking />,
    isSnippet: true,
    environmentProps: {
        canvasWidth: 1223,
        windowWidth: 1920,
        windowHeight: 1080
    }
});
