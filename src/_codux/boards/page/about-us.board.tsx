import React from 'react';
import { createBoard } from '@wixc3/react-board';
import AboutUs from '../../../../app/aboutUs/page';

export default createBoard({
    name: 'AboutUs',
    Board: () => <AboutUs />,
    isSnippet: true,
    environmentProps: {
        canvasWidth: 727
    }
});
