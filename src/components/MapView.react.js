import React from 'react'
import { Header, Label } from 'semantic-ui-react'
import { Map, TileLayer, Marker, Popup } from 'react-leaflet'

export default function MapView(props) {

    const fells = props.fells

    const zoom = 9
    const position = [54.6, -3.1]

    return (
        <Map center={position} zoom={zoom} style={{height: "500px"}}>

            <TileLayer
                url="https://{s}.tile.thunderforest.com/landscape/{z}/{x}/{y}.png"
                attribution='&copy; <a href="http://www.thunderforest.com/">Thunderforest</a>, &copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors' />
                {// attribution='&amp;copy <a href="http://osm.org/copyright">OpenStreetMap</a> contributors'
                // url="https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png" />
                }

                {fells.map(fell => {
                    const lat = fell.location.coords.decimal.latitude
                    const lon = fell.location.coords.decimal.longitude

                    return (
                        <Marker 
                            position={[lat, lon]}>

                            <Popup>
                                <Header content={fell.name} subheader={fell.location.region.name} />
                                <Label content={fell.location.coords.dms.formatted} />
                            </Popup>
                        </Marker>
                    )
                })}
        
        </Map>
    )
}