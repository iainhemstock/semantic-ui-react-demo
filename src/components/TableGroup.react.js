import React from 'react'
import { Link } from 'react-router-dom'
import { Table, Header, Image } from 'semantic-ui-react'

import mountainRidgeImage from '../images/mountain_ridge.jpg'

export default function TableGroup(props) {
    const colSpan = 4

    return (
        <Table striped celled structured style={{marginBottom: "100px"}}>
            
            {header(props.labelText, colSpan)}

            {body(props)}
            
        </Table>
    )
}

const header = (labelText, colSpan) => {
    return (
        <Table.Header>

            <Table.Row>
            
                <Table.HeaderCell colSpan={colSpan}>
                
                    <Header as="h1">{labelText}</Header>
                
                </Table.HeaderCell>
            
            </Table.Row>
            
            <Table.Row>
            
                <Table.HeaderCell />
                <Table.HeaderCell>Fell</Table.HeaderCell>
                <Table.HeaderCell>Meters</Table.HeaderCell>
                <Table.HeaderCell>Region</Table.HeaderCell>
            
            </Table.Row>
        
        </Table.Header>
    )
}

const body = ({fells}) => {
    return (
        <Table.Body>
            {fells.map(fell => {
                return (
                    <Table.Row>

                        <Table.Cell>

                            <Image src={mountainRidgeImage} size="tiny" />

                        </Table.Cell>
                        
                        <Table.Cell>
                        
                            <Link to={`/fells/${fell.id}`}>{fell.name}</Link>
                        
                        </Table.Cell>
                        
                        <Table.Cell>{fell.height.meters}</Table.Cell>
                        
                        <Table.Cell>{fell.region.name}</Table.Cell>
                    
                    </Table.Row>
                )
            })}
        </Table.Body>
    )
}