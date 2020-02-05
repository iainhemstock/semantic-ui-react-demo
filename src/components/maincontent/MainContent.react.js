import React from 'react'
import { Segment, Container, Grid, Header, Image } from 'semantic-ui-react'

const segmentStyle = {
    paddingTop: "5em", 
    paddingBottom: "5em"
}

const headerStyle = {
    fontSize: "32px"
}

const paragraphStyle = {
    fontSize: "18px", 
    lineHeight: "26px"
}

export default function MainContent() {
    return (
        <React.Fragment>
            <Segment as="section" basic vertical style={segmentStyle}>
                <Container>
                    <Grid columns={2} centered stackable divided relaxed="very" verticalAlign="middle">
                        
                        <Grid.Column width={8}>
                            <Image src='https://via.placeholder.com/600x400' centered bordered />
                        </Grid.Column>
                        <Grid.Column width={8}>
                            <Header as="h1" style={headerStyle}>
                                It's quick and easy
                                <Header.Subheader as="p" style={paragraphStyle}>
                                    Proident quis summis ubi minim, veniam ingeniis est incurreret. Sed e quorum
                                    iudicem de nulla appellat cupidatat. Hic ingeniis firmissimum, ex ipsum occaecat
                                    relinqueret iis aute deserunt singulis, fugiat pariatur te officia. Ab malis
                                    nescius praesentibus.Nam cillum pariatur excepteur ex et ipsum incididunt
                                    deserunt.
                                </Header.Subheader>
                            </Header>
                            <Header as="h1" style={headerStyle}>
                                It's quick and easy
                                <Header.Subheader as="p" style={paragraphStyle}>
                                    Proident quis summis ubi minim, veniam ingeniis est incurreret. Sed e quorum
                                    iudicem de nulla appellat cupidatat. Hic ingeniis firmissimum, ex ipsum occaecat
                                    relinqueret iis aute deserunt singulis, fugiat pariatur te officia. Ab malis
                                    nescius praesentibus.Nam cillum pariatur excepteur ex et ipsum incididunt
                                    deserunt.
                                </Header.Subheader>
                            </Header>
                        </Grid.Column>
                    </Grid>
                </Container>
            </Segment>

            <Segment as="section" basic padded="very"
                style={{
                //    backgroundImage: "linear-gradient(to bottom right, #380036, #0cbaba)",
                    backgroundImage: "linear-gradient(to bottom right, #1F3E02, #DBEA8C)",
                   marginBottom: "1px"
                }}>
                <Container>
                    <Grid columns={2} centered stackable divided relaxed="very" verticalAlign="middle">
                        
                        <Grid.Column width={8}>
                            <Header as="h1" style={headerStyle} inverted>
                                It's quick and easy
                                <Header.Subheader as="p" style={paragraphStyle}>
                                    Proident quis summis ubi minim, veniam ingeniis est incurreret. Sed e quorum
                                    iudicem de nulla appellat cupidatat. Hic ingeniis firmissimum, ex ipsum occaecat
                                    relinqueret iis aute deserunt singulis, fugiat pariatur te officia. Ab malis
                                    nescius praesentibus.Nam cillum pariatur excepteur ex et ipsum incididunt
                                    deserunt.
                                </Header.Subheader>
                            </Header>
                            <Header as="h1" style={headerStyle} inverted>
                                It's quick and easy
                                <Header.Subheader as="p" style={paragraphStyle}>
                                    Proident quis summis ubi minim, veniam ingeniis est incurreret. Sed e quorum
                                    iudicem de nulla appellat cupidatat. Hic ingeniis firmissimum, ex ipsum occaecat
                                    relinqueret iis aute deserunt singulis, fugiat pariatur te officia. Ab malis
                                    nescius praesentibus.Nam cillum pariatur excepteur ex et ipsum incididunt
                                    deserunt.
                                </Header.Subheader>
                            </Header>
                        </Grid.Column>
                        <Grid.Column width={8}>
                            <Image src='https://via.placeholder.com/600x400' centered bordered />
                        </Grid.Column>
                    </Grid>
                </Container>
            </Segment>
        </React.Fragment>
    )
}
