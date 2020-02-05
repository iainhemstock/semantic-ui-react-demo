import React from "react"
import { Table, Label, Checkbox, Menu, Icon } from "semantic-ui-react"

function MountainTable() {
    return (
        <Table celled compact striped>
            <Table.Header>
              <Table.Row>
                <Table.HeaderCell collapsing></Table.HeaderCell>
                <Table.HeaderCell collapsing></Table.HeaderCell>
                <Table.HeaderCell collapsing></Table.HeaderCell>
                <Table.HeaderCell>Mountain</Table.HeaderCell>
                <Table.HeaderCell>Height (m)</Table.HeaderCell>
                <Table.HeaderCell>Region</Table.HeaderCell>
              </Table.Row>
            </Table.Header>

            <Table.Body>
              <Table.Row>
                <Table.Cell>
                  <Label ribbon color="green">Bagged</Label>
                </Table.Cell>
                <Table.Cell>
                    <Checkbox toggle checked="true" />
                </Table.Cell>
                <Table.Cell>1</Table.Cell>
                <Table.Cell>Scafell Pike</Table.Cell>
                <Table.Cell>978</Table.Cell>
                <Table.Cell>Southern</Table.Cell>
              </Table.Row>
              <Table.Row>
                <Table.Cell></Table.Cell>
                <Table.Cell>
                    <Checkbox toggle />
                </Table.Cell>
                <Table.Cell>2</Table.Cell>
                <Table.Cell>Scafell</Table.Cell>
                <Table.Cell>964</Table.Cell>
                <Table.Cell>Southern</Table.Cell>
              </Table.Row>
              <Table.Row>
                <Table.Cell></Table.Cell>
                <Table.Cell>
                    <Checkbox toggle />
                </Table.Cell>
                <Table.Cell>3</Table.Cell>
                <Table.Cell>Helvellyn</Table.Cell>
                <Table.Cell>950</Table.Cell>
                <Table.Cell>Eastern</Table.Cell>
              </Table.Row>
            </Table.Body>

            <Table.Footer>
              <Table.Row>
                <Table.HeaderCell colSpan='6'>
                  <Menu floated='right' pagination>
                    <Menu.Item as='a' icon>
                      <Icon name='chevron left' />
                    </Menu.Item>
                    <Menu.Item as='a'>1</Menu.Item>
                    <Menu.Item as='a'>2</Menu.Item>
                    <Menu.Item as='a'>3</Menu.Item>
                    <Menu.Item as='a'>4</Menu.Item>
                    <Menu.Item as='a' icon>
                      <Icon name='chevron right' />
                    </Menu.Item>
                  </Menu>
                </Table.HeaderCell>
              </Table.Row>
            </Table.Footer>
        </Table>
    )
}

export default MountainTable
