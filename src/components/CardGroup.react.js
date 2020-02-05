import React from 'react'
import { Header, Card, Image, Icon } from 'semantic-ui-react'

import mountainRidgeImage from '../images/mountain_ridge.jpg'
import {Region} from "../util/Region";

export default function CardGroup(props) {
    return (
        <React.Fragment>
            
            <Header 
                as="h1" 
                id={props.labelText} 
                content={props.labelText} 
                dividing
                style={{fontSize:"3em"}} />

            <Card.Group stackable itemsPerRow={props.cardsPerRow} style={{marginBottom: "100px"}}>
                
                {props.fells.map(fell => {
                    return (
                        <Card raised centered href={`/fells/${fell.id}`}>
                            <Image src={mountainRidgeImage} />
                            {/* <Label corner="right" icon="thumbs up" color="red" /> */}
                            <Card.Content>
                                <Card.Header>{fell.name}</Card.Header>
                                <Card.Meta><Icon name="compass" color={Region.COLOR[fell.region.id]} />{fell.region.name}</Card.Meta>
                                <Card.Description content={`${fell.height.meters}m`} />
                            </Card.Content>
                            {/* <Card.Content extra>
                                <Icon name="thumbs up" />
                                Bagged on 06/12/19
                            </Card.Content> */}
                            <div style={{height: "5px", minHeight: "5px", backgroundColor: Region.COLOR[fell.region.id]}} />
                        </Card>
                    )
                })}

            </Card.Group> 

        </React.Fragment>
    )
}