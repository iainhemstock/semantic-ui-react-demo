import React from 'react'

import {View} from './View'
import {Group} from './Group'
import CardView from '../components/CardView.react'
import TableView from '../components/TableView.react'
import MapView from '../components/MapView.react'

import GroupFellsByNameStrategy from './group_fells_by_name_strategy'
import GroupFellsByHeightStrategy from './group_fells_by_height_strategy'

export default class FellViewFactory {
    static create(fellViewType, groupType, sortType, fells) {

        let groupingStrategy = null

        switch(groupType) {
            case Group.BY_HEIGHT:
                groupingStrategy = new GroupFellsByHeightStrategy(fells, sortType)
                break
            case Group.BY_NAME:
                groupingStrategy = new GroupFellsByNameStrategy(fells, sortType)
                break
            default: throw "Factory could not create the requested grouping strategy as it is unknown."
        }

        switch(fellViewType) {
            case View.GRID: 
                return <CardView groupingStrategy={groupingStrategy} />
            case View.TABLE: 
                return <TableView groupingStrategy={groupingStrategy} />
            case View.MAP:
                return <MapView fells={fells} />

            default: throw "Factory could not create the requested fell view type as it is unknown."

        }
    }
}