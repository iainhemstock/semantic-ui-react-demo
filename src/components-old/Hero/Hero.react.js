import React from "react"
import { Segment, Header, Grid, Container } from "semantic-ui-react"
import styles from "./hero.module.css"

export default () => {
    return (
        <Container>
            <Grid stackable padded columns={1}>
                <Grid.Row className={styles.row}>
                    <Grid.Column width={8}>
                        <Segment raised padded="very" style={{backgroundColor: "rgb(0,0,0,0.5)"}}>
                            <Header as="h1" style={{color:"#fff"}}>Peak Bagging in the Lake District
                                <Header.Subheader style={{color:"#888"}}>
                                    The easiest way to log your bagged summits
                                </Header.Subheader>
                            </Header>
                        </Segment>
                    </Grid.Column>
                </Grid.Row>
            </Grid>
        </Container>
    )
}
