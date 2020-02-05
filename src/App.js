import React from 'react'
import { BrowserRouter, Switch, Route } from 'react-router-dom'

import HomePage from './pages/HomePage.react'
import FellsPage from './pages/FellsPage.react'
import FellDetailPage from './pages/felldetailpage/FellDetailPage.react'

import "./index.css"

export default function App() {
    return (
        <BrowserRouter>
            <Switch>
                <Route exact path="/" component={HomePage} />
                <Route path="/home" component={HomePage} />
                <Route exact path="/fells" component={FellsPage} />
                <Route path="/fells/:id" component={FellDetailPage} />
            </Switch>
        </BrowserRouter>
    )
}
