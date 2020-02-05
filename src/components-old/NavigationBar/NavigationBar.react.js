import React from "react"
import { Menu, Image } from "semantic-ui-react"

export default function NavigationBar() {
    return (
        <Menu stackable inverted fixed borderless size="huge" style={{height: "100px"}}>
            <Menu.Item>
                <Image src={require("../../images/peak-bagger-logo.png")} size="small" />
            </Menu.Item>
            <Menu.Menu position="right">
                <Menu.Item name="About" onClick={() => {}} icon="question" />
                <Menu.Item name="Contact" onClick={() => {}} icon="mail" />
                <Menu.Item name="Support us" onClick={() => {}} icon="thumbs up" />
            </Menu.Menu>
        </Menu>
    )
}
