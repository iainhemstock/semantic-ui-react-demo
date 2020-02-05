import React from 'react'

import Header from '../components/header/Header.react'
import MainContent from '../components/maincontent/MainContent.react'
import Footer from '../components/footer/Footer.react'

export default function HomePage() {
    return (
        <React.Fragment>
            <Header />
            <MainContent />
            <Footer />
        </React.Fragment>
    )
} 