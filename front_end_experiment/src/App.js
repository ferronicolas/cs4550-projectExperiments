import React, { Component } from 'react';
import { Label, DropdownButton, MenuItem, Form, Button,Image } from 'react-bootstrap'
import './App.css';


const ValueRowReal = ({room, administrator}) => (
    <div className="row panel">
        <Button bsClass ="col-sm-6 text-left" bsStyle="link">{room}</Button>
        <Label bsClass="col-sm-6 text-center">{administrator}</Label>
    </div>
);
const transparentBg = { background: 'transparent'}

class App extends Component {
    render() {

        return (
            <div className="App">
                <div className="page-header">
                <div className="col-sm-12 text-right">
                  <form className="form-inline">
                    <div className="form-group">
                      <div className="input-group">
                        <input type="number" className="form-control text-center" onChange='fdjsa' value='fsda' />
                        <div className="valuerow input-group-addon"> Search </div>
                    </div>
                </div>
            </form>
        </div>
                    <h3> Room Streaming Service </h3>
                    <h4> <small> Pick a room! </small> </h4>
                </div>

                <div className="jumbotron col-sm-10 col-sm-offset-1" style={transparentBg} >

                    <div className="panel panel-primary">

                        <div className="panel-heading">
                            <div className="row">
                                <Label bsClass="col-sm-6 text-left"> Room </Label>
                                <Label bsClass="col-sm-6 text-center"> Administrator</Label>
                            </div>
                        </div>

                        <div className="panel-body">
                            <ValueRowReal
                                room =  'Glamorous'
                                administrator = 'fergie'
                                />

                            <ValueRowReal
                                room =  'Dusk Til Dawn'
                                administrator = 'zayn'
                                />

                            <ValueRowReal
                                room =  'Lust for Life'
                                administrator = 'lanadelrey'
                                />

                            <ValueRowReal
                                room =  'moonlight'
                                administrator = 'ariana'
                                />

                        </div>


                    </div>
                <Button bsStyle="success">Create Room</Button>

                <Button bsStyle="info">Rooms Following</Button>
                </div>
            </div>
        );
    }
}

export default App;


