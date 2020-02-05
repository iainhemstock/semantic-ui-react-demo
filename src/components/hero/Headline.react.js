import React from 'react'
import { Header } from 'semantic-ui-react'

export default function Headline() {
    return (
        <React.Fragment>
            <Header as="h2" 
                className="wainwright"
                content="Wainwright" />

            <Header 
                as="h1" 
                className="headline" 
                content="Summit Logger" />
            
            {/* <Header 
                inverted 
                as="h2" 
                className="headline"
                content="for the Wainwright fells of the Lake District" /> */}
        </React.Fragment>
    )
}