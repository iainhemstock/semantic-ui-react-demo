import React from 'react'
import { Dropdown } from 'semantic-ui-react'

import { Group } from '../util/Group'

export default function FellGroupDropdown(props) {
    return (
        <Dropdown 
            text="Group by" 
            icon="clone" 
            labeled 
            button 
            floating 
            fluid
            className="icon" 
            style={{fontSize:"0.8em"}}>
            <Dropdown.Menu>
                <Dropdown.Item 
                    text="fell height" 
                    value={Group.BY_HEIGHT} 
                    icon="arrows alternate vertical" 
                    onClick={props.callbacks.onItemClick} />
                <Dropdown.Item 
                    text="fell name" 
                    value={Group.BY_NAME} 
                    icon="font" 
                    onClick={props.callbacks.onItemClick} />
            </Dropdown.Menu>
        </Dropdown>
    )
}