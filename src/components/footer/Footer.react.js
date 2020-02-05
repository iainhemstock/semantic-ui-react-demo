import React from 'react'
import {
    Segment, Container, Header, List,
    Grid }
from 'semantic-ui-react'

import './footer.css'

export default function Footer() {
    return (
        <Segment as="section" vertical className="footer">
            <Container>
                <Grid stackable columns={3}>
                    <Grid.Column>
                        <Header inverted as="h4">About</Header>
                        <List link inverted>
                            <List.Item>
                                <List.Icon name="table" />
                                <List.Content>
                                    <a href="/home">All 214 Wainwright fells</a>
                                </List.Content>
                            </List.Item>
                            <List.Item>
                                <List.Icon name="mail" />
                                <List.Content>
                                    <a href="/home">Contact us</a>
                                </List.Content>
                            </List.Item>
                        </List>
                    </Grid.Column>
                    <Grid.Column>
                        <Header inverted as="h4">Fells by region</Header>
                        <List link inverted>
                            <List.Item>
                                <List.Icon name="compass outline" />
                                <List.Content>
                                    <a href="/home">Wainwright fells in the Northern region</a>
                                </List.Content>
                            </List.Item>
                            <List.Item>
                                <List.Icon name="compass outline" />
                                <List.Content>
                                    <a href="/home">Wainwright fells in the Eastern region</a>
                                </List.Content>
                            </List.Item>
                            <List.Item>
                                <List.Icon name="compass outline" />
                                <List.Content>
                                    <a href="/home">Wainwright fells in the Southern region</a>
                                </List.Content>
                            </List.Item>
                            <List.Item>
                                <List.Icon name="compass outline" />
                                <List.Content>
                                    <a href="/home">Wainwright fells in the Western region</a>
                                </List.Content>
                            </List.Item>
                            <List.Item>
                                <List.Icon name="compass outline" />
                                <List.Content>
                                    <a href="/home">Wainwright fells in the Central region</a>
                                </List.Content>
                            </List.Item>
                            <List.Item>
                                <List.Icon name="compass outline" />
                                <List.Content>
                                    <a href="/home">Wainwright fells in the Far Eastern region</a>
                                </List.Content>
                            </List.Item>
                            <List.Item>
                                <List.Icon name="compass outline" />
                                <List.Content>
                                    <a href="/home">Wainwright fells in the North Western region</a>
                                </List.Content>
                            </List.Item>
                        </List>
                    </Grid.Column>
                    <Grid.Column>
                        <Header inverted as="h4">Export</Header>
                        <List link inverted>
                        <List.Item>
                            <List.Icon name="download" />
                            <List.Content>
                                <a href="/home">Download your personal log</a>
                            </List.Content>
                        </List.Item>
                        </List>
                    </Grid.Column>
                </Grid>
            </Container>
        </Segment>
    )
}
