import React from 'react'
import { Segment, Header, Button } from 'semantic-ui-react'

import FellsViewTypeSelector from './ViewTypeSelector.react'
import FellGroupDropdown from './GroupDropdown.react'
import FellsSortDropdown from './SortDropdown.react'

export default function DisplayPanel(props) {
    return (
        <Segment.Group raised>

			<Segment>

				<Header 
					floated="left" 
					icon="compass" 
					content="Display" 
					size="big" />
				
				<Button 
					floated="right" 
					negative 
					content="Reset display" 
					size="mini" 
					onClick={props.callbacks.resetDisplayCallback} />
			
			</Segment>

			<Segment style={{clear: "both"}}>
            
			    <FellsViewTypeSelector 
                    activeViewType={props.activeViewType}
					onGridViewClick={props.callbacks.onGridViewClick} 
					onTableViewClick={props.callbacks.onTableViewClick}
					onMapViewClick={props.callbacks.onMapViewClick} /> 
			
			</Segment>

			<Segment.Group horizontal>

				<Segment>

					<FellGroupDropdown 
						callbacks={{
							onItemClick: props.callbacks.onGroupDropdownItemClick
						}} />

				</Segment>

				<Segment>

					<FellsSortDropdown 
						callbacks={{
							onItemClick: props.callbacks.onSortDropdownItemClick
						}} />

				</Segment>

			</Segment.Group>

		</Segment.Group>
    )
}