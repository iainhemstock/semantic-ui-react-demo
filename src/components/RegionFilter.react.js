import React from 'react'
import { List, Button, Checkbox } from 'semantic-ui-react'

import {Region} from '../util/Region'

export default function RegionFilter(props) {
    return (
        <React.Fragment>

			{regionCheckboxes(props)}
			{regionBtns(props)}

		</React.Fragment>
    )
}

const regionCheckboxes = (props) => {
	return (
		<List>

			{props.regions.map(region => {
				return <Checkbox 
					id={`region_${region.id}`}
					label={`${region.name} (${Region.FELL_COUNT[region.id]})`}
					checked={region.checked}
					onChange={props.callbacks.onRegionChange} />
			})}
		
		</List>
	)
}

const regionBtns = (props) => {
	return (
		<Button.Group fluid> 

			<Button onClick={props.callbacks.onAllRegionsClick}>Select all</Button>
			<Button.Or />
			<Button onClick={props.callbacks.onNoRegionsClick}>Select none</Button>
		
		</Button.Group>
	)
}

