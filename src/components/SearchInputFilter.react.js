import React from 'react'
import { Input } from 'semantic-ui-react'

export default function SearchInputFilter(props) {
    return (
        <Input 
			fluid  
			label={{icon: "search"}}
			value={props.value}
			placeholder="Search by fell name..." 
			icon={{name: "delete", link: "true"}}
			iconPosition="right" 
			onChange={props.callbacks.onChange} />
    )
}