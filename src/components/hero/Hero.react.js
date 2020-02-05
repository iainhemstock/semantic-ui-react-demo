import React from 'react'
import { Segment, Container, Grid, GridColumn, Divider } from 'semantic-ui-react'

import Headline from './Headline.react'
import Subheadline from './Subheadline.react'
import SignupCTA from './SignupCTA.react'

import './hero.css'

const dividerStyle = {
    backgroundColor: "#cacaca", 
    borderBottom: "1px solid #000", 
    marginBottom: "50px"
}

const gridStyle = {
    border: "1px solid rgba(0,0,0,0.2"
}

const segmentStyle = {
    backgroundColor: "rgba(0,0,0,0.5"
}

export default function Hero() {
    return (
        <Segment 
            as="section" 
            basic 
            // className="marginPaddingReset backgroundImage"
            className="marginPaddingReset"
        >
            <Container text textAlign="center">
                <Headline />

                <Divider style={dividerStyle} />

                <Segment style={segmentStyle}>
                    <Grid columns={2} stackable padded verticalAlign="middle" style={gridStyle}>
                        <GridColumn>
                            <Subheadline />
                        </GridColumn>
                        <GridColumn>
                            <SignupCTA />
                        </GridColumn>
                    </Grid>
                </Segment>

            </Container>
        </Segment>
    )
}
