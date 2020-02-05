import React from "react"
import { Container } from "semantic-ui-react"

import MountainTable from "../MountainTable/MountainTable.react"
import MountainStatistics from "../MountainStatistics/MountainStatistics.react"

function Main() {
    return (
        <Container>
            <MountainStatistics />
            <MountainTable />
        </Container>
    )
}

export default Main
