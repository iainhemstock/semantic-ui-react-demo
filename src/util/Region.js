// maps to `region.id` in the json response
export const Region = {
    EASTERN: 1,
    FAR_EASTERN: 2,
    CENTRAL: 3,
    SOUTHERN: 4,
    NORTHERN: 5,
    NORTH_WESTERN: 6,
    WESTERN: 7,

    NAME: [
        "",
        "Eastern",
        "Far eastern",
        "Central",
        "Southern",
        "Northern",
        "North western",
        "Western"
    ],

    FELL_COUNT: [
        null,
        35, // EASTERN
        36, // FAR_EASTERN,
        27, // CENTRAL
        30, // SOUTHERN
        24, // NORTHERN
        29, // NORTH_WESTERN
        33  // WESTERN
    ],

    // accessed with Region.color[Region.EASTERN]
    COLOR: [
        "",
        "red", // EASTERN
        "green", // FAR_EASTERN
        "blue", // CENTRAL
        "black", // SOUTHERN
        "teal", // NORTHERN
        "purple", // NORTH_WESTERN
        "yellow" // WESTERN
    ]
}