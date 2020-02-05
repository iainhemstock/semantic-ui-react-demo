import React from 'react'
import { Dimmer, Loader, Grid, Segment, Table, Header, Icon, Label } from 'semantic-ui-react'

import Navigation from '../../components/navigation/Navigation.react'
import Footer from '../../components/footer/Footer.react'

import './felldetailpage.css'

import { Map, TileLayer, Marker, Popup } from 'react-leaflet'

export default class FellDetailPage extends React.Component {
    constructor(props) {
        super(props)
        this.state = {
            isLoaded: false,
            fell: {
                id: props.match.params.id,
                name: "",
                height: {
                    feet: null,
                    meters: null
                },
                tallest_rank: null,
                region: {
                    id: null,
                    name: ""
                }
            }
        }
    }

    componentDidMount() {
        // fetch(`http://192.168.0.16:8181/lake-district-rest-api/fells/${this.state.fell.id}`)
        fetch(process.env.REACT_APP_REST_SERVICE_URL + `/fells/${this.state.fell.id}`)
            .then(res => res.json())
            .then(json => {
                this.setState(prevState => {
                    return {
                        isLoaded: true,
                        fell: {
                            id: prevState.id,
                            name: json.name,
                            height: {
                                feet: json.height.feet,
                                meters: json.height.meters
                            },
                            tallest_rank: json.tallest_rank,
                            region: {
                                id: json.region.id,
                                name: json.region.name
                            }
                        }
                    }
                })
            }
        )
    }

    render() {
        const {fell} = this.state
        return (
            this.state.isLoaded ? this.IsLoadedJSX(fell) : this.IsNotLoadedJSX()
        )
    }

    IsNotLoadedJSX() {
        return (
            <Dimmer active>
                <Loader inverted>Loading data</Loader>
            </Dimmer>
        )
    }

    IsLoadedJSX(fell) {
        return (
            <React.Fragment>
                <Navigation theme="dark-theme" />
                <Segment as="section" basic padded>
                    <Grid columns={2} verticalAlign="top" basic stackable container>
                        <Grid.Column>
                            {this.FellHeader(fell)}
                            {this.BaggedDetail(fell)}
                            
                        </Grid.Column>
                        <Grid.Column className="column-shadow">
                            {this.Map(fell)}
                            {this.FellDetailTable(fell)}
                        </Grid.Column>
                    </Grid>
                </Segment>
                <Footer />
            </React.Fragment>
        )
    }

    Map(fell) {
        const zoom = 13
        const position = [
            fell.location.coords.decimal.latitude, 
            fell.location.coords.decimal.longitude
        ]
        return (
            <Map center={position} zoom={zoom} style={{height: "300px"}}>

                <TileLayer
                    attribution='&amp;copy <a href="http://osm.org/copyright">OpenStreetMap</a> contributors'
                    url="https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png" />

                <Marker position={position}>
                
                    <Popup>
                        A pretty CSS3 popup. <br /> Easily customizable.
                    </Popup>
                
                </Marker>
            
            </Map>
        )
    }

    FellHeader(fell) {
        return (
            <Segment attached="top" className="fell-header-wrapper">
                <Header as="h1" className="fell-name-header">{fell.name}</Header>
                {this.FellHeaderMeta(fell)}
                
            </Segment>
        )
    }

    FellHeaderMeta(fell) {
        return (
            <Label.Group className="center-text" size="medium">
                <Label>
                    <Icon name="globe" />
                    {fell.region.name}
                </Label>
                <Label>
                    <Icon name="area graph" />
                    #{fell.tallest_rank} tallest Wainwright
                </Label>
                <Label>
                    <Icon name="book" />
                    Pictorial Guide to the Lake District Volume 1
                </Label>
            </Label.Group>
        )
    }

    BaggedDetail(fell) {
        return (
            <Segment attached raised className="bagged-detail">
                <Label.Group size="medium" className="center-text">
                    <Label size="large" style={{backgroundColor: "#87582D", color: "white"}}>
                        <Icon name="thumbs up" color="white" />
                        Bagged on 06/12/19
                    </Label>
                    <Label basic as="a" color="blue">
                        <Icon name="arrow alternate circle right" />
                        View details
                    </Label>
                </Label.Group>
            </Segment>
        )
    }

    FellDetailTable(fell) {
        const headerSize = "h4";
    
        return (
            <Table className="fell-detail-bg" attached="bottom" stackable>
                {this.FellHighestPointRow(fell, headerSize)}
                {this.FellProminenceRow(fell, headerSize)}
                {this.FellParentPeakRow(fell, headerSize)}
                {this.FellOSMapNumberRow(fell, headerSize)}
                {this.FellOSMapReferenceRow(fell, headerSize)}
                {this.FellCoordinates(fell, headerSize)}
                {this.FellClassificationsRow(fell, headerSize)}
            </Table>
        )
    }

    DetailRow(header, value, headerSize) {
        return (
            <Table.Row>
                <Table.Cell>
                    <Header as={headerSize}>{header}:</Header>
                </Table.Cell>
                <Table.Cell>
                    {value}
                </Table.Cell>
            </Table.Row>
        )
    }

    FellHighestPointRow(fell, headerSize) {
        return this.DetailRow(
            "Highest point", 
            `${fell.height.meters} meters / ${fell.height.feet} feet`, 
            headerSize)
    }

    FellProminenceRow(fell, headerSize) {
        return this.DetailRow(
            "Prominence",
            // <Icon name="question circle" size="tiny" />
            "N.A.",
            headerSize
        )
    }

    FellParentPeakRow(fell, headerSize) {
        return this.DetailRow(
            "Parent peak",
            "Snowdon",
            headerSize
        )
    }

    FellOSMapNumberRow(fell, headerSize) {
        return this.DetailRow(
            "OS map number",
            "Landrangers 89, Landrangers 90, Explorer OL6",
            headerSize
        )
    }

    FellOSMapReferenceRow(fell, headerSize) {
        return this.DetailRow(
            "OS map reference",
            "NY215072",
            headerSize
        )
    }

    FellCoordinates(fell, headerSize) {
        return this.DetailRow(
            "Coordinates",
            "54°27′15.2″N 3°12′41.5″W",
            headerSize
        )
    }

    FellClassificationsRow(fell, headerSize) {
        return this.DetailRow(
            "Classifications",
            "Marilyn, Hewitt, Hardy, Wainwright, County Top, Nuttall, Country high point",
            headerSize
        )
    }
}

