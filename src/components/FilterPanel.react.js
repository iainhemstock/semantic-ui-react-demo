import React from 'react'
import { Segment, Header, Button } from 'semantic-ui-react'

import SearchInputFilter from './SearchInputFilter.react'
import RegionFilter from './RegionFilter.react'
import HeightFilterSlider from './HeightFilterSlider.react'

export default function FilterPanel(props) {
    return (
		<Segment.Group raised>

			<Segment>

				<Header 
					floated="left" 
					icon="filter" 
					content="Filter" 
					size="big" />
				
				<Button 
					floated="right" 
					negative 
					content="Reset filters" 
					size="mini"
					onClick={props.callbacks.onResetClick} />
			
			</Segment>
			
			<Segment style={{clear: "both"}}>
			
				<SearchInputFilter 
					value={props.searchTerm} 
					callbacks={{
						onChange: props.callbacks.onSearchTermChange
					}} />
			
			</Segment>

			<Segment>

				<RegionFilter
					regions={props.regions}
					callbacks={{
						onRegionChange: props.callbacks.onRegionChange,
						onAllRegionsClick: props.callbacks.onAllRegionsClick,
						onNoRegionsClick: props.callbacks.onNoRegionsClick
					}} />
			
			</Segment>
				
			<Segment padded="very">
			
				<HeightFilterSlider
					callbacks={{
						onRangeChange: props.callbacks.onHeightRangeChange
					}} />		
			
			</Segment>
			
		</Segment.Group>
    )
}


