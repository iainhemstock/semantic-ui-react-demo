import React from "react"
import { Dimmer, Loader, Grid } from "semantic-ui-react"

import {Group} from '../util/Group'
import {View} from '../util/View'
import {Sort} from "../util/Sort"
import Footer from '../components/footer/Footer.react'
import Navigation from '../components/navigation/Navigation.react'
import DisplayPanel from "../components/DisplayPanel.react"
import FilterPanel from '../components/FilterPanel.react'
import ResultPanel from "../components/ResultPanel.react"

export default class FellsPage extends React.Component {
    
    /**
     * 
     * @param {*} props 
     */
    constructor(props) {
        super(props)
        this.state = {
            fells: [],
            fellsHaveLoaded: false,
            regions: [],
            regionsHaveLoaded: false,
        viewType: View.MAP,
            groupType: Group.BY_HEIGHT,
            sortType: Sort.DESCENDING,
            searchTerm: "",
            filteredHeightRange: [298, 978]
        }
    }

    /**
     * 
     */
    componentDidMount = () => {
        this.loadRegions()
        this.loadFells()
    }

    /**
     * 
     */
    loadRegions = () => {
        let regions = []

        fetch(process.env.REACT_APP_REST_SERVICE_URL + "/regions")
        .then(res => res.json())
        .then(json => {
            json.forEach(region => regions.push({id: region.id, name: region.name, checked: true}))
            this.setState(() => {
                return {
                    regions: regions,
                    regionsHaveLoaded: true
                }
            })
        })
    }

    /**
     * 
     */
    loadFells = () => {
        fetch(process.env.REACT_APP_REST_SERVICE_URL + "/fells")
        .then(res => res.json())
        .then(json => {
            this.setState(() => {
                return {
                    fells: json,
                    fellsHaveLoaded: true,
                }
            })
        })
    }

    /**
     * 
     */
    dataHasLoaded = () => {
        const { fellsHaveLoaded, regionsHaveLoaded } = this.state
        return fellsHaveLoaded && regionsHaveLoaded
    }

    /**
     * 
     */
    render = () => {
        if (this.dataHasLoaded()) return this.dataHasLoadedJSX()
        else return this.dataHasNotLoadedYetJSX()
    }

    /**
     * 
     */
    dataHasNotLoadedYetJSX = () => {
        return (
            <Dimmer active>
                <Loader inverted>Fetching the fells...</Loader>
            </Dimmer>
        )
    }

    /**
     * 
     */
    dataHasLoadedJSX = () => {
        const filteredFells = this.applyFilters()
        
        return (
            <React.Fragment>

                <Navigation theme="dark-theme" />
                    
                    <Grid columns={2} stackable padded>
                
                        <Grid.Column width={4} style={{paddingRight: 50}}>

                            <DisplayPanel
                                activeViewType={this.state.viewType}
                                callbacks={{
                                    onGridViewClick: this.handleViewClick,
                                    onTableViewClick: this.handleViewClick,
                                    onMapViewClick: this.handleViewClick,
                                    onGroupDropdownItemClick: this.handleGroupByChange,
                                    onSortDropdownItemClick: this.handleSortByChange
                                }} />

                            <FilterPanel
                                searchTerm={this.state.searchTerm}
                                regions={this.state.regions}
                                callbacks={{
                                    onSearchTermChange: this.handleSearchTermChange,
                                    onRegionChange: this.handleRegionChange,
                                    onAllRegionsClick: this.handleSelectAllRegionsClick,
                                    onNoRegionsClick: this.handleSelectNoRegionsClick,
                                    onHeightRangeChange: this.handleHeightRangeChange,
                                    onResetClick: this.handleResetFiltersClick

                                }} />
                                
                        </Grid.Column>

                        <Grid.Column width={12}>

                            <ResultPanel
                                resultCount={filteredFells.length}
                                viewType={this.state.viewType}
                                groupType={this.state.groupType}
                                sortType={this.state.sortType}
                                fells={filteredFells} />

                        </Grid.Column>

                    </Grid>

                <Footer />

            </React.Fragment>
        )
    }

    /**
     * 
     */
    applyFilters = () => {
        const {fells, regions, filteredHeightRange} = this.state
        
        return fells.filter(fell => {
            const regionIsIncluded = regions.find(region => region.id === fell.location.region.id).checked
            const heightIsWithinRange = this.between(
                fell.height.meters, 
                filteredHeightRange[0], 
                filteredHeightRange[1])
            const nameIncludesSearchTerm = fell.name.toLowerCase().includes(this.state.searchTerm.toLowerCase())

            return regionIsIncluded && heightIsWithinRange && nameIncludesSearchTerm
        })
    }

    /**
     * 
     */
    between = (value, startRange, endRange) => {
        return value >= startRange && value <= endRange
    }

    /**
     * 
     */
    handleRegionChange = (ev, {id}) => {
        this.setState(prevState => {
            let updatedRegions = prevState.regions
            let selectedRegion = updatedRegions.find(region => id === `region_${region.id}`)
            selectedRegion.checked = !selectedRegion.checked

            return {
                regions: updatedRegions
            }
        })
    }

    /**
     * 
     */
    handleSelectAllRegionsClick = (ev) => {
        this.setState(prevState => {
            let updatedRegions = prevState.regions
            updatedRegions.forEach(region => region.checked = true)

            return {
                regions: updatedRegions
            }
        })
    }

    /**
     * 
     */
    handleSelectNoRegionsClick = (ev) => {
        this.setState(prevState => {
            let updatedRegions = prevState.regions
            updatedRegions.forEach(region => region.checked = false)

            return {
                regions: updatedRegions
            }
        })
    }

    /**
     * 
     */
    handleViewClick = (ev, {id}) => {
        let updatedViewType;
        
        switch (id) {
            case `view_${View.GRID}`: updatedViewType = View.GRID; break;
            case `view_${View.TABLE}`: updatedViewType = View.TABLE; break;
            case `view_${View.MAP}`: updatedViewType = View.MAP; break;
        }

        this.setState(() => {
            return {
                viewType: updatedViewType
            }
        })
    }

    /**
     * 
     */
    handleSearchTermChange = (ev, {value}) => {
        this.setState(() => {
            return {
                searchTerm: value,
                isUpdating: true
            }
        })
    }

    /**
     * 
     */
    handleHeightRangeChange = (newValues) => {
        this.setState(() => {
            return {
                filteredHeightRange: [newValues[0], newValues[1]]
            }
        })
    }

    /**
     * 
     */
    handleGroupByChange = (ev, {value}) => {
        this.setState(() => {
            return {
                groupType: value
            }
        })
    }

    /**
     * 
     */
    handleSortByChange = (ev, {value}) => {
        this.setState(() => {
            return {
                sortType: value
            }
        })
    }

    /**
     * 
     */
    handleResetFiltersClick = (ev, data) => {
        this.setState(prevState => {
            let updatedRegions = prevState.regions
            updatedRegions.forEach(region => region.checked = true)

            return {
                searchTerm: "",
                filteredHeightRange: [298, 978],
                regions: updatedRegions
            }
        })
    }
}

