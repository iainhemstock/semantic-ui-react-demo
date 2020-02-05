import React from 'react'
import { Dropdown } from 'semantic-ui-react'

import { Sort } from '../util/Sort'

export default function FellsSortDropdown(props) {
    return (
        <Dropdown 
            text="Sort by" 
            icon="sort" 
            labeled 
            button 
            floating 
            fluid
            className="icon" 
            style={{fontSize:"0.8em"}}>
            <Dropdown.Menu>
                <Dropdown.Item 
                    text="descending" 
                    value={Sort.DESCENDING}
                    icon="sort amount down" 
                    onClick={props.callbacks.onItemClick} />
                <Dropdown.Item 
                    text="ascending" 
                    value={Sort.ASCENDING}
                    icon="sort amount up"
                    onClick={props.callbacks.onItemClick} /> 
            </Dropdown.Menu>
        </Dropdown>
    )
}