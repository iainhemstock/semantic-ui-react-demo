import React from 'react'
import { Slider, Rail, Handles, Tracks } from "react-compound-slider";

const sliderStyle = {
    position: "relative",
    width: "100%",
    height: 30
}

const railStyle = {
    position: "absolute",
    width: "100%",
    height: 10,
    marginTop: 10,
    borderRadius: 5,
    backgroundColor: "#8B9CB6"
}

export function Handle({
    handle: { id, value, percent },
    getHandleProps
  }) {
    return (
      <div
        style={{
          left: `${percent}%`,
          position: 'absolute',
          marginLeft: -10,
          marginTop: 5,
          zIndex: 2,
          width: 20,
          height: 20,
          border: 0,
          textAlign: 'center',
          cursor: 'pointer',
          borderRadius: '50%',
          backgroundColor: '#2C4870',
          color: '#333',
        }}
        {...getHandleProps(id)}
      >
        <div style={{ fontFamily: 'Roboto', fontSize: 11, marginTop: -15 }}>
          {value}
        </div>
      </div>
    )
  }

  function Track({ source, target, getTrackProps }) {
    return (
      <div
        style={{
          position: 'absolute',
          height: 10,
          zIndex: 1,
          marginTop: 10,
          backgroundColor: '#546C91',
          borderRadius: 5,
          cursor: 'pointer',
          left: `${source.percent}%`,
          width: `${target.percent - source.percent}%`,
        }}
        {...getTrackProps() /* this will set up events if you want it to be clickeable (optional) */}
      />
    )
  }

  export default function FellHeightFilterSlider(props) {
    return (
        <Slider
            onChange={props.callbacks.onRangeChange}
            rootStyle={sliderStyle}
            domain={[298, 978]}
            step={1}
            mode={2}
            values={[298, 978] /* three values = three handles */}
        >
            <Rail>
            {({ getRailProps }) => (
                <div style={railStyle} {...getRailProps()} />
            )}
            </Rail>
            <Handles>
            {({ handles, getHandleProps }) => (
                <div className="slider-handles">
                {handles.map(handle => (
                    <Handle
                    key={handle.id}
                    handle={handle}
                    getHandleProps={getHandleProps}
                    />
                ))}
                </div>
            )}
            </Handles>
            <Tracks left={false} right={false}>
            {({ tracks, getTrackProps }) => (
                <div className="slider-tracks">
                {tracks.map(({ id, source, target }) => (
                    <Track
                    key={id}
                    source={source}
                    target={target}
                    getTrackProps={getTrackProps}
                    />
                ))}
                </div>
            )}
            </Tracks>
        </Slider>
    )
  }