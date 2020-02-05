import React from 'react'

import TableGroup from './TableGroup.react'

export default function TableView(props) {
    const groups = props.groupingStrategy.execute()

    return (
        groups.map(group => {
            return (
                <TableGroup 
                    labelText={group.label}
                    fells={group.fells} />
            )
        })
    )
}




    
          