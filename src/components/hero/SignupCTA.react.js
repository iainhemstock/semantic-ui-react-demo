import React from 'react'
import { Container, Button } from 'semantic-ui-react'

import '../navigation/navigation.css'

const linkColor = {
    color: "#D5F0BC"
}

export default function SignupCTA() {
    return (
        <Container textAlign="center">
            <Button className="dark-theme" size="huge" style={{marginBottom: "5px"}}>
                Log your first summit now
            </Button>
            <a style={linkColor} href="/home">How does it work?</a>
        </Container>
    )
}
 