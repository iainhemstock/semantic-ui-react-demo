import React from "react"
import { Container } from "semantic-ui-react"

import NavigationBar from "../NavigationBar/NavigationBar.react"
import Hero from "../Hero/Hero.react"

import styles from "./masthead.module.css"

export default () => {
    return (
        <Container className={styles.masthead} fluid>
            <NavigationBar />
            <Hero />
        </Container>
    )
}
