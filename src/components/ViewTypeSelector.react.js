import React from 'react'
import { Button, Icon } from 'semantic-ui-react'
import { View } from '../util/View'

export default function FellsViewTypeSelector(props) {
    const fontSize = "0.8em"
    return (
        <Button.Group fluid>

            <Button 
                id={`view_${View.MAP}`}
                active={props.activeViewType === View.MAP}
                animated="fade"
                onClick={props.onMapViewClick}
            >
                <Button.Content visible>
                    <Icon name="map" />
                </Button.Content>
                <Button.Content hidden style={{fontSize: fontSize}}>
                    Map view
                </Button.Content>
            </Button>

            <Button 
                id={`view_${View.GRID}`}
                active={props.activeViewType === View.GRID} 
                animated="fade" 
                onClick={props.onGridViewClick}
            >
                <Button.Content visible>
                    <Icon name="grid layout" />
                </Button.Content>
                <Button.Content hidden style={{fontSize: fontSize}}>
                    Grid view
                </Button.Content>
            </Button>
            
            <Button 
                id={`view_${View.TABLE}`}
                active={props.activeViewType === View.TABLE} 
                animated="fade" 
                onClick={props.onTableViewClick}
            >
                <Button.Content visible>
                    <Icon name="table" />
                </Button.Content>
                <Button.Content hidden style={{fontSize: fontSize}}>
                    Table view
                </Button.Content>
            </Button>

        </Button.Group>
    )
}