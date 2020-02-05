import React from 'react'
import { Segment, Label } from 'semantic-ui-react'

import ResultPanelBodyViewFactory from '../util/result_panel_body_view_factory'

/**
 * 
 * @param {*} param0 
 */
function ResultPanelHeader(props) {
    return (
        <Segment attached textAlign="center">

            <Label 
                as="h4"     
                icon="bullseye" 
                image 
                content={props.labelText}
                detail={214} 
                color="blue"
                style={{textAlign: "center"}} />

        </Segment>
    )
}

/**
 * 
 * @param {*} props 
 */
function ResultPanelBody(props) {
    return (
        <Segment attached="bottom" padded="very">
            
            {props.children}
        
        </Segment>
    )
}

/**
 * 
 * @param {*} props 
 */
export default function ResultPanel(props) { 
    return (
        <Segment.Group raised>

            <ResultPanelHeader 
                resultCount={props.resultCount}
                labelText={`Showing ${props.resultCount} results of`} />
            
            <ResultPanelBody>

                {ResultPanelBodyViewFactory.create(
                    props.viewType, 
                    props.groupType, 
                    props.sortType, 
                    props.fells)}
                    
            </ResultPanelBody>

    </Segment.Group>
    )
}