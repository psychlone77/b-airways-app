import React from 'react';
import { createBoard } from '@wixc3/react-board';
import { Navbar } from '../../../../components/navbar/navbar';

export default createBoard({
    name: 'Navbar',
    Board: () => <Navbar />,
    isSnippet: true,
    environmentProps: {
        canvasWidth: 746
    }
});
