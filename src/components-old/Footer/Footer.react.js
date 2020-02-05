import React from "react"
import { Grid, Container, Header, List } from "semantic-ui-react"

function Footer() {
    return (
        <Container fluid style={{backgroundColor:"#ddd"}}>
            <Container>
                <Grid>
                    <Grid.Column width="8">
                        <Header as="h1">
                            <Header.Content>About</Header.Content>
                        </Header>
                        <List link>
                            <List.Item as="a">Sitemap</List.Item>
                            <List.Item as="a">About us</List.Item>
                            <List.Item as="a">Contact</List.Item>
                        </List>
                    </Grid.Column>
                </Grid>
            </Container>
        </Container>
    )
}

export default Footer
