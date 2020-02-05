import FellGroup from './fell_group'
import { Sort } from './Sort'

export default class GroupFellsByHeightStrategy {
    _fells = []
    _fellGroups = []
    _sortType = null

    constructor(fells, sortType) {    
        this._fells = fells
        this._sortType = sortType
    }  

    execute = () => {
        this._addGroupIfNotEmpty(this._makeFellGroup("900m", [900, 1000]))
        this._addGroupIfNotEmpty(this._makeFellGroup("800m", [800, 900]))
        this._addGroupIfNotEmpty(this._makeFellGroup("700m", [700, 800]))
        this._addGroupIfNotEmpty(this._makeFellGroup("600m", [600, 700]))
        this._addGroupIfNotEmpty(this._makeFellGroup("500m", [500, 600]))
        this._addGroupIfNotEmpty(this._makeFellGroup("400m", [400, 500]))
        this._addGroupIfNotEmpty(this._makeFellGroup("300m", [300, 400]))
        this._addGroupIfNotEmpty(this._makeFellGroup("200m", [200, 300]))

        switch (this._sortType) {
            case Sort.ASCENDING: return this._fellGroups.reverse()
            case Sort.DESCENDING: return this._fellGroups
        }
    }
    
    _makeFellGroup = (label, heightRange) => {
        return new FellGroup(label, this._fells.filter(fell => {
            if (fell.height.meters >= heightRange[0]) {
                if (fell.height.meters < heightRange[1]) {
                    return true
                }
            }
            return false
        }))
    }

    _addGroupIfNotEmpty = (group) => {
        if (group.fells.length > 0)
            this._fellGroups.push(group)
    }
}