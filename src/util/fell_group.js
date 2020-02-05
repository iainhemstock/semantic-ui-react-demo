export default class fell_group {
    _fells = []

    constructor(label, fells) {
        this._label = label
        this._fells = fells
    }

    get label() {
        return this._label
    }

    get fells() {
        return this._fells
    }
} 