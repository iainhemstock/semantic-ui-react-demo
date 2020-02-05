import React from 'react'
import { Header } from 'semantic-ui-react';

export default function Subheadline() {
    return (
        <React.Fragment>
            <Header as="h3" className="subheadline">
                A free personal log for
                hillwalkers and climbers
                to record their successful summits of the
                214 Wainwright fells in the Lake District
            </Header>
        </React.Fragment>
        
    )
}