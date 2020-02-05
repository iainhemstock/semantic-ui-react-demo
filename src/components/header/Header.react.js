import React from 'react'
import Navigation from '../navigation/Navigation.react'
import Hero from '../hero/Hero.react'

import './header.css'

export default function Header() {
    return (
        <React.Fragment>
            <div className="background-image">
                <Navigation theme="transparent-theme" />
                <Hero />
            </div>
        </React.Fragment>
    )
}


