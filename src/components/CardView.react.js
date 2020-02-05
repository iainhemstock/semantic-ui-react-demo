import React from 'react'

import CardGroup from './CardGroup.react'

const NUM_CARDS_PER_ROW = 4

export default function CardView(props) {  
    const groups = props.groupingStrategy.execute()

    return (
        groups.map(group => {
            return (
                <CardGroup 
                    labelText={group.label}
                    fells={group.fells}
                    cardsPerRow={NUM_CARDS_PER_ROW} />
            )
        })
    )
}




  