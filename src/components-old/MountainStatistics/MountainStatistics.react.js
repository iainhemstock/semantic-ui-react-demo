import React from "react"
import { Segment, Grid, Statistic } from "semantic-ui-react"

function MountainStatistics() {
    const numMountainsBagged = 200
    const totalMountains = 214

    return (
        <Segment raised secondary style={{margin:"50px 50px"}}>
            <Grid stackable stretched divided columns={3} textAlign="center">
                <Grid.Row verticalAlign="middle">
                    <Grid.Column>
                        <Statistic color="green">
                            <Statistic.Value>{numMountainsBagged}</Statistic.Value>
                            <Statistic.Label>mountains bagged!</Statistic.Label>
                        </Statistic>
                    </Grid.Column>
                    <Grid.Column>
                        <Statistic>
                            <Statistic.Value>{Math.round(numMountainsBagged / totalMountains * 100)}%</Statistic.Value>
                            <Statistic.Label>completed</Statistic.Label>
                        </Statistic>
                    </Grid.Column>
                    <Grid.Column>
                        <Statistic color="red">
                            <Statistic.Value>{totalMountains - numMountainsBagged}</Statistic.Value>
                            <Statistic.Label>mountains yet to be conquered!</Statistic.Label>
                        </Statistic>
                    </Grid.Column>
                </Grid.Row>
            </Grid>
        </Segment>
    )
}

export default MountainStatistics
