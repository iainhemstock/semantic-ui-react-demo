import React from 'react'
import { Image } from 'semantic-ui-react'

export default function Logo(props) {
    return (
        <Image
            src={require("../../images/" + props.src)}
            size="small"
            fixed />
    )
}
