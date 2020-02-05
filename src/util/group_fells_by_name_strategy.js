import FellGroup from './fell_group'
import {Sort} from './Sort'

export default class GroupFellsByNameStrategy {
    _fells = []
    _fellGroups = []
    _sortType = null

    constructor(fells, sortType) {
        this._fells = fells
        this._sortType = sortType
    }

    execute = () => {
        this._addGroupIfNotEmpty(this._makeFellGroup("A"))
        this._addGroupIfNotEmpty(this._makeFellGroup("B"))
        this._addGroupIfNotEmpty(this._makeFellGroup("C"))
        this._addGroupIfNotEmpty(this._makeFellGroup("D"))
        this._addGroupIfNotEmpty(this._makeFellGroup("E"))
        this._addGroupIfNotEmpty(this._makeFellGroup("F"))
        this._addGroupIfNotEmpty(this._makeFellGroup("G"))
        this._addGroupIfNotEmpty(this._makeFellGroup("H"))
        this._addGroupIfNotEmpty(this._makeFellGroup("I"))
        this._addGroupIfNotEmpty(this._makeFellGroup("K"))
        this._addGroupIfNotEmpty(this._makeFellGroup("L"))
        this._addGroupIfNotEmpty(this._makeFellGroup("M"))
        this._addGroupIfNotEmpty(this._makeFellGroup("N"))
        this._addGroupIfNotEmpty(this._makeFellGroup("O"))
        this._addGroupIfNotEmpty(this._makeFellGroup("P"))
        this._addGroupIfNotEmpty(this._makeFellGroup("R"))
        this._addGroupIfNotEmpty(this._makeFellGroup("S"))
        this._addGroupIfNotEmpty(this._makeFellGroup("T"))
        this._addGroupIfNotEmpty(this._makeFellGroup("U"))
        this._addGroupIfNotEmpty(this._makeFellGroup("W"))
        this._addGroupIfNotEmpty(this._makeFellGroup("Y"))

        switch (this._sortType) {
            case Sort.ASCENDING:
                return this._fellGroups
            case Sort.DESCENDING:
                return this._fellGroups.reverse()
        }
    }

    _makeFellGroup = (letter) => {
        const filteredFells = this._fells.filter(fell => {
            return fell.name.toLowerCase().startsWith(letter.toLowerCase())
        })
        const sortedFells = filteredFells.sort((thisFell, thatFell) => {
            return (thisFell.name.toLowerCase() < thatFell.name.toLowerCase())
                ? -1
                : (thisFell.name.toLowerCase() > thatFell.name.toLowerCase())
                    ? 1
                    : 0
        })
        
        return new FellGroup(letter, sortedFells)
    }

    _addGroupIfNotEmpty = (group) => {
        if (group.fells.length > 0)
            this._fellGroups.push(group)
    }
}