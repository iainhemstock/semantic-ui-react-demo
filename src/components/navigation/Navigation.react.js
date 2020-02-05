import React from 'react'
import { Link } from 'react-router-dom'
import { Menu, Button } from 'semantic-ui-react'

import './navigation.css'
import Logo from "../logo/Logo.react"

export default function Navigation(props) {  
    return (
        <Menu as="nav" inverted borderless stackable attached="top" className={props.theme}>
            <Menu.Item>
                <Link to="/home">
                    <Logo src="peak-bagger-logo.png" />
                </Link>
                
            </Menu.Item>
            <Menu.Menu position="right">
                <Menu.Item>
                    <Link to="/fells">The Fells</Link>
                </Menu.Item>
                <Menu.Item>
                    <Link to="/*">About</Link>
                </Menu.Item>
                <Menu.Item>
                    <Link to="/*">Contact</Link>
                </Menu.Item>
                <Menu.Item>
                    <Link to="/*">Support us</Link>
                </Menu.Item>
                <Menu.Item>
                    <Button className={props.theme}>Get started</Button>
                </Menu.Item>
            </Menu.Menu>
        </Menu>
    )
}
