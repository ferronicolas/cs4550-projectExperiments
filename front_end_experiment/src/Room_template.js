

import React, { Component } from 'react';
import { Label, DropdownButton, MenuItem, Form, Button, Image } from 'react-bootstrap'
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
                    <h4> <small> Administrator: fergie </small> </h4>
                </div>

                <div className="jumbotron col-sm-10 col-sm-offset-1" style={transparentBg} >
                <Image src="http://i0.kym-cdn.com/entries/icons/original/000/004/562/maxresdefault.jpg" rounded responsive/>
                <Image src="https://cdn2.hercampus.com/Discover_Weekly_-_Desktop.0.png" rounded responsive/>

                    <div className="panel panel-primary">

                        <div className="panel-heading">
                            <div className="row">
                                <Label bsClass="col-sm-6 text-left"> Users currently in room </Label>
                                <Label bsClass="col-sm-6 text-center"> Ranking</Label>
                            </div>
                        </div>

                        <div className="panel-body">
                            <ValueRowReal
                                room =  'fergie'
                                administrator = '1'
                                />

                            <ValueRowReal
                                room =  'zayn'
                                administrator = '2'
                                />

                            <ValueRowReal
                                room =  'lanadelrey'
                                administrator = '3'
                                />

                            <ValueRowReal
                                room =  'ariana'
                                administrator = '4'
                                />

                        </div>


                    </div>
                <Button bsStyle="danger">Unfollow Room</Button>

                <Button bsStyle="info">Leave Room</Button>

                <Button bsStyle="success">Share Room</Button>
                </div>
            </div>
        );
    }
}

export default App;